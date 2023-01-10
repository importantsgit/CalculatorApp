//
//  MainViewModel.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/06.
//

import UIKit
import AudioToolbox

final class MainViewModel: NSObject {
    
    private var model = NumberModel()
    var showAlert: ((_ title: String,_ des: String)-> Void)?
    
    //TODO: 없애기
    
    func setInputNumber(number: String) { //-> String {
        if model.CheckCurrentNumber() == 0 {
            model.setPrevNumber(number: number)
        } else {
            model.setNextNumber(number: number)
        }
    }
    
    //MARK: model의 checkNumber을 이용하여 현재 쓰고 있는 number의 위치를 파악하고 그 number을 수정할 수 있게 만들었습니다.
    
    //+- 바꾸기
    func setNegativeNumber(number: String) -> String {
        if number.contains(".") { // 소수
            return String(Double(number)! * -1)
        } else {
            return String(Int(number)! * -1)
        }
    }
    
    // 숫자 클리어하기
    func ClearNumber() {
        model.ClearModel()
    }
    
    func demicalButtonTapped(number: String) -> String {
        var number = number
        if number.contains(".") {
            AudioServicesPlaySystemSound(1106)
        } else {
            number += "."
        }
        return number
    }
    
    //TODO: .none 상태일 때, 연산자 입력하기
    
    // -> Int인지 Double인지
    func setOperator(oper: Oper) -> String {
        var number = ""
        if model.getStatus() == .result { // = 연산 후 연산자 클릭
            number = model.getPrevNumber()
        } else if model.getStatus() != .none { // 연산자 클릭 후 바로 클릭
            // 먼저 결과값 계산 ( A + B ) -> result -> A
            number = returnResult()
        }
        else { // 연산자를 처음 클릭했을 때
            if model.isActivePrevNumber() {
                number = model.getPrevNumber()
            } else {
                showAlert?("숫자 없이 계산이 불가능 합니다.","숫자를 입력하세요")
            }
        }
        
        if model.isActivePrevNumber() {
            model.setOperator(status: oper)
            let num = Double(number)!
            if num.truncatingRemainder(dividingBy: 1.0) == 0 {
                return String(Int(Double(number)!.rounded()))
            }
            let digit: Double = pow(10,4)
            return String(round(num * digit) / digit)
        }
        return ""

    }
    
    // result 도출 -> Int인지 Double인지
    func returnResult() -> String {
        if model.isActivePrevNumber() {
            calculatingNumber()
            let number = model.getResult()
            let num = Double(number)!
            if num.truncatingRemainder(dividingBy: 1.0) == 0 {
                return String(Int(Double(number)!.rounded()))
            }
            let digit: Double = pow(10,4)
            return String(round(num * digit) / digit)
        }
        return ""
    }
    
    func calculatingNumber() {
        if model.isActiveNextNumber() { // A와 B가 있는 경우
            let prevNumber = Double(model.getPrevNumber())!
            let nextNumber = Double(model.getNextNumber())!
            switch model.getStatus() {
            case .divide:
                if nextNumber == 0.0 || nextNumber == 0 {
                    showAlert?("0으로 나눌 수 없습니다.","다시 입력하세요.")
                    model.setResult( Double(model.getPrevNumber())!)
                } else {
                    model.setResult(prevNumber / nextNumber)
                }
            case .minus : model.setResult(prevNumber - nextNumber)
            case .multiply : model.setResult(prevNumber * nextNumber)
            case .plus: model.setResult(prevNumber + nextNumber)
            case .none: showAlert?("ERROR","계산이 되지 않습니다")
            case .result: showAlert?("ERROR","계산이 되지 않습니다")
            case .ERROR: showAlert?("ERROR","계산이 되지 않습니다")
                break
            }
        } else if model.isActivePrevNumber() {  // A만 있는 경우
            model.setResult(Double(model.getPrevNumber())!)
        } else { // 아무것도 없는 경우
            showAlert?("계산될 숫자가 없습니다.", "숫자를 입력하세요.")
        }
    }
}
