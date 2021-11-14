//
//  DashboardButtonsCollectionViewCell.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 20.05.21.
//

import UIKit

final class DashboardButtonsCollectionViewCell: UICollectionViewCell {
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.medium(of: 24)
        button.layer.cornerRadius = frame.height / 2
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.7
        return button
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
        contentView.addSubview(colorButton)
    }
    
    private func setupConstraints() {
        colorButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorButton.backgroundColor = nil
        colorButton.setTitle(nil, for: .normal)
        colorButton.layer.shadowColor = nil
    }
    
    public func setupFromEntity(button: DashboardButtonEntity) {
        colorButton.backgroundColor = button.color
        colorButton.setTitle(button.text, for: .normal)
        colorButton.layer.shadowColor = button.color.cgColor
    }
}
