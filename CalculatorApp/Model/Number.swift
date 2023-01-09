//
//  Number.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/06.
//

import Foundation

class NumberModel {
    private var numberArray = ["","",""] {
        didSet {
            print("Number 13: \(numberArray)")
        }
    }
    private var operButtonTapped: Oper = .notClick
    
    private var isRational: Bool = false
    
    private var checkNumber = 0
    
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
    
    @discardableResult
    func resultButtonTapped() -> String {
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
    
    func rationalCheck() -> Bool {
        return isRational
    }
    
    func setRational(isRational:Bool) {
        self.isRational = isRational
    }
    
    func setCurrentNumber(check: Int) {
        checkNumber = check
    }
    
    func getCurrentNumber() -> Int {
        return checkNumber
    }

}
