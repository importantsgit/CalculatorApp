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
    var showAlert: (()-> Void)?
    
    func setInputNumber(number: String) -> String {
        if model.getOperStatus() == .result {
            resetNumber()
        }
        
        if model.getOperStatus() == .none || model.getOperStatus() == .result {
            model.addingPrevNumber(number: number)
            return model.getPrevNumber()
        } else {
            model.addingNextNumber(number: number)
            return model.getNextNumber()
        }
    }
    
    //MARK: model의 checkNumber을 이용하여 현재 쓰고 있는 number의 위치를 파악하고 그 number을 수정할 수 있게 만들었습니다.
    
    //+- 바꾸기
    func setNegativeNumber() -> String {
        if model.getCurrentNumber() == 0 {
            model.setPrevNumber(number: String(-1 * Double(model.getPrevNumber())!))
            return model.getPrevNumber()
        } else {
            model.setNextNumber(number: String(-1 * Double(model.getNextNumber())!))
            return model.getNextNumber()
        }
    }
    
    //backbutton 클릭시 맨 뒤 숫자 지우기
    func backButtonTapped() -> String {
        if model.getCurrentNumber() == 0 {
            model.setPrevNumber(number: String(model.getPrevNumber().dropLast(1)))
            return model.getPrevNumber()
        } else {
            model.setNextNumber(number: String(model.getNextNumber().dropLast(1)))
            return model.getNextNumber()
        }
    }
    
    // 숫자 클리어하기
    func resetNumber() {
        model.setOperStatus(oper: .none)
        model.resetArray()
    }
    
    //MARK: A값(result)을 return 하도록 수정했습니다.
    func setOperator(oper: Oper) -> String {
        var number = ""
        if isOperatorClicked() { // 연산자를 클릭하고 또 클릭했을 때
            number = returnResult() // 먼저 결과값 계산 ( A + B ) -> result -> A
        } else { // 연산자를 처음 클릭했을 때
            number = model.getPrevNumber()
        }
        model.setOperStatus(oper: oper) // A +
        return number
    }
    
    //MARK: 이 메소드를 쓰는게 맞는지 질문하기
    func isOperatorClicked() -> Bool { // +-/* 클릭시
        if model.getOperStatus() == .none || model.getOperStatus() == .result { // oper 클릭 안하거나 result 버튼 클릭 시
            return false
        } else {
            return true
        }
    }
    
    // result버튼 클릭시
    func returnResult() -> String {
        calculatingNumber()
        return model.settingResult()
    }
    
    func calculatingNumber() {
        if model.isActiveNextNumber() { // A와 B가 있는 경우
            let prevNumber = Int(model.getPrevNumber())!
            let nextNumber = Int(model.getNextNumber())!
            switch model.getOperStatus() {
            case .divide:
                if nextNumber == 0 {
                    print("0으로 나눌 수 없습니다.")
                } else {
                    model.setResult(number: String(prevNumber / nextNumber))
                }
            case .minus : model.setResult(number: String(prevNumber - nextNumber))
            case .multiply : model.setResult(number: String(prevNumber * nextNumber))
            case .plus: model.setResult(number: String(prevNumber + nextNumber))
            case .none: print("operator is notClicked")
            case .result: print("operator is Clicked")
            }
        } else if model.isActivePrevNumber() {  // A만 있는 경우
            model.setResult(number: model.getPrevNumber())
        } else { // 아무것도 없는 경우
            showAlert?()
            print("number and operator are empty")
        }
    }
    
    func getPrevNumber() -> String {
        return model.getPrevNumber()
    }
}
