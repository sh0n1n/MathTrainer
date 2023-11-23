//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Melkor on 11/19/23.
//

import UIKit

final class TrainViewController: UIViewController {
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons2()
        
    }
    
    // MARK: - IBOutlets
    @IBOutlet var buttonCollection2: [UIButton]!
    
    // MARK: - Methods
    private func configureButtons2() {
        buttonCollection2.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 2, height: 3)
            button.layer.shadowOpacity = 0.8
            button.layer.shadowRadius = 2
        }
        
    }
}
