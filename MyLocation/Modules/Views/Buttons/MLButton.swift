//
//  MLButton.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 26.07.2024.
//

import UIKit

class MLButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(titleColor: UIColor, backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        set(titleColor: titleColor, backgroundColor: backgroundColor, title: title)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    final func set(titleColor: UIColor, backgroundColor: UIColor, title: String) {
        configuration?.baseBackgroundColor = titleColor
        configuration?.baseForegroundColor = backgroundColor
        configuration?.title = title
    }
}

#Preview {
    MLButton(titleColor: .systemPurple, backgroundColor: .white, title: "TestButton")
}
