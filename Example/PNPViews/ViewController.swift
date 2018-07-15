//
//  ViewController.swift
//  PNPViews
//
//  Created by ehardacre on 07/15/2018.
//  Copyright (c) 2018 ehardacre. All rights reserved.
//

import UIKit
import PNPViews

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var menu = CurveMenu(view: self.view,
//                             buttonImage: #imageLiteral(resourceName: "button"),
//                             buttonImage2: #imageLiteral(resourceName: "button2"),
//                             color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
//                             buttonColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
//                             labels: ["menu 1","menu 2","menu 3","menu 4"],
//                             icons: [#imageLiteral(resourceName: "icon1"), #imageLiteral(resourceName: "icon2"), #imageLiteral(resourceName: "icon3"), #imageLiteral(resourceName: "icon4")],
//                             functions: [{
//                                    print("1")
//                                },{
//                                    print("2")
//                                },{
//                                    print("3")
//                                },{
//                                    print("4")
//                                }],
//                             textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        let menu = CurveMenu(view: self.view,
                              dimAlpha: 0.1,
                              buttonImage: #imageLiteral(resourceName: "button"),
                              buttonImage2: #imageLiteral(resourceName: "button2"),
                              color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                              buttonColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),
                              buttonColor2: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                              labels: ["menu 1","menu 2","menu 3","menu 4"],
                              icons: [#imageLiteral(resourceName: "icon1"), #imageLiteral(resourceName: "icon2"), #imageLiteral(resourceName: "icon3"), #imageLiteral(resourceName: "icon4")],
                              functions: [{
                                print("1")
                                },{
                                    print("2")
                                },{
                                    print("3")
                                },{
                                    print("4")
                                }],
                              textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        self.view.addSubview(menu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

