//
//  ViewController.swift
//  Seatbelt Savior
//
//  Created by Nicholas Perez-Aguilar on 11/20/18.
//  Copyright © 2018 Nicholas Perez-Aguilar. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    //MARK: Seat connections
    @IBOutlet weak var Driver_top_left_row_1: UIImageView!
    @IBOutlet weak var Passenger_right_row_1: UIImageView!
    @IBOutlet weak var Passenger_left_row_2: UIImageView!
    @IBOutlet weak var Passenger_right_row_2: UIImageView!
    @IBOutlet weak var Passenger_left_row_3: UIImageView!
    @IBOutlet weak var Passenger_right_row_3: UIImageView!
    
    // Bluetooth setup and UUIDs
    var centralManager: CBCentralManager!
    var ATMega1284: CBPeripheral?
    
    let ServiceUUID = CBUUID(string: "FFE0")
    let uC_CharacteristicUUID = CBUUID(string: "FFE1")
    var message = ""
    var count = 0
    
    // UI related items and default settings
    let default_driver = 0x01;
    let default_passenger_right_r1 = 0x02;
    let default_passenger_left_r2 = 0x04;
    let default_passenger_right_r2 = 0x08;
    let default_passenger_left_r3 = 0x10;
    let default_passenger_right_r3 = 0x20;
    //var keepScanning = false
    
    
    //MARK: Preloaded functions
    override func viewDidLoad() {
        super.viewDidLoad() // Already pre-defined by Xcode
        
        // Assigning default boolean values to the comparator for auto check out upon starting of program
        let driver_locked = default_driver
        let pass_right_r1 = default_passenger_right_r1
        let pass_left_r2 = default_passenger_left_r2
        let pass_right_r2 = default_passenger_right_r2
        let pass_left_r3 = default_passenger_left_r3
        let pass_right_r3 = default_passenger_right_r3

        // Need to make a function to parse through all the data!!!!
        test_hex(driver_locked)
        test_hex(pass_right_r1)
        test_hex(pass_left_r2)
        test_hex(pass_right_r2)
        test_hex(pass_left_r3)
        test_hex(pass_right_r3)
        
        // For Bluetooth
        centralManager = CBCentralManager()
        centralManager.delegate = self
    }

    
    //MARK: Actions
@IBAction func EnableDisable_right_r1(_ sender: UITapGestureRecognizer)
{
    if(Passenger_right_row_1.image == UIImage(named: "Disabled_seat"))
    {
        Passenger_right_row_1.image = UIImage(named: "Seats")
    }
    else
    {
        Passenger_right_row_1.image = UIImage(named: "Disabled_seat")
    }
    
}

@IBAction func EnableDisable_left_r2(_ sender: UITapGestureRecognizer)
{
    if(Passenger_left_row_2.image == UIImage(named: "Disabled_seat"))
    {
        Passenger_left_row_2.image = UIImage(named: "Seats")
    }
    else
    {
        Passenger_left_row_2.image = UIImage(named: "Disabled_seat")
    }
}

@IBAction func EnableDisable_right_r2(_ sender: UITapGestureRecognizer)
{
    if(Passenger_right_row_2.image == UIImage(named: "Disabled_seat"))
    {
        Passenger_right_row_2.image = UIImage(named: "Seats")
    }
    else
    {
        Passenger_right_row_2.image = UIImage(named: "Disabled_seat")
    }
}

@IBAction func EnableDisable_left_r3(_ sender: UITapGestureRecognizer)
{
    if(Passenger_left_row_3.image == UIImage(named: "Disabled_seat"))
    {
        Passenger_left_row_3.image = UIImage(named: "Seats")
    }
    else
    {
        Passenger_left_row_3.image = UIImage(named: "Disabled_seat")
    }
}

@IBAction func EnableDisable_right_r3(_ sender: UITapGestureRecognizer)
{
    if(Passenger_right_row_3.image == UIImage(named: "Disabled_seat"))
    {
        Passenger_right_row_3.image = UIImage(named: "Seats")
    }
    else
    {
        Passenger_right_row_3.image = UIImage(named: "Disabled_seat")
    }
}
 
    //MARK: Function call that sorts through data
    func test_hex(_ value:Int)
    {
        if(value == 0x01)
        {
            //print(value)
            print("Driver has status: GOOD")
            
            if(Driver_top_left_row_1.image != UIImage(named: "Seats") && Driver_top_left_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Driver_top_left_row_1.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x02)
        {
            //print(value)
            print("Passenger 2 has status: GOOD")
            
            if(Passenger_right_row_1.image != UIImage(named: "Seats") && Passenger_right_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_1.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x04)
        {
            //print(value)
            print("Passenger 3 has status: GOOD")
            
            if(Passenger_left_row_2.image != UIImage(named: "Seats") && Passenger_left_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_2.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x08)
        {
            //print(value)
            print("Passenger 4 has status: GOOD")
            
            if(Passenger_right_row_2.image != UIImage(named: "Seats") && Passenger_right_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_2.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x10)
        {
            //print(value)
            print("Passenger 5 has status: GOOD")
            
            if(Passenger_left_row_3.image != UIImage(named: "Seats") && Passenger_left_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_3.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x20)
        {
            //print(value)
            print("Passenger 6 has status: GOOD")
            
            if(Passenger_right_row_3.image != UIImage(named: "Seats") && Passenger_right_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_3.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x81)
        {
            //print(value)
            print("Driver has status: Unbuckled")
            
            if(Driver_top_left_row_1.image != UIImage(named: "Unbuckled") && Driver_top_left_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Driver_top_left_row_1.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x82)
        {
            //print(value)
            print("Passenger 2 has status: Unbuckled")
            if(Passenger_right_row_1.image != UIImage(named: "Unbuckled") && Passenger_right_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_1.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x84)
        {
            //print(value)
            print("Passenger 3 has status: Unbuckled")
            if(Passenger_left_row_2.image != UIImage(named: "Unbuckled") && Passenger_left_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_2.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x88)
        {
            //print(value)
            print("Passenger 4 has status: Unbuckled")
            if(Passenger_right_row_2.image != UIImage(named: "Unbuckled") && Passenger_right_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_2.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x90)
        {
            //print(value)
            print("Passenger 5 has status: Unbuckled")
            if(Passenger_left_row_3.image != UIImage(named: "Unbuckled") && Passenger_left_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_3.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0xA0)
        {
            //print(value)
            print("Passenger 6 has status: Unbuckled")
            if(Passenger_right_row_3.image != UIImage(named: "Unbuckled") && Passenger_right_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_3.image = UIImage(named: "Unbuckled")
            }
        }
        else
        {
            print("error\n")
        }
        
        if(Driver_top_left_row_1.image == UIImage(named: "Unbuckled") || Passenger_right_row_1.image == UIImage(named: "Unbuckled") || Passenger_left_row_2.image == UIImage(named: "Unbuckled") || Passenger_right_row_2.image == UIImage(named: "Unbuckled") || Passenger_left_row_3.image == UIImage(named: "Unbuckled") || Passenger_right_row_3.image == UIImage(named: "Unbuckled"))
        {
            warning_ignored()
        }
        else
        {
            print("Status: OKAY!")
        }
        
    }

    //MARK: Central Manager Delegate
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        if(central.state == .poweredOn)
        {
            centralManager.scanForPeripherals(withServices: [ServiceUUID], options: nil)
            message = "Your device is on and ready to pair"
        }
        else if(central.state == .poweredOff)
        {
            message = "Your device is powered off. Please turn Bluetooth on in your phone settings"
        }
        else if(central.state == .resetting)
        {
            message = "Device hardware is currently undergoing a reset, please wait and try again"
        }
        else if(central.state == .unauthorized)
        {
            message = "Your device is unauthorized to connect."
        }
        else if(central.state == .unknown)
        {
            message = "The Bluetooth device state is unknown. Please restart and try again and run test to ensure that your device is working properly"
        }
        else if(central.state == .unsupported)
        {
            message = "Your device doesn't support Bluetooth. Please try again on a supported device"
        }
        
        print("\n\n\nSystem message: \(message)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        centralManager.stopScan()
        ATMega1284 = peripheral
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral)
    {
        peripheral.delegate = self
        peripheral.discoverServices([ServiceUUID])
    }
    
    //MARK: Peripheral delegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
    {
        if let service = peripheral.services?.first(where:{$0.uuid == ServiceUUID})
        {
            peripheral.discoverCharacteristics([uC_CharacteristicUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    {
        if let characteristic = service.characteristics?.first(where: {$0.uuid == uC_CharacteristicUUID})
        {
            peripheral.setNotifyValue(true, for: characteristic)
            print("Did connect to HM-10 device")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
    {
        if let data = characteristic.value
        {
            let seat_status: Int = data.withUnsafeBytes{$0.pointee}
            test_hex(seat_status)
        }
    }
    
    // Delay Timer, used for counting time without seatbelt
    func warning_ignored()
    {
        print("Put your damn seatbelt on!!!")
        count += 1
        print("\n + \(count)")
        
        if(count == 60)
        {
            
        }
    }
    
}
