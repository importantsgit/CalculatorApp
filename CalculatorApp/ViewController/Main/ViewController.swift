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
        viewModel.showAlert = { [weak self] in
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
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        if viewModel.getPrevNumber() == "0" {
            showAlert(withTitle: "오류", message: "0을 나눌 수 없습니다.")
        } else {
            setOperButton(oper: .divide)
        }

    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        setOperButton(oper: .minus)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        setOperButton(oper: .multiply)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        setOperButton(oper: .plus)
    }
    
    func setOperButton(oper: Oper) {
        resultLabel.text = ""
        viewModel.setOperator(oper: oper)
        subTitleLabel.text = viewModel.activingSubLabel()
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        resultLabel.text = viewModel.resultButtonTapped()
        subTitleLabel.text = ""
    }
    
    @IBAction func dotButtonTapped(_ sender: UIButton) {
        let number = viewModel.dotButtonTapped()
        if number != "ERROR" {
            resultLabel.text = number
        }
    }
    
    @IBAction func negativeButtonTapped(_ sender: UIButton) {
        resultLabel.text = viewModel.setNegativeNumber()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        resultLabel.text = viewModel.backButtonTapped()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        // 현재
        resultLabel.text = viewModel.clearNumber()
    }
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        viewModel.resetNumber()
        subTitleLabel.text = ""
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

