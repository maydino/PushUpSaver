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
    let shadowRadius: CGFloat = 5
    let shadowOffset: CGFloat = 5

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
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = UIColor.systemGray.cgColor
        clipsToBounds = true
        backgroundColor = UIColor(named: AppColors.buttonColor)
        setTitleColor(UIColor(named: AppColors.textColor), for: .normal)
        setTitleColor(UIColor(named: AppColors.textColorH), for: .highlighted)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = false
        
        
//        frame = CGRect(x: 0, y: 0, width: 250, height: 50)
//
//        darkShadow.frame = bounds
//        darkShadow.backgroundColor = UIColor.systemGray.cgColor
//        darkShadow.shadowColor = UIColor.systemGray.cgColor
//        darkShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
//        darkShadow.shadowOpacity = 1
//        darkShadow.cornerRadius = cornerRadius
//        darkShadow.shadowRadius = shadowRadius
//
//        layer.insertSublayer(darkShadow, at: 0)
//
//        lightShadow.frame = bounds
//        lightShadow.backgroundColor = UIColor.systemGray.cgColor
//        lightShadow.shadowColor = UIColor.systemGray6.cgColor
//        lightShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
//        lightShadow.shadowOpacity = 1
//        lightShadow.cornerRadius = cornerRadius
//        lightShadow.shadowRadius = shadowRadius
//        layer.insertSublayer(lightShadow, at: 0)
        

    }
    private func shadows() {

        
    }

}
