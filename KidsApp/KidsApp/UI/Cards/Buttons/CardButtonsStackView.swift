//
//  CardButtons.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 25.05.21.
//

import UIKit

final class CardButtonsStackView: UIView {
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(buttonsStack)
    }
    
    private func setupConstraints() {
        buttonsStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createButton(title: String,
                              titleColor: UIColor = .textGray,
                              cornerRadius: CGFloat = 0,
                              shadowRadius: CGFloat = 0,
                              shadowOpacity: Float = 0,
                              backgroundColor: UIColor = .clear,
                              shadowOffset: CGSize = CGSize(width: 0, height: 0)
                              ) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.regular(of: 16)
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.layer.shadowRadius = shadowRadius
        button.layer.shadowOpacity = shadowOpacity
        button.layer.shadowOffset = shadowOffset
        button.backgroundColor = backgroundColor
        return button
    }
    
    public func addButtons(actions: ProductAction, color: UIColor) {
        for view in buttonsStack.subviews {
            buttonsStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        let actionButton = createButton(title: "ДЕЙСТВИЯ",
                                        titleColor: color,
                                        cornerRadius: 20,
                                        shadowRadius: 5,
                                        shadowOpacity: 0.1,
                                        backgroundColor: .white,
                                        shadowOffset: CGSize(width: 5, height: 5))
        buttonsStack.addArrangedSubview(actionButton)
        
        if actions.aboutCard != nil {
            let button = createButton(title: "О КАРТЕ")
            buttonsStack.addArrangedSubview(button)
        }
        
        if actions.history != nil {
            let button = createButton(title: "ИСТОРИЯ")
            buttonsStack.addArrangedSubview(button)
        }
    }
}
