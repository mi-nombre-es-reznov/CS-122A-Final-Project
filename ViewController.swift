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
    
    @IBOutlet var Add_item_View: UIView!
    @IBOutlet weak var Visual_Effect_View: UIVisualEffectView!
    
    // Overlay that occurs when seatbelt hasn't been registered in over 10 seconds
    var effect:UIVisualEffect!
    // Bluetooth setup and UUIDs
    var centralManager: CBCentralManager!
    var ATMega1284: CBPeripheral?
    
    // Initializations
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
        
        // For overlay visual effect
        effect = Visual_Effect_View.effect
        Visual_Effect_View.effect = nil
        
        Add_item_View.layer.cornerRadius = 5
        
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

    // Used to fade in cover over left side of screen to cover status of vehicle and overlay appears
    func animateIn()
    {
        self.view.addSubview(Add_item_View)
        Add_item_View.center = self.view.center
        
        Add_item_View.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        Add_item_View.alpha = 0
        
        UIView.animate(withDuration: 0.4)
        {
            self.Visual_Effect_View.effect = self.effect
            self.Add_item_View.alpha = 1
            self.Add_item_View.transform = CGAffineTransform.identity
        }
    }
    // Used to fade in uncover over left side of screen to cover status of vehicle and overlay disappears
    func animateOut()
    {
        UIView.animate(withDuration: 0.3 , animations: {self.Add_item_View.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.Add_item_View.alpha = 0
            self.Visual_Effect_View.effect = nil}) { (success: Bool) in
                self.Add_item_View.removeFromSuperview()
        }
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
            if(Driver_top_left_row_1.image != UIImage(named: "Seats") && Driver_top_left_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Driver_top_left_row_1.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x02)
        {
            if(Passenger_right_row_1.image != UIImage(named: "Seats") && Passenger_right_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_1.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x04)
        {
            if(Passenger_left_row_2.image != UIImage(named: "Seats") && Passenger_left_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_2.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x08)
        {
            if(Passenger_right_row_2.image != UIImage(named: "Seats") && Passenger_right_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_2.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x10)
        {
            if(Passenger_left_row_3.image != UIImage(named: "Seats") && Passenger_left_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_3.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x20)
        {
            if(Passenger_right_row_3.image != UIImage(named: "Seats") && Passenger_right_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_3.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x81)
        {
            if(Driver_top_left_row_1.image != UIImage(named: "Unbuckled") && Driver_top_left_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Driver_top_left_row_1.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x82)
        {
            if(Passenger_right_row_1.image != UIImage(named: "Unbuckled") && Passenger_right_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_1.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x84)
        {
            if(Passenger_left_row_2.image != UIImage(named: "Unbuckled") && Passenger_left_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_2.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x88)
        {
            if(Passenger_right_row_2.image != UIImage(named: "Unbuckled") && Passenger_right_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_2.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0x90)
        {
            if(Passenger_left_row_3.image != UIImage(named: "Unbuckled") && Passenger_left_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_3.image = UIImage(named: "Unbuckled")
            }
        }
        else if(value == 0xA0)
        {
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
            count = 0
            animateOut()
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
        count += 1
        if(count == 60)
        {
            animateIn()
        }
    }
    
    
}
