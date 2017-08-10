//
//  ViewController.swift
//  URLImageDemo
//
//  Created by xuyang on 2017/8/7.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.size.width
let XYHeight = XYRect.size.height

let imageURL = "http://c.hiphotos.baidu.com/zhidao/pic/item/5ab5c9ea15ce36d3c704f35538f33a87e950b156.jpg"

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    let datas = ["普通打开", "普通下载", "自定义下载", "进度下载"]
    var images = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        for (index,(x,y)) in [(0,0),(1,0),(0,1),(1,1)].enumerated() {
            images.append(build(rect: CGRect(x: XYWidth/2*CGFloat(x), y: XYHeight/2*CGFloat(y), width: XYWidth/2, height: XYHeight/2), tag: index, title: datas[index]))
        }
    }

    func build(rect: CGRect, tag: Int, title: String) -> UIImageView {
        let imageV = UIImageView(frame: rect)
        imageV.contentMode = .center
        imageV.backgroundColor = .white
        imageV.clipsToBounds = true
        imageV.tag = tag
        let label = UILabel(frame: imageV.bounds)
        label.textAlignment = .center
        label.textColor = .orange
        label.text = title
        imageV.addSubview(label)
        view.addSubview(imageV)
        return imageV
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: nil) {
            switch (point.x, point.y) {
            case (0...XYWidth/2, 0...XYHeight/2):
                loadImage()
                print("左上")
            case (XYWidth/2...XYWidth, 0...XYHeight/2):
                downImage()
                print("右上")
            case (0...XYWidth/2, XYHeight/2...XYHeight):
                backgroundDownImage()
                print("左下")
            default:
                showLoadProgress()
                print("右下")
            }
        }
    }
    
    func loadImage() {
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                print("默认读取完毕。线程:\(Thread.current)")
                // 回归主线程
                DispatchQueue.main.async {
                    self.images.first?.image = UIImage(data: data!)
                }
            }).resume()
        }
    }
    
    func downImage() {
        if let url = URL(string: imageURL) {
            URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
                print("默认下载完毕，位置:\(String(describing: location?.path)).线程：\(Thread.current)")
                DispatchQueue.main.async {
                    do {
                        self.images[1].image = try UIImage(data: Data(contentsOf: location!))
                    } catch let err as NSError {
                        print("打开文件夹失败:\(String(describing: err.localizedFailureReason))")
                    }
                }
            }).resume()
        }
    }
    
    func backgroundDownImage() {
        if let url = URL(string: imageURL) {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            session.downloadTask(with: url, completionHandler: { (location, response, error) in
                print("自定义下载完毕，位置:\(String(describing: location?.path)). 线程：\(Thread.current)")
                DispatchQueue.main.async {
                    do {
                        self.images[2].image = try UIImage(data: Data(contentsOf: location!))
                    } catch let err as NSError {
                        print("打开文件失败：\(String(describing: err.localizedFailureReason))")
                    }
                }
            }).resume()
        }
    }
    
    func showLoadProgress() {
        if let url = URL(string: imageURL) {
            let session = URLSession(configuration: .background(withIdentifier: "download"), delegate: self, delegateQueue: nil)
            session.downloadTask(with: url).resume()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("代理下载完毕，位置：\(location.path), 线程：\(Thread.current)")
        DispatchQueue.main.async {
            do {
                self.images[3].image = try UIImage(data: Data(contentsOf: location))
            } catch let err as NSError {
                print("打开文件失败：\(String(describing: err.localizedFailureReason))")
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("下载进度：\(totalBytesWritten)/\(totalBytesExpectedToWrite)")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("从\(fileOffset)处恢复下载，共\(expectedTotalBytes)")
    }
}



