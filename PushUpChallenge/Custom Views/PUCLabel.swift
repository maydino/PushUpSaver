//
//  PUCLabel.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//

import UIKit

class PUCLabel: UILabel {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.font = UIFont(name: AppFont.textFontLight, size: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, textFontName: String, fontSize: CGFloat, title: String) {
        super .init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.text = title
        self.font = UIFont(name: textFontName, size: fontSize)
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
