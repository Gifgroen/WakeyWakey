//
//  ViewController.swift
//  Wakey Wakey
//
//  Created by Karsten Westra on 09/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        appNameLabel.text = "Wakey Wakey"
    }
}

