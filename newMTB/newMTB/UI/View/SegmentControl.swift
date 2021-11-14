//
//  TopBar.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 3.05.21.
//

import UIKit

final class SegmentControl: UIView {
    private enum Dimensions {
        static let linesHeight = 1
        static let linesInsets = 8
        static let stackInsets = 20
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.regular(of: 14)
        button.backgroundColor = UIColor.Base.white
        button.setTitleColor(UIColor.Base.blue, for: .normal)
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.regular(of: 14)
        button.backgroundColor = UIColor.Base.white
        button.setTitleColor(UIColor.Base.gray, for: .normal)
        return button
    }()
    
    private var menuBar = UIView(color: UIColor.Base.white)
    
    private lazy var firstButtonLine = UIView(color: UIColor.Base.blue)
    
    private lazy var secondButtonLine = UIView(color: UIColor.Base.lightGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(menuBar)
        addSubview(stackView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        menuBar.addSubview(firstButtonLine)
        menuBar.addSubview(secondButtonLine)
    }
    
    private func setupConstraints() {
        menuBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Dimensions.stackInsets)
        }
        
        firstButtonLine.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Dimensions.linesInsets)
            $0.width.equalTo(firstButton.snp.width)
            $0.height.equalTo(Dimensions.linesHeight)
        }
        
        secondButtonLine.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.equalTo(secondButton.snp.width)
            $0.bottom.equalToSuperview().inset(Dimensions.linesInsets)
            $0.height.equalTo(Dimensions.linesHeight)
        }
    }
    
    public func setupButtonsTitle(firstButtonTitle: String, secondButtonTitle: String) {
        self.firstButton.setTitle(firstButtonTitle, for: .normal)
        self.secondButton.setTitle(secondButtonTitle, for: .normal)
    }
    
    public func didClickButton(with index: Int) {
        firstButton.setTitleColor(index == 0 ? UIColor.Base.blue : UIColor.Base.gray, for: .normal)
        firstButtonLine.backgroundColor = index == 0 ? UIColor.Base.blue : UIColor.Base.lightGray
        secondButton.setTitleColor(index == 0 ? UIColor.Base.gray : UIColor.Base.blue, for: .normal)
        secondButtonLine.backgroundColor = index == 0 ? UIColor.Base.lightGray : UIColor.Base.blue
    }
}
