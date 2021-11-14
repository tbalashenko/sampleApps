//
//  MoreViewControllerCell.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import UIKit

final class MoreViewControllerCell: UITableViewCell {
    private enum Dimensions {
        static let titleTopBottomInsets = 20
        static let titleSideInsets = 16
    }
    
    private lazy var titleLabel = UILabel(font: UIFont.light(of: 18), textColor: UIColor.Base.black, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.Base.white
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Dimensions.titleTopBottomInsets)
            $0.leading.equalToSuperview().inset(Dimensions.titleSideInsets)
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
