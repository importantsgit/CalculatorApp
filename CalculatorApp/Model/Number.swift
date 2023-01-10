//
//  Number.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/06.
//

import Foundation

class NumberModel {
   
    var point = DebugPoint().checking
    
    // firstNumber (oper) secondNumber = resultNumber
    private var firstNumber = ""
    private var secondNumber = ""
    private var resultNumber = ""
    
    private var operStatus: Oper = .none {
        didSet {
            if point {
                print("operStatus: \(operStatus)")
            }
        }
    }
    
    private var checkNumber = 0 {
        didSet {
            if point {
                print("checkNumber: \(checkNumber)")
                print("1:\(firstNumber) 2:\(secondNumber) 3:\(resultNumber)")
            }
        }
    }
    func ClearModel() {
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
    
    func setResult(number: Double) {
        resultNumber = String(number)
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
        return !secondNumber.isEmpty
    }
    
    func CheckCurrentNumber() -> Int {
        return checkNumber
    }
}
