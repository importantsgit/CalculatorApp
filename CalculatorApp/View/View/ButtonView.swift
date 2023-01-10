//
//  OperatorView.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/09.
//

import Foundation
import UIKit

class ButtonView: UIButton {
    private var oper: Oper?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addTarget(self, action: #selector(bButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func bButtonTapped(sender: UIButton) {
        let number = sender.tag
        switch sender.tag {
        case 0...9: NumberTapped(number)
        case 10...19: OperatorTapped(number)
        case 20...50: functionTapped(number)
        default: print("ERROR")
        }
        
    }
    

    private func NumberTapped(_ number: Int) {
        //print("NumberTapped")
    }
    
    private func OperatorTapped(_ number: Int) {
        //print("OperButtonTapped")
    }
    
    
    private func functionTapped(_ number: Int){
        //print("functionTapped")
    }
}
