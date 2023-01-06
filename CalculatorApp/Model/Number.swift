//
//  Number.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/06.
//

import Foundation

class NumberModel {
    private var numberArray = ["","",""]{
        didSet {
            calloutNumber()
        }
    }
    private var operButtonTapped: Oper = .notClick
    
    func resetArray() {
        operButtonTapped = .notClick
        for i in 0...2 {
            numberArray[i] = ""
        }
    }
    
    func getOperButtonTapped() -> Oper {
        return operButtonTapped
    }
    
    func setOperButtonTapped(oper: Oper) {
        self.operButtonTapped = oper
    }
    
    func setResult(number: String) {
        self.numberArray[2] = number
    }
    
    func resultButtonTapped() -> String {
        getSolution()
        setOperButtonTapped(oper: .operClick)
        numberArray[0] = numberArray[2]
        numberArray[1] = ""
        numberArray[2] = ""
        return numberArray[0]
    }
    
    func getPrevNumber() -> String {
        return numberArray[0]
    }
    
    func setPrevNumber(number: String) {
        numberArray[0] = number
    }
    
    func addingPrevNumber(number: String) {
        numberArray[0] += number
    }
    
    func isActivePrevNumber() -> Bool {
        if !numberArray[0].isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func getNextNumber() -> String {
        return numberArray[1]
    }
    
    func setNextNumber(number: String) {
        numberArray[1] = number
    }
    
    func addingNextNumber(number: String) {
        numberArray[1] += number
    }
    
    func isActiveNextNumber() -> Bool {
        if !numberArray[1].isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func calloutNumber() {
        print("")
        print("A:\(numberArray[0]) B:\(numberArray[1]) C:\(numberArray[2]) oper:\(operButtonTapped)")
    }
    
    func getSolution() {
        var oper = ""
        switch operButtonTapped {
        case .plus:
            oper = "+"
        case .minus:
            oper = "-"
        case .divide:
            oper = "/"
        case .multiply:
            oper = "*"
        default:
            oper = "none"
        }
        
        print("\(numberArray[0]) \(oper) \(numberArray[1]) = \(numberArray[2])")
    }
}
