//
//  ViewController.swift
//  CowsBulls
//
//  Created by Abraham Abreu on 17/03/22.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var tableView: NSTableHeaderView!
    @IBOutlet var guess: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submitGuess(_ sender: NSButton) {
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

