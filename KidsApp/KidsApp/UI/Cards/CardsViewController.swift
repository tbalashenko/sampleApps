//
//  CardsViewController.swift
//  KidsApp
//
//  Created by Татьяна Балашенко on 22.05.21.
//

import UIKit

final class CardsViewController: UIViewController {
    private enum Dimensions {
        static let collectionHeight = 252
        static let cardButtonStackTopOffset = 6
        static let cardButtonSideSpace = 20
        static let cardButtonStackHeight = 40
        static let settingsTableViewTopOffset = 45
        static let navigationBarHeight = 62
    }
    
    private lazy var navigationBar = CustomNavigationBar(viewController: self, infoAction: #selector(showAlert), phoneAction: #selector(showAlert))
    
    private lazy var cardsCollection = CardsCollectionView(cardDelegate: self)
    
    private lazy var cardButtonsStack = CardButtonsStackView()
    
    private lazy var settingsTableView = CardSettingsTableView(card: cardsViewModel.cards[0], tableSettingsDelegate: self)
    
    let cardsViewModel: CardsViewModel
    
    init(cardsViewModel: CardsViewModel) {
        self.cardsViewModel = cardsViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(cardsCollection)
        view.addSubview(cardButtonsStack)
        view.addSubview(settingsTableView)
        view.addSubview(navigationBar)
    }
    
    private func addConstraints() {
        
        cardsCollection.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Dimensions.collectionHeight)
        }
        
        cardButtonsStack.snp.makeConstraints {
            $0.top.equalTo(cardsCollection.snp.bottom).offset(Dimensions.cardButtonStackTopOffset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.cardButtonSideSpace)
            $0.height.equalTo(Dimensions.cardButtonStackHeight)
        }
        
        settingsTableView.snp.makeConstraints {
            $0.top.equalTo(cardButtonsStack.snp.bottom).offset(Dimensions.settingsTableViewTopOffset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(navigationBar.snp.top)
        }
        
        navigationBar.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(Dimensions.navigationBarHeight)
        }
    }

    @objc private func showAlert() {
        let alert = UIAlertController(title: "", message: "В разработке", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - CardsCollectionViewDelegate
extension CardsViewController: CardsCollectionViewDelegate {
    func didSelectCard(_ card: CardEntity) {
        settingsTableView.card = card
        settingsTableView.reloadData()
        settingsTableView.setupHeader(color: card.color)
        cardButtonsStack.addButtons(actions: card.actions, color: card.color)
    }
}

// MARK: - TableSettingsDelegate
extension CardsViewController: TableSettingsDelegate {
    func didChangeSwitchStatus(isOn: Bool, action: CardAction) {
        cardsCollection.reloadData()
    }
}
