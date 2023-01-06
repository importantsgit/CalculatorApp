//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/05.
//

import UIKit

final class ViewController: UIViewController {
    
    enum oper {
        case notClick
        case operClick
        case minus
        case divide
        case multiply
        case plus
    }
    
    var numberArray = ["","",""]
    var inputNumber = ""
    var operButtonTapped: oper = .notClick
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

}

private extension ViewController {
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        let number = sender.currentTitle!
        if operButtonTapped == .notClick || operButtonTapped == .operClick {
            numberArray[0] += number
            resultLabel.text = numberArray[0]
        } else {
            numberArray[1] += number
            resultLabel.text = numberArray[1]
        }
        //TODO: 삭제 요망
        calloutNumber()
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        if numberArray[0] == "0" {
            print("0을 나눌 수 없습니다")
        } else {
            operButtonTapped = .divide
            resultLabel.text = ""
        }

    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        operButtonTapped = .minus
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        operButtonTapped = .multiply
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        operButtonTapped = .plus
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        calculatingNumber()
        operButtonTapped = .operClick
        numberArray[0] = numberArray[2]
        numberArray[1] = ""
        numberArray[2] = ""
        resultLabel.text = numberArray[0]
        //TODO: 삭제 요망
        calloutNumber()
    }
    
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        operButtonTapped = .notClick
        resultLabel.text = ""
        for i in 0...2 {
            numberArray[i] = ""
        }
    }
    
    @IBAction func operButtonTapped(_ sender: UIButton) {
        resultLabel.text = ""
    }
    
    func calculatingNumber() {
        switch operButtonTapped {
        case .divide: numberArray[2] = String(Int(numberArray[0])! / Int(numberArray[1])!)
        case .minus : numberArray[2] = String(Int(numberArray[0])! - Int(numberArray[1])!)
        case .multiply : numberArray[2] = String(Int(numberArray[0])! * Int(numberArray[1])!)
        case .plus: numberArray[2] = String(Int(numberArray[0])! + Int(numberArray[1])!)
        case .notClick: print("Error: operator is notClicked")
        case .operClick: print("operator is Clicked")
        }
    }
    
    func calloutNumber() {
        print("A:\(numberArray[0]) B:\(numberArray[1]) C:\(numberArray[2]) oper:\(operButtonTapped)")
    }
}
