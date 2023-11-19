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
}

