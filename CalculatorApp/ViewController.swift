//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/05.
//

import UIKit

final class ViewController: UIViewController {
    
    var result = 0
    var inputNumber = 0
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        let number = Int(sender.currentTitle!)!
        inputNumber
        ResultLabel.text =
    }
    
}

private extension ViewController {
    
}
