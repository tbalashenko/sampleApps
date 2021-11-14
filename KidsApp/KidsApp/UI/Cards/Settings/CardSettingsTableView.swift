//
//  CardSettingsTableView.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 27.05.21.
//

import UIKit

protocol TableSettingsDelegate: AnyObject {
    func didChangeSwitchStatus(isOn: Bool, action: CardAction)
}

class CardSettingsTableView: UITableView {
    private enum Dimensions {
        static let headerHeight: CGFloat = 120.0
    }
    
    private lazy var moneyBoxButton = MoneyBoxButtonView()
    
    var card: CardEntity
    
    weak var tableSettingsDelegate: TableSettingsDelegate?
    
    init(card: CardEntity, tableSettingsDelegate: TableSettingsDelegate?) {
        self.tableSettingsDelegate = tableSettingsDelegate
        self.card = card
        super.init(frame: .zero, style: .grouped)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        registerCell(CardSettingsTableViewCell.self)
        backgroundColor = .white
        separatorStyle = .none
        dataSource = self
        delegate = self
    }
    
    func setupHeader(color: UIColor) {
        moneyBoxButton.moneyBoxCardImage.tintColor = color
        moneyBoxButton.moneyBoxContainerView.backgroundColor = color
    }
}

// MARK: - UITableViewDelegate
extension CardSettingsTableView: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension CardSettingsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return card.actions.availableActions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardSettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        
        cell.setupFromEntity(card: card, action: card.actions.availableActions[indexPath.row], indexPath: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return moneyBoxButton
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Dimensions.headerHeight
    }
}

// MARK: - CardSettingsTableViewCellDelegate
extension CardSettingsTableView: CardSettingsTableViewCellDelegate {
    func didChangeSwitchStatus(isOn: Bool, action: CardAction) {
        guard let index = card.actions.availableActions.firstIndex(where: { $0 == action }) else { return }
        
        ProductManager.shared.updateSettingState(card: card, setting: index)
        tableSettingsDelegate?.didChangeSwitchStatus(isOn: true, action: action)
    }
}
