//
//  ViewController.swift
//  SocketProgrammingExample
//
//  Created by Slbd on 3/8/17.
//  Copyright © 2017 Slbd. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController,NSStreamDelegate {
    
    //Used an echo server downloaded from //https://developer.apple.com/library/content/samplecode/CocoaEcho/Introduction/Intro.html
    let addr = "192.168.1.23"
    let port = 51670

    let connection = Connection()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //connecting to a definite address and port 
        connection.connect(addr, port: port)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

