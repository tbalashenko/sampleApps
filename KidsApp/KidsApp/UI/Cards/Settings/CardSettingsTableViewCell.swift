//
//  CardSettingsTableViewCell.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 24.05.21.
//

import UIKit

protocol CardSettingsTableViewCellDelegate: AnyObject {
    func didChangeSwitchStatus(isOn: Bool, action: CardAction)
}

final class CardSettingsTableViewCell: UITableViewCell {
    private enum Dimensions {
        static let leadingTrailingSpacing = 20
        static let topBottomInsets = 27
    }
    
    private lazy var settingName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var settingSwitch: UISwitch = {
        let settingSwitch = UISwitch()
        settingSwitch.onTintColor = .blue
        settingSwitch.addTarget(self, action: #selector(changeSwitchState(_:)), for: .valueChanged)
        return settingSwitch
    }()
    
    var action: CardAction?
    
    weak var delegate: CardSettingsTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(settingName)
        contentView.addSubview(settingSwitch)
    }
    
    private func setupConstraints() {
        settingName.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Dimensions.topBottomInsets)
            $0.leading.equalToSuperview().inset(Dimensions.leadingTrailingSpacing)
        }
        settingSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Dimensions.leadingTrailingSpacing)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        settingName.text = nil
        settingSwitch.isOn = false
    }
    
    public func setupFromEntity(card: CardEntity, action: CardAction, indexPath: Int) {
        settingName.text = action.name
        settingSwitch.isOn = action.isOn
        settingSwitch.tag = indexPath
        self.action = action
    }
    
    @objc private func changeSwitchState(_ sender: UISwitch) {
        guard let action = action else { return }
        
        delegate?.didChangeSwitchStatus(isOn: sender.isOn, action: action)
    }
}
