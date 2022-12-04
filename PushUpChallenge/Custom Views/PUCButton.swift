//
//  PUCButton.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//  Copyright © 2022 Mutlu Aydin. All rights reserved.
//

import UIKit

class PUCButton: UIButton {

    let cornerRadius: CGFloat = 10
    let shadowRadius: CGFloat = 5
    let shadowOffset: CGFloat = 5

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        configure()
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        
        clipsToBounds = true
        backgroundColor = UIColor(named: AppColors.buttonColor)
        setTitleColor(UIColor(named: AppColors.textColor), for: .normal)
        setTitleColor(UIColor(named: AppColors.textColorH), for: .highlighted)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = false

    }
    

}
