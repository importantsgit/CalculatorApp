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
        if number.contains(".") { // 소수일 경우
            AudioServicesPlaySystemSound(1106)
        } else {
            number += "."
        }
        return number
    }
    
    //MARK: A값(result)을 return 하도록 수정했습니다.
    // -> Int인지 Double인지
    func setOperator(oper: Oper) -> String {
        var number = ""
        if isOperatorClicked() { // 연산자를 클릭하고 또 클릭했을 때
            number = returnResult() // 먼저 결과값 계산 ( A + B ) -> result -> A
        } else { // 연산자를 처음 클릭했을 때
            number = model.getPrevNumber()
        }
        model.setOperStatus(oper: oper) // A +
        //TODO: change
        let num = Double(number)!
        if num.truncatingRemainder(dividingBy: 1.0) == 0 {
            return String(Int(Double(number)!.rounded()))
        }
        let digit: Double = pow(10,4)
        return String(round(num * digit) / digit)
    }
    
    //MARK: 이 메소드를 쓰는게 맞는지 질문하기
    func isOperatorClicked() -> Bool { // +-/* 클릭시
    // oper 클릭 안하거나 result 버튼 클릭 시
        return !(model.getOperStatus() == .none || model.getOperStatus() == .result)
    }
    
    // result 도출 -> Int인지 Double인지
    func returnResult() -> String {
        calculatingNumber()
        let number = model.settingResult()
        let num = Double(number)!
        if num.truncatingRemainder(dividingBy: 1.0) == 0 {
            return String(Int(Double(number)!.rounded()))
        }
        let digit: Double = pow(10,4)
        return String(round(num * digit) / digit)
    }
    
    func calculatingNumber() {
        if model.isActiveNextNumber() { // A와 B가 있는 경우
            let prevNumber = Double(model.getPrevNumber())!
            let nextNumber = Double(model.getNextNumber())!
            print("105: \(prevNumber*nextNumber)")
            switch model.getOperStatus() {
            case .divide:
                if nextNumber == 0.0 || nextNumber == 0 {
                    showAlert?("0으로 나눌 수 없습니다.","다시 입력하세요.")
                    model.setResult(number: Double(model.getPrevNumber())!)
                } else {
                    model.setResult(number: prevNumber / nextNumber)
                }
            case .minus : model.setResult(number: prevNumber - nextNumber)
            case .multiply : model.setResult(number: prevNumber * nextNumber)
            case .plus: model.setResult(number: prevNumber + nextNumber)
            case .none: print("operator is notClicked")
            case .result: print("operator is Clicked")
            case .ERROR: showAlert?("103","계산이 되지 않습니다")
                break
            }
        } else if model.isActivePrevNumber() {  // A만 있는 경우
            model.setResult(number: Double(model.getPrevNumber())!)
        } else { // 아무것도 없는 경우
            showAlert?("계산될 숫자가 없습니다.", "숫자를 입력하세요.")
        }
    }
}
