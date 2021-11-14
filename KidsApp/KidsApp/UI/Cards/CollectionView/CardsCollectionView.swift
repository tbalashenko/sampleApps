//
//  CardsCollectionView.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 26.05.21.
//

import UIKit

protocol CardsCollectionViewDelegate: AnyObject {
    func didSelectCard(_ card: CardEntity)
}

final class CardsCollectionView: UICollectionView {
    private enum Dimensions {
        static let edgeInsets = UIEdgeInsets(top: 28, left: 20, bottom: 20, right: 20)
    }
    
    private var indexOfCellBeforeDragging = 0
    
    private var indexOfMajorCell: Int {
        let itemWidth = frame.width - Dimensions.edgeInsets.left - Dimensions.edgeInsets.right
        let proportionalOffset = contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(cards.count - 1, index))
        return safeIndex
    }
    
    weak var cardDelegate: CardsCollectionViewDelegate?
    
    var cards: [CardEntity] { ProductManager.shared.cards }
    
    init(cardDelegate: CardsCollectionViewDelegate) {
        self.cardDelegate = cardDelegate
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: CardsCollectionViewCell.reuse_id())
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension CardsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupFromEntity(card: cards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width - Dimensions.edgeInsets.left - Dimensions.edgeInsets.right
        let height = frame.height - Dimensions.edgeInsets.bottom - Dimensions.edgeInsets.top
        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDelegate
extension CardsCollectionView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        
        let indexOfMajorCell = self.indexOfMajorCell
        
        let dataSourceCount = cards.count
        let swipeVelocityThreshold: CGFloat = 0.5
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = (frame.width - Dimensions.edgeInsets.left - Dimensions.edgeInsets.right) * CGFloat(snapToIndex)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
        } else {
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CardsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Dimensions.edgeInsets
    }
    
}

// MARK: - UIScrollViewDelegate
extension CardsCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: contentOffset, size: bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = indexPathForItem(at: visiblePoint)
        cardDelegate?.didSelectCard(cards[visibleIndexPath?.row ?? 0])
    }
}
