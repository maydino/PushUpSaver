//
//  PUCNeumorphicView.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 10/8/22.
//

import Foundation
import UIKit

class PUCNeumorphicView: UIView {
    
    lazy var darkShadow: CALayer = {
        let darkShadow = CALayer()
        darkShadow.backgroundColor = UIColor(named: AppColors.backgroundColor)?.cgColor
        darkShadow.shadowColor = UIColor(named: AppColors.shadowColor)?.withAlphaComponent(0.5).cgColor
        darkShadow.shadowOffset = CGSize(width: 10, height: 10)
        darkShadow.opacity = 1
        darkShadow.shadowRadius = 15        
        return darkShadow
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        viewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewConfiguration() {
        
        backgroundColor = .red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
}
