//
//  ViewController.swift
//  OddsConverter
//
//  Created by Jorge-Palomino on 01/12/2025.
//  Copyright (c) 2025 Jorge-Palomino. All rights reserved.
//

import OddsConverter
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var decOddsLabel: UILabel!
    @IBOutlet weak var ameOddsLabel: UILabel!
    @IBOutlet weak var fraOddsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            let odds = OddsConverter(odd: text)
            decOddsLabel.text = odds.getDecimal()
            ameOddsLabel.text = odds.getMoneyline()
            fraOddsLabel.text = odds.getFractional()
        }
    }
}
