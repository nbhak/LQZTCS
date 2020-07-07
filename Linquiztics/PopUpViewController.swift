//
//  PopUpViewController.swift
//  Linquiztics
//
//  Created by Nathan Bhak on 05/01/2018.
//  Copyright © 2018 Nathan Bhak. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    // Question type
    var questionType = 0
    // Outlet for clue label
    @IBOutlet weak var clueLabel: UILabel!
    // This method is called after the view controller has loaded its view hierarchy into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        // If a number question is being asked
        if questionType == 0{
            clueLabel.text = "NUMBERS:\n\n1 = un, 2 = u, 3 = re\n4 = ca, 5 = ci, 6 = se\n7 = sip, 8 = o, 9 = no\n\nRULES:\n\nAdd 'dec' after the number to make it a tens digit.\nPut the tens digit before the units digit to form the full number.\n'0' digits are left out.\n\nEXAMPLE:\n\nTo write 12 in code, you combine 'un', 'dec' and 'u', which makes 'undecu'."
        }
        // If an adjective question is being asked
        else if questionType == 1{
            clueLabel.text = "ADJECTIVES:\n\ndif = difficult\ndil = careful\ndiv = beautiful\n\nRULES:\n\nThe word-ending 'or' means 'more'.\nThe word-ending 'is' means 'the most'.\nHaving 'an' at the start means 'not'."
        }
        // If a verb question is being asked
        else if questionType == 2{
            clueLabel.text = "VERBS:\n\nin = en, out = e\nstroll = ambu, rush = cur\n\nRULES:\n\nRemove 'I' from the English sentence when translating\nAttach the preposition 'en' or 'e' to the start of the word.\n\nAdd 'vi' to the end to make it past tense."
        }
        // Translucent background colour
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HideClues(_ sender: Any) {
        self.view.removeFromSuperview()
    }

}
