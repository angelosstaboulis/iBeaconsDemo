//
//  ViewController.swift
//  iBeaconDemo
//
//  Created by Angelos Staboulis on 7/2/24.
//

import UIKit
import CoreBluetooth
import CoreLocation
class ViewController: UIViewController{
    let helper = Helper()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        helper.initLocalBeacon()

    }
    
}
