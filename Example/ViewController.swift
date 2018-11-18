//
//  ViewController.swift
//  Example
//
//  Created by Edward Hyde on 18/11/2018.
//  Copyright © 2018 Edward Hyde. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func testCppCall(_ sender: Any) {
        print("Called")
        hello_c("World".cString(using: String.Encoding.utf8))
        CPP_Wrapper().hello_cpp_wrapped("World")

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

