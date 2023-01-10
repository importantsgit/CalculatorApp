//
//  Number.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/06.
//

import Foundation

class NumberModel {
   
    var point = DebugPoint().checking
    
    // firstNumber, secondNumber은 피연산자
    // 피연산자를 계산한 값을 resultNumber에 저장합니다.
    private var firstNumber = ""
    private var secondNumber = ""
    private var resultNumber = ""
    
    
    private var status: Oper = .none {
        didSet {
            if point {
                print("operStatus: \(status)")
            }
        }
    }
    
    private var checkNumber = 0 {
        didSet {if point {print("checkNumber: \(checkNumber)")
                print("1:\(firstNumber) 2:\(secondNumber) 3:\(resultNumber)")
            }
        }
    }
    func ClearModel() {
        setOperator(status: .none)
        firstNumber = ""
        secondNumber = ""
        resultNumber = ""
    }
    
    func setOperator(status: Oper) {
        if status == .none || status == .result {
            checkNumber = 0
        } else {
            checkNumber = 1
        }
        self.status = status
    }
    
    func getStatus() -> Oper {
        return status
    }
    
    func setResult(_ number: Double) {
        resultNumber = String(number)
    }
    
    func getResult() -> String {
        setOperator(status: .result)
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
    
    func isActivePrevNumber() -> Bool {
        return !firstNumber.isEmpty
    }
    
    func getNextNumber() -> String {
        return secondNumber
    }
    
    func setNextNumber(number: String) {
        secondNumber = number
    }
    
    func isActiveNextNumber() -> Bool {
        return !secondNumber.isEmpty
    }
    
    func CheckCurrentNumber() -> Int {
        return checkNumber
    }
}
