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
        viewModel.showAlert = { [weak self]  in
            guard let self = self else {
                return
            }
            self.showAlert(withTitle: "오류", message: "값이 입력되지 않았습니다.")
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
        let number = sender.currentTitle!
        resultLabel.text = viewModel.setInputNumber(number: number)
    }
    
    @IBAction func operButtonTapped(_ sender: UIButton) {
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
        resultLabel.text = ""
        subTitleLabel.text = viewModel.setOperator(oper: oper)
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        subTitleLabel.text = ""
        resultLabel.text = viewModel.returnResult()
    }
    
    @IBAction func functionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 30: resultLabel.text = viewModel.backButtonTapped()
        case 40: resultLabel.text = viewModel.setNegativeNumber()
        case 50:
            viewModel.resetNumber()
            subTitleLabel.text = ""
            resultLabel.text = ""
        default: print("ERROR")
        }
    }

    func showAlert(withTitle title: String, message: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
}

