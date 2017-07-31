//
//  ViewController.swift
//  GetterSetterSwift
//
//  Created by DMITRY SINYOV on 28.07.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonTaped(_ sender: Any) {
        
        let testObject = TestableGetSet()
        
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
//            self.firstWriter(testObject: testObject)
//        }
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
//            self.secondWriter(testObject: testObject)
//        }
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
//            self.reader(testObject: testObject)
//        }
        
        let threadWriter1 = Thread.init(target: self, selector: #selector(firstWriter(testObject:)), object: testObject)
        let threadWriter2 = Thread.init(target: self, selector: #selector(secondWriter(testObject:)), object: testObject)
        let threadReader = Thread.init(target: self, selector: #selector(reader(testObject:)), object: testObject)
        
        threadWriter1.start()
        threadWriter2.start()
        threadReader.start()
    }
    
    func firstWriter(testObject: TestableGetSet) {
        for i in 0..<1000 {
            testObject.testField = "first \(i)"
        }
    }
    func secondWriter(testObject: TestableGetSet) {
        for i in 0..<1000 {
            testObject.testField = "second \(i)"
        }
    }
    func reader(testObject: TestableGetSet) {
        for _ in 0..<100 {
            print("current \(testObject.testField)")
        }
    }
}

