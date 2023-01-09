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
        if model.getOperButtonTapped() == .notClick {
            model.addingPrevNumber(number: number)
            return model.getPrevNumber()
            
        } else {
            if model.getOperButtonTapped() == .resultClick {
                resetNumber()
                model.addingPrevNumber(number: number)
                return model.getPrevNumber()
            } else {
                model.addingNextNumber(number: number)
                return model.getNextNumber()
            }
        }
    }
    
    //+- 바꾸기
    func setNegativeNumber() -> String {
        if model.getOperButtonTapped() == .notClick {
            model.setPrevNumber(number: String(-1 * Double(model.getPrevNumber())!))
            return model.getPrevNumber()
        } else {
            if model.getOperButtonTapped() == .resultClick {
                resetNumber()
                model.setPrevNumber(number: String(-1 * Double(model.getPrevNumber())!))
                return model.getPrevNumber()
            } else {
                model.setNextNumber(number: String(-1 * Double(model.getNextNumber())!))
                return model.getNextNumber()
            }
        }
    }
    
    //현재 값 지우기
    func clearNumber() -> String {
        if model.getOperButtonTapped() == .notClick {
            model.setPrevNumber(number: "")
            return model.getPrevNumber()
        } else {
            if model.getOperButtonTapped() == .resultClick {
                resetNumber()
                model.setPrevNumber(number: "")
                return model.getPrevNumber()
            } else {
                model.setNextNumber(number: "")
                return model.getNextNumber()
            }
        }
    }
    
    //backbutton 클릭시 맨 뒤 숫자 지우기
    func backButtonTapped() -> String {
        if model.getOperButtonTapped() == .notClick {
            let number = model.getPrevNumber()
            model.setPrevNumber(number: String(number.dropLast(1)))
            return model.getPrevNumber()
        } else {
            if model.getOperButtonTapped() == .resultClick {
                resetNumber()
                let number = model.getPrevNumber()
                model.setPrevNumber(number: String(number.dropLast(1)))
                return model.getPrevNumber()
            } else {
                let number = model.getNextNumber()
                model.setNextNumber(number: String(number.dropLast(1)))
                return model.getNextNumber()
            }
        }
    }
    
    //TODO: 고민하기
    /*
    func dotButtonTapped() -> String {
        if model.rationalCheck() {
            // 유리수
            AudioServicesPlaySystemSound(1106)
            return "ERROR"
        } else {
            // 정수
            model.setRational(isRational: true)
            if model.getOperButtonTapped() == .notClick {
                return addingDot()
            } else {
                if model.getOperButtonTapped() == .resultClick {
                    resetNumber()
                    model.addingPrevNumber(number: ".")
                    return model.getPrevNumber()
                } else {
                    model.addingNextNumber(number: ".")
                    return model.getNextNumber()
                }
            }
        }
    }
     
    
    func addingDot() -> String {
        var number = ""
        if model.getCurrentNumber() == 0 {
            number = model.getPrevNumber() == "" ? "0." : "."
            model.addingPrevNumber(number: number)
            return model.getPrevNumber()
        } else {
            number = model.getNextNumber() == "" ? "0." : "."
            model.addingNextNumber(number: number)
            return model.getNextNumber()
        }
    }
     */
    
    //TODO: 고민하기
    func setOperator(oper: Oper) {
        if isOperatorClicked() {
            resultButtonTapped()
        } else {
            print("operisEmpty")
        }
        model.setOperButtonTapped(oper: oper)
    }
    
    func isOperatorClicked() -> Bool {
        if model.getOperButtonTapped() == .notClick || model.getOperButtonTapped() == .resultClick {
            return false
        } else {
            return true
        }
    }
    
    // result버튼 클릭시
    @discardableResult
    func resultButtonTapped() -> String {
        calculatingNumber()
        return model.resultButtonTapped()
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
            case .resultClick: print("operator is Clicked")
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
    
    func activingSubLabel() -> String {
        if model.isActivePrevNumber() {
            return model.getPrevNumber()
        } else {
            return ""
        }
    }

}
