//
//  EmptyView.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 19.05.21.
//

import UIKit

class EmptyView: UIView {
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(of: 18)
        label.textColor = UIColor.Base.black
        return label
    }()
    
    private lazy var errorImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.Base.white
        addSubviews()
        setupConstraints()
    }
    
    convenience init(text: String, imageName: String) {
        self.init()
        errorLabel.text = text
        errorImage.image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(stack)
        stack.addArrangedSubview(errorImage)
        stack.addArrangedSubview(errorLabel)
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
