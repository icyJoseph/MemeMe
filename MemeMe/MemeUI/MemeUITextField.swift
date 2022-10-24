//
//  MemeUITextField.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2022-10-24.
//

import Foundation
import UIKit

class MemeUITextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    private func initialize() {
        self.textAlignment = .center
        
        self.autocapitalizationType = .allCharacters
    
        self.defaultTextAttributes = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -3.0
        ]
    }
    
    override var text: String? {
        get {
            return super.text
        }
        set {
            self.textAlignment = .center
            super.text = newValue?.uppercased()
        }
    }
}
