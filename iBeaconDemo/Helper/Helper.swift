//
//  Helper.swift
//  iBeaconDemo
//
//  Created by Angelos Staboulis on 7/2/24.
//

import Foundation
import CoreLocation
import CoreBluetooth
class Helper:NSObject,CBPeripheralManagerDelegate{
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    func createValues()->(CLBeaconRegion,NSDictionary,CBPeripheralManager){
        let localBeaconUUID = "3B807607-A24F-4256-B045-97D752B53C3C"
        let uuid = UUID(uuidString: localBeaconUUID)!
        let localBeacon = CLBeaconRegion(uuid: uuid, identifier: "com.template.iBeaconDemo")
        let beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
        let peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        peripheralManager.delegate = self
        return (localBeacon,beaconPeripheralData,peripheralManager)
    }
    func initLocalBeacon() {
        if self.localBeacon != nil {
            stopLocalBeacon()
        }
        self.localBeacon = createValues().0
        self.beaconPeripheralData = createValues().1
        self.peripheralManager = createValues().2
        self.peripheralManager.delegate = self
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
