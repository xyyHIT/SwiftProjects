//
//  ViewController.swift
//  PictureBrowse
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height

let ItemWidth = XYWidth-40
let ItemHeight = XYHeight/3

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let backgroundImageView = UIImageView(frame: XYRect)
    var collectionView: UICollectionView!
    let data = CollectionCellModel.createInterests()
    let reuseIdentifier = "collectionCell"
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }
    
    func setupView() {
        backgroundImageView.image = UIImage(named: "saler")
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: ItemWidth, height: ItemHeight)//cell 大小
        collectionLayout.minimumLineSpacing = 20        //上下间隔
        collectionLayout.minimumInteritemSpacing = 20 // 左右间隔
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)// section边界
        collectionView = UICollectionView(frame: CGRect(x: 0, y: (XYHeight-ItemHeight)/2, width: XYWidth, height: ItemHeight), collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        visualEffectView.frame = XYRect
        
        view.addSubview(backgroundImageView)
        view.addSubview(collectionView)
        view.addSubview(visualEffectView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCell
        
        cell.data = self.data[indexPath.row]
        return cell
    }

}

