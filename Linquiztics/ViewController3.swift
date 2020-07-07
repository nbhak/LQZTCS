//
//  ViewController3.swift
//  Linquiztics
//
//  Created by Nathan Bhak on 02/01/2018.
//  Copyright © 2018 Nathan Bhak. All rights reserved.
//

//import framework
import UIKit

//This view controller manages the instructions screen
class ViewController3: UIViewController {
    // Back button
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add curvature to back button
        backButton.layer.cornerRadius = 5
        backButton.clipsToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
