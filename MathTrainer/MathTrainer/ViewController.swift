//
//  ViewController.swift
//  MathTrainer
//
//  Created by Melkor on 11/19/23.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var subtractLabel: UILabel!
    @IBOutlet weak var multiplyLabel: UILabel!
    @IBOutlet weak var divideLabel: UILabel!
    
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
        UpdateCount()
       
    }
    
    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        
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
    
    private func UpdateCount() {
        addLabel.text = String(addCounter)
        subtractLabel.text = String(subtractCounter)
        multiplyLabel.text = String(multiplyCounter)
        divideLabel.text = String(divideCounter)
    }

}

