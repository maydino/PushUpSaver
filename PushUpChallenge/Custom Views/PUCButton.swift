//
//  PUCButton.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//

import UIKit

class PUCButton: UIButton {

    let darkShadow = CALayer()
    let lightShadow = CALayer()
    let cornerRadius: CGFloat = 10
    let shadowRadius: CGFloat = 10
    let shadowOffset: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        shadows()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        configure()
        shadows()

    }
    
    private func configure() {
        layer.cornerRadius = 5
        clipsToBounds = true
        backgroundColor = .clear

        setTitleColor(UIColor(named: AppColors.textColor), for: .normal)
        setTitleColor(UIColor(named: AppColors.textColorH), for: .highlighted)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = false
        frame = CGRect(x: 0, y: 0, width: 250, height: 50)

        darkShadow.frame = bounds
        darkShadow.backgroundColor = UIColor.systemBackground.cgColor
        darkShadow.shadowColor = UIColor.systemTeal.cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 0.5
        darkShadow.shadowRadius = shadowRadius
        
        layer.insertSublayer(darkShadow, at: 0)

        lightShadow.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 0.5
        lightShadow.shadowRadius = shadowRadius
        layer.insertSublayer(lightShadow, at: 1)
        

    }
    private func shadows() {

        
    }

}
