//
//  MainViewController.swift
//  MathTrainer
//
//  Created by Melkor on 11/19/23.
//
import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            return "addCount"
        case .subtract:
            return "subtractCount"
        case .multiply:
            return "multiplyCount"
        case .divide:
            return "divideCount"
        }
    }
}

class MainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet private weak var addLabel: UILabel!
    @IBOutlet private weak var subtractLabel: UILabel!
    @IBOutlet private weak var multiplyLabel: UILabel!
    @IBOutlet private weak var divideLabel: UILabel!
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    var addCounter: Int = 0
    var divideCounter: Int = 0
    var multiplyCounter: Int = 0
    var subtractCounter: Int = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        updateCount()
       
    }
    
    // MARK: - Actions
    @IBAction private func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        guard let trainVC = unwindSegue.source as? TrainViewController else { return }
        updateCount(with: trainVC.count)
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func configureButtons() {
        buttonCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 3, height: 4)
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 4
        }
    }
    
    private func updateCount(with count: Int = 0) {
        let strCount = String(count)
        switch selectedType {
        case .add:
            addLabel.text = strCount
        case .subtract:
            subtractLabel.text = strCount
        case .multiply:
            multiplyLabel.text = strCount
        case .divide:
            divideLabel.text = strCount
        }
    }
}

