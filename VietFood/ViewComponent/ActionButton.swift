//
//  ActionButton.swift
//  VietFood
//
//  Created by HieuTDT on 8/30/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    var pressAction: () -> Void = {}

    var normalBackgroundColor: UIColor?

    var highlightBackgroundColor: UIColor?

    var titleColor: UIColor?
    
    var titleHighlightColor: UIColor?

    var text: String = ""
    
    var showShadow: Bool = true {
        didSet {
            if !showShadow {
                self.layer.shadowRadius = 0
            } else {
                self.layer.shadowRadius = 2
            }
        }
    }

    init(title: String,
         titleColor: UIColor,
         titleHighlightColor: UIColor,
         backgroundColor: UIColor,
         highlightBackgroundColor: UIColor,
         action: @escaping () -> Void) {
        
        super.init(frame: .zero)
        
        self.text = title
        self.titleColor = titleColor
        self.titleHighlightColor = titleHighlightColor
        self.normalBackgroundColor = backgroundColor
        self.highlightBackgroundColor = highlightBackgroundColor
        self.pressAction = action
        
        self.customInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }

    private func customInit() {
        self.dropShadow(shadowRadius: 2)
        self.layer.cornerRadius = 15
        
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.setTitle(self.text, for: .normal)
        self.setTitleColor(self.titleColor, for: .normal)
        self.setTitleColor(self.titleHighlightColor, for: .highlighted)
        self.backgroundColor = normalBackgroundColor
        
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchCancel), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
    }
    
    @objc func touchUpInside() {
        self.backgroundColor = normalBackgroundColor
        
        // Action trigged
        self.pressAction()
    }
    
    @objc func touchDown() {
        self.backgroundColor = highlightBackgroundColor
    }
    
    @objc func touchCancel() {
        self.backgroundColor = normalBackgroundColor
    }
}
