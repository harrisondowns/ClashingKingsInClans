//
//  ViewController.swift
//  ClashingKingsInClans
//
//  Created by Harrison Downs on 5/7/18.
//  Copyright © 2018 Harrison Downs. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    @IBOutlet var resource : NSTextField?
    @IBOutlet var units : NSTextField?
    @IBOutlet var hashes : NSTextField?
    
    var unitsn = 0
    var resourcen = 0
    
    var lastHash = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call timer
        Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(ViewController.hashFun), userInfo: nil, repeats: true)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // Md5 Function taken from https://stackoverflow.com/questions/32163848/how-to-convert-string-to-md5-hash-using-ios-swift?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
    
    // Call Md5 function on number
    func hashFun()
    {
        _ = MD5(string: lastHash.description)
        
        lastHash += 1
        updateHashes()
    }
    
    
    // update labels
    func updateResource(){
        resource!.stringValue = "RESOURCES: " + resourcen.description
    }
    func updateUnits(){
        units!.stringValue = "UNITS: " + unitsn.description
    }
    func updateHashes(){
        if (hashes != nil){
            hashes!.stringValue = "HASHES: " + lastHash.description
        }
    }
    
    @IBAction func spendMoney(sender: NSButton) {
        resourcen += 1000
        updateResource()
    }
    @IBAction func getResource(sender: NSButton) {
        resourcen += 1
        updateResource()
    }
    
    @IBAction func getUnit(sender: NSButton) {
        if (resourcen >= 10){
            unitsn += 1
            updateUnits()
            resourcen -= 10
            updateResource()
        }
        
        
    }

}

