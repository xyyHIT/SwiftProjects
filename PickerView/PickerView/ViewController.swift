//
//  ViewController.swift
//  PickerView
//
//  Created by xuyang on 2017/8/6.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYHeight = XYRect.height
let XYWidth = XYRect.width

let pickerViewRect = CGRect(x: 0, y: XYHeight/3, width: XYWidth, height: XYHeight/3)
let labelRect = CGRect(x: 0, y: 20, width: XYWidth, height: XYHeight/3-20)
let btnRect = CGRect(x: 40, y: pickerViewRect.origin.y+pickerViewRect.size.height+30, width: XYWidth-80, height: 30)

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerView = UIPickerView(frame: pickerViewRect)
    let showLabel = UILabel(frame: labelRect)
    let btn = UIButton(frame: btnRect)
    
    let hours = 0...23
    let mins = 0...59
    let seconds = 0...59

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
        view.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: true)
        showLabel.textColor = .orange
        showLabel.textAlignment = .center
        showLabel.font = UIFont.systemFont(ofSize: 30, weight: 5)
        btn.setTitle("随机选择", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: 5)
        btn.addTarget(self, action: #selector(randomTime), for: .touchUpInside)
        
        view.addSubview(pickerView)
        view.addSubview(showLabel)
        view.addSubview(btn)
    }
    
    func randomTime() {
        pickerView.selectRow(Int(arc4random())%hours.count, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random())%mins.count, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random())%seconds.count, inComponent: 2, animated: true)
        changeLabel()
    }
    
    func changeLabel() {
        showLabel.text = "\(pickerView.selectedRow(inComponent: 0)) : \(pickerView.selectedRow(inComponent: 1)) : \(pickerView.selectedRow(inComponent: 2))"
    }
    
    // 实现代理方法
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return mins.count
        case 2:
            return seconds.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return XYWidth/3
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeLabel()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        switch component {
        case 0:
            pickerLabel.text = String(Array(hours)[row])+"时"
        case 1:
            pickerLabel.text = String(Array(mins)[row])+"分"
        case 2:
            pickerLabel.text = String(Array(seconds)[row])+"秒"
        default: break
        }
        
        pickerLabel.textColor = .green
        pickerLabel.font = UIFont.systemFont(ofSize: 18, weight: 5)
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
}

