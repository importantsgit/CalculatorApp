//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 이재훈 on 2023/01/05.
//

import UIKit

final class ViewController: UIViewController {
    
    var viewModel = MainViewModel()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ViewController {
    // 버튼 클릭시 ViewModel로 sender값 전달
    // ViewModel로부터 받은 데이터를 UI에 가시화
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        let number = sender.currentTitle!
        resultLabel.text = viewModel.setInputnumber(number: number)
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        if viewModel.getPrevNumber() == "0" {
            showAlert(withTitle: "오류", message: "0을 나눌 수 없습니다.")
        } else {
            resultLabel.text = viewModel.setOperator(oper: .divide)
        }

    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        resultLabel.text = viewModel.setOperator(oper: .minus)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        resultLabel.text = viewModel.setOperator(oper: .multiply)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        resultLabel.text = viewModel.setOperator(oper: .plus)
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        resultLabel.text = viewModel.resultButtonTapped()
    }
    
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        viewModel.resetNumber()
        resultLabel.text = ""
    }
    
    func showAlert(withTitle title: String, message: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
}
