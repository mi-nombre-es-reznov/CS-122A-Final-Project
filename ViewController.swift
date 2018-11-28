//
//  ViewController.swift
//  Seatbelt_Savior
//
//  Created by Nicholas Perez-Aguilar on 11/20/18.
//  Copyright © 2018 Nicholas Perez-Aguilar. All rights reserved.
//

import UIKit

class ViewController:UIViewController {
    
    
    @IBOutlet weak var Driver_top_left_row_1: UIImageView!
    @IBOutlet weak var Passenger_left_row_2: UIImageView!
    @IBOutlet weak var Passenger_left_row_3: UIImageView!
    @IBOutlet weak var Passenger_right_row_1: UIImageView!
    @IBOutlet weak var Passenger_right_row_2: UIImageView!
    @IBOutlet weak var Passenger_right_row_3: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    
    
    
    
    
    
}
