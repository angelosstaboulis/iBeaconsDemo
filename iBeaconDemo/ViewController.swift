//
//  ViewController.swift
//  iBeaconDemo
//
//  Created by Angelos Staboulis on 7/2/24.
//

import UIKit
import CoreBluetooth
import CoreLocation
class ViewController: UIViewController,CBPeripheralManagerDelegate {
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocalBeacon()
        // Do any additional setup after loading the view.
    }
    
    
}

extension ViewController{
    func initLocalBeacon() {
        if localBeacon != nil {
            stopLocalBeacon()
        }
        
        let localBeaconUUID = "3B807607-A24F-4256-B045-97D752B53C3C"
        
        let uuid = UUID(uuidString: localBeaconUUID)!

        localBeacon = CLBeaconRegion(uuid: uuid, identifier: "com.template.iBeaconDemo")
        beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        peripheralManager.delegate = self
    }
    func stopLocalBeacon() {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        beaconPeripheralData = nil
        localBeacon = nil
    }
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(beaconPeripheralData as? [String: Any])
        } else if peripheral.state == .poweredOff {
            peripheralManager.stopAdvertising()
        }
    }
}
