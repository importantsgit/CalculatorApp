//
//  Number.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/06.
//

import Foundation

class NumberModel {
   
    // firstNumber (oper) secondNumber = resultNumber
    private var firstNumber = ""
    private var secondNumber = ""
    private var resultNumber = ""
    
    private var operButtonTapped: Oper = .notClick
    
    private var checkNumber = 0
    
    func resetArray() {
        operButtonTapped = .notClick
        firstNumber = ""
        secondNumber = ""
        resultNumber = ""
    }
    
    func getOperButtonTapped() -> Oper {
        return operButtonTapped
    }
    
    func setOperButtonTapped(oper: Oper) {
        self.operButtonTapped = oper
    }
    
    func setResult(number: String) {
        resultNumber = number
    }
    
    @discardableResult
    func resultButtonTapped() -> String {
        setOperButtonTapped(oper: .resultClick)
        firstNumber = resultNumber
        secondNumber = ""
        resultNumber = ""
        return firstNumber
    }
    
    func getPrevNumber() -> String {
        return firstNumber
    }
    
    func setPrevNumber(number: String) {
        firstNumber = number
        checkNumber = 0
    }
    
    func addingPrevNumber(number: String) {
        firstNumber += number
        checkNumber = 0
    }
    
    func isActivePrevNumber() -> Bool {
        if !firstNumber.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func getNextNumber() -> String {
        return secondNumber
    }
    
    func setNextNumber(number: String) {
        secondNumber = number
        checkNumber = 1
    }
    
    func addingNextNumber(number: String) {
        secondNumber += number
        checkNumber = 1
    }
    
    func isActiveNextNumber() -> Bool {
        if !secondNumber.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    // 내장화 시키기
//    func setCurrentNumber(check: Int) {
//        checkNumber = check
//    }
    
    func getCurrentNumber() -> Int {
        return checkNumber
    }

}
