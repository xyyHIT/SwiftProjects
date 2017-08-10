//
//  ProductViewController.swift
//  GoodAsOldPhones
//
//  Created by xuyang on 2017/8/4.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productNameLabel.text = product?.name
        
        if let imageName = product?.fullScreenImageName {
            productImageView.image = UIImage(named: imageName)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        print("Add to Cart.")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
