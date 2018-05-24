//
//  ViewController.swift
//  YHRipple
//
//  Created by yuhua on 2018/5/24.
//  Copyright © 2018年 余华. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = YHRippleButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200), rippleColor: .blue)
        btn.setTitle("波纹", for: .normal)
        btn.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
        btn.center = view.center
        view.addSubview(btn)
    }
    
    @objc func tap(sender: YHRippleButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

