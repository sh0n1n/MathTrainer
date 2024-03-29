//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Melkor on 11/19/23.
//
import Foundation
import UIKit

final class TrainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    private(set) var count: Int = 0 {
        didSet {
            print("Count: \(count)")
            scoreLabel.text = "Score: \(count)"
            UserDefaults.standard.set(count, forKey: type.key) //saving
        }
    }
    
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureQuestion()
        configureButtons()
        configureScore()
        
        if let count = UserDefaults.standard.object(forKey: type.key) as? Int {
            self.count = count
        }
        
    }
    // MARK: - IBAActions
    @IBAction private func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    @IBAction private func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    
    // MARK: - Methods
    private func configureButtons() {
        let buttonsArray = [leftButton, rightButton]
        buttonsArray.forEach { button in button?.backgroundColor = .systemYellow}
        [leftButton, rightButton].forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 2, height: 3)
            button?.layer.shadowOpacity = 0.8
            button?.layer.shadowRadius = 2
        }
        
        let  isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer+10))
        } while randomAnswer == answer
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...1000)
        secondNumber = Int.random(in: 1...firstNumber)
        
        while firstNumber % secondNumber != 0 {
            firstNumber = Int.random(in: 1...1000)
            secondNumber = Int.random(in: 1...firstNumber)
        }
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func configureScore() {
        scoreLabel.text = "Score: \(count)"
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            let isSecondAttempt = rightButton.backgroundColor == .red ||
            leftButton.backgroundColor == .red
            count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
}

// Save own storage
extension UserDefaults {
    static let container = UserDefaults(suiteName: "container")
}
