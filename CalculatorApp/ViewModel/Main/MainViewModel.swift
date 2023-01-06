//
//  MainViewModel.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/06.
//

import UIKit

final class MainViewModel: NSObject {
    
    private var model = NumberModel()
    
    func setInputnumber(number: String) -> String {
        if model.getOperButtonTapped() == .notClick {
            model.addingPrevNumber(number: number)
            return model.getPrevNumber()
            
        } else {
            if model.getOperButtonTapped() == .operClick {
                resetNumber()
                model.addingPrevNumber(number: number)
                return model.getPrevNumber()
            } else {
                model.addingNextNumber(number: number)
                return model.getNextNumber()
            }
        }
    }
    
    func setOperator(oper: Oper) {
        if isOperatorClicked() {
            calculatingNumber()
            model.resultButtonTapped()
            model.setOperButtonTapped(oper: oper)
        } else {
            model.setOperButtonTapped(oper: oper)
        }
        
    }
    
    func isOperatorClicked() -> Bool {
        if model.getOperButtonTapped() == .notClick {
            return false
        } else {
            return true
        }
    }
    
    func resetNumber() {
        model.resetArray()
    }
    
    func calculatingNumber() {
        if model.isActiveNextNumber() { // A와 B가 있는 경우
            let prevNumber = Int(model.getPrevNumber())!
            let nextNumber = Int(model.getNextNumber())!
            switch model.getOperButtonTapped() {
            case .divide: model.setResult(number: String(prevNumber / nextNumber))
            case .minus : model.setResult(number: String(prevNumber - nextNumber))
            case .multiply : model.setResult(number: String(prevNumber * nextNumber))
            case .plus: model.setResult(number: String(prevNumber + nextNumber))
            case .notClick: print("operator is notClicked")
            case .operClick: print("operator is Clicked")
            }
        } else if model.isActivePrevNumber() {  // A만 있는 경우
            model.setResult(number: model.getPrevNumber())
        } else { // 아무것도 없는 경우
            
        }

    }
    
    func resultButtonTapped() -> String {
        calculatingNumber()
        return model.resultButtonTapped()
    }
    
    func getPrevNumber() -> String {
        return model.getPrevNumber()
    }
    

}
