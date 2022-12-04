//
//  PUCTitleLabel.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//  Copyright © 2022 Mutlu Aydin. All rights reserved.
//

import UIKit

class PUCTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super .init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
        
    }
    
    private func configure() {

        textColor = UIColor(named: AppColors.textColor)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false

        
    }

}
