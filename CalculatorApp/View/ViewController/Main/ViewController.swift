//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/05.
//

import UIKit

final class ViewController: UIViewController {
    
    lazy var viewModel: MainViewModel = {
        let viewModel = MainViewModel()
        viewModel.showAlert = { [weak self] title, des in
            guard let self = self else {
                return
            }
            self.showAlert(withTitle: title, message: des)
        }
        return viewModel
    }()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ViewController {
    // 버튼 클릭시 ViewModel로 sender값 전달
    // ViewModel로부터 받은 데이터를 UI에 가시화
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if resultLabel.text!.count < 10 {
            let number = sender.currentTitle!
            if resultLabel.text! == "0" {
                resultLabel.text = ""
            }
            setLabelFontSize()
            resultLabel.text = resultLabel.text! + number
        }
    }
    
    @IBAction func operButtonTapped(_ sender: UIButton) {
        
        viewModel.setInputNumber(number: resultLabel.text!)
        
        var oper: Oper = .none
        switch sender.tag {
        case 10: oper = .plus
        case 11: oper = .divide
        case 12: oper = .minus
        case 13: oper = .multiply
        default: oper = .ERROR
        }
        setOperButton(oper: oper)
    }
    
    func setOperButton(oper: Oper) {
        
        subTitleLabel.text = viewModel.setOperator(oper: oper)
        resultLabel.text = ""
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        viewModel.setInputNumber(number: resultLabel.text!)
        subTitleLabel.text = ""
        resultLabel.text = viewModel.returnResult()
        setLabelFontSize()
    }
    
    @IBAction func functionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        //TODO: demical 버튼 수정하기
        case 20: resultLabel.text = viewModel.demicalButtonTapped(number: resultLabel.text!)
        case 30: backButtonTapped()
        case 40: resultLabel.text = viewModel.setNegativeNumber(number: resultLabel.text!)
        case 50:
            viewModel.ClearNumber()
            subTitleLabel.text = ""
            resultLabel.text = ""
        default: showAlert(withTitle: "41", message: "잘못된 버튼입니다.")
        }
        setLabelFontSize()
    }
    
    func backButtonTapped() {
        resultLabel.text = String(resultLabel.text!.dropLast(1))
    }
    
    func showAlert(withTitle title: String, message: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
    
    func setLabelFontSize() {
        resultLabel.font = resultLabel.text!.count < 5 ?.systemFont(ofSize: 40, weight: .bold) : .systemFont(ofSize: 32, weight: .bold)
    }
}

