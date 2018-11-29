//
//  ViewController.swift
//  Seatbelt_Savior
//
//  Created by Nicholas Perez-Aguilar on 11/20/18.
//  Copyright © 2018 Nicholas Perez-Aguilar. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    //MARK: Seat connections
    @IBOutlet weak var Driver_top_left_row_1: UIImageView!
    @IBOutlet weak var Passenger_left_row_2: UIImageView!
    @IBOutlet weak var Passenger_left_row_3: UIImageView!
    @IBOutlet weak var Passenger_right_row_1: UIImageView!
    @IBOutlet weak var Passenger_right_row_2: UIImageView!
    @IBOutlet weak var Passenger_right_row_3: UIImageView!
    
    // Disconnect button
    @IBOutlet weak var Disconnect_Button: UIButton!
    
    // define our scanning interval times for bluetooth
    let timerPauseInterval:TimeInterval = 10.0
    let timerScanInterval:TimeInterval = 2.0
    
    // UI related items and default settings
    let default_driver = 0x01;
    let default_passenger_right_r1 = 0x02;
    let default_passenger_left_r2 = 0x04;
    let default_passenger_right_r2 = 0x08;
    let default_passenger_left_r3 = 0x10;
    let default_passenger_right_r3 = 0x20;
    var keepScanning = false

    
    //MARK: Preloaded functions
    override func viewDidLoad() {
        super.viewDidLoad() // Already pre-defined by Xcode
        
        // Assigning default boolean values to the comparator for auto check out upon starting of program
        var driver_locked = default_driver
        var pass_right_r1 = default_passenger_right_r1
        var pass_left_r2 = default_passenger_left_r2
        var pass_right_r2 = default_passenger_right_r2
        var pass_left_r3 = default_passenger_left_r3
        var pass_right_r3 = default_passenger_right_r3
        
        // Need to make a function to parse through all the data!!!!
        test_hex(driver_locked)
        test_hex(pass_right_r1)
        test_hex(pass_left_r2)
        test_hex(pass_right_r2)
        test_hex(pass_left_r3)
        test_hex(pass_right_r3)
        
        //Keep seperate from original function calls
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            
            if(Driver_top_left_row_1.image != UIImage(named: "Seats") || Driver_top_left_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Driver_top_left_row_1.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x02)
        {
            //print(value)
            print("Passenger 2 has status: GOOD")
            
            if(Passenger_right_row_1.image != UIImage(named: "Seats") || Passenger_right_row_1.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_1.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x04)
        {
            //print(value)
            print("Passenger 3 has status: GOOD")
            
            if(Passenger_left_row_2.image != UIImage(named: "Seats") || Passenger_left_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_2.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x08)
        {
            //print(value)
            print("Passenger 4 has status: GOOD")
            
            if(Passenger_right_row_2.image != UIImage(named: "Seats") || Passenger_right_row_2.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_right_row_2.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x10)
        {
            //print(value)
            print("Passenger 5 has status: GOOD")
            
            if(Passenger_left_row_3.image != UIImage(named: "Seats") || Passenger_left_row_3.image != UIImage(named: "Disabled_seat"))
            {
                Passenger_left_row_3.image = UIImage(named: "Seats")
            }
        }
        else if(value == 0x20)
        {
            //print(value)
            print("Passenger 6 has status: GOOD")
            
            if(Passenger_right_row_3.image != UIImage(named: "Seats") || Passenger_right_row_3.image != UIImage(named: "Disabled_seat"))
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
    }
    
    //MARK: Bluetooth code inspired from Apple's Core Bluetooth documenation
    // Core Bluetooth properties
    var centralManager:CBCentralManager!
    var HM10:CBPeripheral?
    var Seatbelt_characteristic:CBCharacteristic?
    
    // This could be simplified to "SensorTag" and check if it's a substring.
    // (Probably a good idea to do that if you're using a different model of
    // the SensorTag, or if you don't know what model it is...)
    let HM10Name = "DSDTech"
    

    @IBAction func handleDisconnectButtonTapped(sender: AnyObject) {
        // if we don't have a sensor tag, start scanning for one...
        if HM10 == nil {
            keepScanning = true
            resumeScan()
            return
        } else {
            disconnect()
        }
    }
    
    func disconnect() {
        if let HM10 = self.HM10 {
            if let tc = self.Seatbelt_characteristic {
                HM10.setNotifyValue(false, for: tc)
            }
        centralManager.cancelPeripheralConnection(HM10)
        }
        Seatbelt_characteristic = nil
    }
            
            
    // MARK: - Bluetooth scanning
    
    @objc func pauseScan() {
        // Scanning uses up battery on phone, so pause the scan process for the designated interval.
        print("*** PAUSING SCAN...")
        _ = Timer(timeInterval: timerPauseInterval, target: self, selector: #selector(resumeScan), userInfo: nil, repeats: false)
        centralManager.stopScan()
        Disconnect_Button.isEnabled = true
    }

    @objc func resumeScan() {
        if keepScanning {
            // Start scanning again...
            print("*** RESUMING SCAN!")
            Disconnect_Button.isEnabled = false
            _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            Disconnect_Button.isEnabled = true
        }
    }
    
    
    // MARK: - CBCentralManagerDelegate methods
    
    // Invoked when the central manager’s state is updated.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var showAlert = true
        var message = ""
        
        switch central.state {
        case .poweredOff:
            message = "Bluetooth on this device is currently powered off."
        case .unsupported:
            message = "This device does not support Bluetooth Low Energy."
        case .unauthorized:
            message = "This app is not authorized to use Bluetooth Low Energy."
        case .resetting:
            message = "The BLE Manager is resetting; a state update is pending."
        case .unknown:
            message = "The state of the BLE Manager is unknown."
        case .poweredOn:
            showAlert = false
            message = "Bluetooth LE is turned on and ready for communication."
            
            print(message)
            keepScanning = true
            _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            
            // Initiate Scan for Peripherals
            //Option 1: Scan for all devices
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            
            // Option 2: Scan for devices that have the service you're interested in...
            //let sensorTagAdvertisingUUID = CBUUID(string: Device.SensorTagAdvertisingUUID)
            //print("Scanning for SensorTag adverstising with UUID: \(sensorTagAdvertisingUUID)")
            //centralManager.scanForPeripheralsWithServices([sensorTagAdvertisingUUID], options: nil)
            
        }
        
        if showAlert {
            let alertController = UIAlertController(title: "Central Manager State", message: message, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(okAction)
            self.show(alertController, sender: self)
        }
    }
    
    /*
     Invoked when the central manager discovers a peripheral while scanning.
     
     The advertisement data can be accessed through the keys listed in Advertisement Data Retrieval Keys.
     You must retain a local copy of the peripheral if any command is to be performed on it.
     In use cases where it makes sense for your app to automatically connect to a peripheral that is
     located within a certain range, you can use RSSI data to determine the proximity of a discovered
     peripheral device.
     
     central - The central manager providing the update.
     peripheral - The discovered peripheral.
     advertisementData - A dictionary containing any advertisement data.
     RSSI - The current received signal strength indicator (RSSI) of the peripheral, in decibels.
     
     */
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("centralManager didDiscoverPeripheral - CBAdvertisementDataLocalNameKey is \"\(CBAdvertisementDataLocalNameKey)\"")
        
        // Retrieve the peripheral name from the advertisement data using the "kCBAdvDataLocalName" key
        if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            print("NEXT PERIPHERAL NAME: \(peripheralName)")
            print("NEXT PERIPHERAL UUID: \(peripheral.identifier.uuidString)")
            
            if peripheralName == HM10Name {
                print("SENSOR TAG FOUND! ADDING NOW!!!")
                // to save power, stop scanning for other devices
                keepScanning = false
                Disconnect_Button.isEnabled = true
                
                // save a reference to the sensor tag
                HM10 = peripheral
                HM10!.delegate = self
                
                // Request a connection to the peripheral
                centralManager.connect(HM10!, options: nil)
            }
        }
    }
    
    /*
     Invoked when a connection is successfully created with a peripheral.
     
     This method is invoked when a call to connectPeripheral:options: is successful.
     You typically implement this method to set the peripheral’s delegate and to discover its services.
     */
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("**** SUCCESSFULLY CONNECTED TO HM10 device!!!")
        
        // Now that we've successfully connected to the SensorTag, let's discover the services.
        // - NOTE:  we pass nil here to request ALL services be discovered.
        //          If there was a subset of services we were interested in, we could pass the UUIDs here.
        //          Doing so saves battery life and saves time.
        peripheral.discoverServices(nil)
    }
    
    /*
     Invoked when the central manager fails to create a connection with a peripheral.
     
     This method is invoked when a connection initiated via the connectPeripheral:options: method fails to complete.
     Because connection attempts do not time out, a failed connection usually indicates a transient issue,
     in which case you may attempt to connect to the peripheral again.
     */
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("**** CONNECTION TO SENSOR TAG FAILED!!!")
    }
    
    /*
     Invoked when an existing connection with a peripheral is torn down.
     
     This method is invoked when a peripheral connected via the connectPeripheral:options: method is disconnected.
     If the disconnection was not initiated by cancelPeripheralConnection:, the cause is detailed in error.
     After this method is called, no more methods are invoked on the peripheral device’s CBPeripheralDelegate object.
     
     Note that when a peripheral is disconnected, all of its services, characteristics, and characteristic descriptors are invalidated.
     */
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("**** DISCONNECTED FROM HM10 device!!!")
        if error != nil {
            print("****** DISCONNECTION DETAILS: \(error!.localizedDescription)")
        }
        HM10 = nil
    }
    
    //MARK: - CBPeripheralDelegate methods
    
    /*
     Invoked when you discover the peripheral’s available services.
     
     This method is invoked when your app calls the discoverServices: method.
     If the services of the peripheral are successfully discovered, you can access them
     through the peripheral’s services property.
     
     If successful, the error parameter is nil.
     If unsuccessful, the error parameter returns the cause of the failure.
     */
    // When the specified services are discovered, the peripheral calls the peripheral:didDiscoverServices: method of its delegate object.
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if error != nil {
            print("ERROR DISCOVERING SERVICES: \(error?.localizedDescription)")
            return
        }
        
        // Core Bluetooth creates an array of CBService objects —- one for each service that is discovered on the peripheral.
        if let services = peripheral.services {
            for service in services {
                print("Discovered service \(service)")
                // If we found either the temperature or the humidity service, discover the characteristics for those services.
                if (service.uuid == CBUUID(string: Device.TemperatureServiceUUID)) ||
                    (service.uuid == CBUUID(string: Device.HumidityServiceUUID)) {
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            }
        }
    }
    
    
    
    func sizeof <T> (_ : T.Type) -> Int
    {
        return (MemoryLayout<T>.size)
    }
    
    /*
     Invoked when you discover the characteristics of a specified service.
     
     If the characteristics of the specified service are successfully discovered, you can access
     them through the service's characteristics property.
     
     If successful, the error parameter is nil.
     If unsuccessful, the error parameter returns the cause of the failure.
     */
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if error != nil {
            print("ERROR DISCOVERING CHARACTERISTICS: \(error?.localizedDescription)")
            return
        }
        
        
        
        if let characteristics = service.characteristics {
            var enableValue:UInt8 = 1
            let enableBytes = NSData(bytes: &enableValue, length: sizeof(UInt8.self))
            
            for characteristic in characteristics {
                // Temperature Data Characteristic
                if characteristic.uuid == CBUUID(string: Device.TemperatureDataUUID) {
                    // Enable the IR Temperature Sensor notifications
                    Seatbelt_characteristic = characteristic
                    HM10?.setNotifyValue(true, for: characteristic)
                }
                
                // Temperature Configuration Characteristic
                if characteristic.uuid == CBUUID(string: Device.TemperatureConfig) {
                    // Enable IR Temperature Sensor
                    HM10?.writeValue(enableBytes as Data, for: characteristic, type: .withResponse)
                }
                
                test_hex(Int(enableValue))
            }
        }
    }
    

    
    func Change_pics(data:NSData) {
        // We'll get four bytes of data back, so we divide the byte count by two
        // because we're creating an array that holds two 16-bit (two-byte) values
        let dataLength = data.length / sizeof(UInt32.self)
        
        // 1
        // create an array to contain the 16-bit values
        var dataArray = [UInt32](repeating: 0, count:dataLength)
        
        // 2
        // extract the data from the dataBytes object
        data.getBytes(&dataArray, length: dataLength * sizeof(Int32.self))
        
        // 3
        // get the value of the of the ambient temperature element
        let seatValue:UInt32 = dataArray[Device.SensorDataIndexTempAmbient]
        test_hex(Int(seatValue))
        
        /*
        // 4
        // convert the ambient temperature
        let ambientTempC = Double(rawAmbientTemp) / 128.0
        let ambientTempF = convertCelciusToFahrenheit(ambientTempC)
        
        // 5
        // Use the Ambient Temperature reading for our label
        let temp = Int(ambientTempF)
        lastTemperature = temp
        
        // If the application is active and in the foreground, update the UI
        if UIApplication.sharedApplication().applicationState == .Active {
            updateTemperatureDisplay()
        }*/
    }
    
    
    /*
     Invoked when you retrieve a specified characteristic’s value,
     or when the peripheral device notifies your app that the characteristic’s value has changed.
     
     This method is invoked when your app calls the readValueForCharacteristic: method,
     or when the peripheral notifies your app that the value of the characteristic for
     which notifications and indications are enabled has changed.
     
     If successful, the error parameter is nil.
     If unsuccessful, the error parameter returns the cause of the failure.
     */
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if error != nil {
            print("ERROR ON UPDATING VALUE FOR CHARACTERISTIC: \(characteristic) - \(error?.localizedDescription)")
            return
        }
        
        // extract the data from the characteristic's value property and display the value based on the characteristic type
        if let dataBytes = characteristic.value {
            if characteristic.uuid == CBUUID(string: Device.TemperatureDataUUID) {
                Change_pics(data: dataBytes as NSData)
            }
        }
    }
    
}
    
    
    
    
    
    
    
    
    

