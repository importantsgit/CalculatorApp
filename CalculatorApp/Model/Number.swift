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
    
    private var operStatus: Oper = .none {
        didSet {
            print(operStatus)
        }
    }
    
    private var checkNumber = 0 {
        didSet {
            print("checkNumber: \(checkNumber)")
        }
    }
    
    func resetArray() {
        setOperStatus(oper: .none)
        firstNumber = ""
        secondNumber = ""
        resultNumber = ""
    }
    
    func getOperStatus() -> Oper {
        return operStatus
    }
    
    // oper값 수정 -> check number 내장화
    //TODO: 모두 이걸 이용하게 하기
    func setOperStatus(oper: Oper) {
        if oper == .none || oper == .result {
            checkNumber = 0
        } else {
            checkNumber = 1
        }
        self.operStatus = oper
    }
    
    func setResult(number: String) {
        resultNumber = number
    }
    
    func settingResult() -> String {
        setOperStatus(oper: .result)
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
    }
    
    //MARK: 0100 문제 해결
    // String -> Int -> String
    func addingPrevNumber(number: String) {
        firstNumber = String(Int(firstNumber + number)!)
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
    }
    
    //MARK: 0100 문제 해결
    // String -> Int -> String
    func addingNextNumber(number: String) {
        secondNumber = String(Int(secondNumber + number)!)
    }
    
    func isActiveNextNumber() -> Bool {
        if !secondNumber.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentNumber() -> Int {
        return checkNumber
    }
}
