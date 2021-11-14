//
//  DashboardViewController.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 20.05.21.
//

import UIKit
import CHIPageControl

final class DashboardViewController: UIViewController {
    
    private enum Dimensions {
        static let spaceBetweenCells: CGFloat = 0
        static let contentInset = UIEdgeInsets(top: 30, left: 36, bottom: 30, right: 36)
        static let buttonSize = 142
        static let collectionBottomSpace = 58
        static let offerCollectionHeight = 178
        static let pageControlSideSpace = 24
    }
    
    private lazy var pageControl: CHIPageControlAleppo = {
        let pageControl = CHIPageControlAleppo()
        pageControl.currentPageTintColor = .white
        pageControl.tintColor = .gray
        pageControl.enableTouchEvents = true
        pageControl.delegate = self
        return pageControl
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "background1")
        return imageView
    }()
    
    private lazy var buttonsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DashboardButtonsCollectionViewCell.self, forCellWithReuseIdentifier: DashboardButtonsCollectionViewCell.reuse_id())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollIndicatorInsets = .zero
        collectionView.backgroundColor = .clear
        
        collectionView.addGestureRecognizer(longPressGesture)
        collectionView.addGestureRecognizer(tapGesture)
        longPressGesture.cancelsTouchesInView = false
        tapGesture.cancelsTouchesInView = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var offerCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DashboardOfferCollectionCell.self, forCellWithReuseIdentifier: DashboardOfferCollectionCell.reuse_id())
        collectionView.register(DashboardCardCollectionCell.self, forCellWithReuseIdentifier: DashboardCardCollectionCell.reuse_id())
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var timer = Timer()
    
    var viewModel: DashboardViewModel
    
    init (viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        setupPageControl()
        setupAutoscrollTimer()
        setupBackgroundChangeTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        offerCollection.reloadData()
        setupPageControl()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(offerCollection)
        view.addSubview(pageControl)
        view.addSubview(buttonsCollection)
    }
    
    private func makeConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        offerCollection.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Dimensions.offerCollectionHeight)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(offerCollection.snp.bottom)
            $0.leading.equalToSuperview().inset(Dimensions.pageControlSideSpace)
        }
        
        buttonsCollection.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Dimensions.collectionBottomSpace)
            $0.height.equalTo(CGFloat(Dimensions.buttonSize * 2) + Dimensions.contentInset.bottom + Dimensions.contentInset.top)
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.offersArray.count
    }
    
    private func setupBackgroundChangeTimer() {
        //timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scaleBackground), userInfo: nil, repeats: true)
    }
    
    private func setupAutoscrollTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    
    private func openViewController(index: Int) {
        let targetViewController = CardsViewController(cardsViewModel: CardsViewModel())
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    @objc private func scaleBackground() {
        UIView.animate(withDuration: 5) { [self] in
            let delta: CGFloat = CGFloat(arc4random_uniform(10))
            backgroundImage.frame = CGRect(x: 0, y: 0, width: backgroundImage.frame.width - delta, height: backgroundImage.frame.height - delta)
            backgroundImage.center = self.view.center
        }
    }
    
    @objc private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
            case .began:
                guard let targetIndexPath = buttonsCollection.indexPathForItem(at: gesture.location(in: buttonsCollection)) else { return }
                
                buttonsCollection.beginInteractiveMovementForItem(at: targetIndexPath)
            case .changed:
                buttonsCollection.updateInteractiveMovementTargetPosition(gesture.location(in: buttonsCollection))
            case .ended:
                buttonsCollection.endInteractiveMovement()
            default:
                buttonsCollection.cancelInteractiveMovement()
        }
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
            case .began, .cancelled, .changed, .ended, .possible, .recognized:
                guard let indexPath = buttonsCollection.indexPathForItem(at: gesture.location(in: buttonsCollection)) else { return }
                
                openViewController(index: indexPath.row)
            default:
                break
        }
    }
    
    @objc private func autoscroll() {
        guard let currentIndexPath = offerCollection.indexPathsForVisibleItems.last else { return }
        let nextIndexPath = currentIndexPath.item == offerCollection.numberOfItems(inSection: 0) - 1
            ? IndexPath(item: 0, section: 0)
            : IndexPath(item: currentIndexPath.item + 1, section: 0)
        let scrollPosition: UICollectionView.ScrollPosition = currentIndexPath.item == offerCollection.numberOfItems(inSection: 0) - 1
            ? .right
            : .left
            
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [self] in
            pageControl.set(progress: nextIndexPath.row, animated: true)
            offerCollection.scrollToItem(at: nextIndexPath as IndexPath, at: scrollPosition, animated: false)
        })
    }
}

// MARK - UICollectionViewDelegate
extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let currentIndexPath = offerCollection.indexPathsForVisibleItems.last else { return }
        pageControl.set(progress: currentIndexPath.row, animated: true)
        timer.invalidate()
        timer.fire()
    }
}

// MARK - UIScrollViewDelegate
extension DashboardViewController: UIScrollViewDelegate { }

// MARK - UICollectionViewDataSource
extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case buttonsCollection:
                return viewModel.buttons.count
            case offerCollection:
                return viewModel.offersArray.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case buttonsCollection:
                let cell: DashboardButtonsCollectionViewCell = buttonsCollection.dequeueReusableCell(for: indexPath)
                cell.setupFromEntity(button: viewModel.buttons[indexPath.row])
                return cell
            case offerCollection:
                switch viewModel.offersArray[indexPath.row] {
                    case let offer as OfferEntity:
                        let cell: DashboardOfferCollectionCell = offerCollection.dequeueReusableCell(for: indexPath)
                        cell.setupFromEntity(offer: offer)
                        return cell
                    case let card as CardEntity:
                        let cell: DashboardCardCollectionCell = offerCollection.dequeueReusableCell(for: indexPath)
                        cell.setupFromEntity(card: card)
                        return cell
                    default:
                        return UICollectionViewCell()
                }
            default:
                return UICollectionViewCell()
        }
    }
}

// MARK - UICollectionViewDelegateFlowLayout
extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == buttonsCollection {
            return Dimensions.contentInset
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            case buttonsCollection:
                return CGSize(width: Dimensions.buttonSize, height: Dimensions.buttonSize)
            default:
                return CGSize(width: offerCollection.bounds.width, height: 178)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return collectionView == buttonsCollection
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = viewModel.buttons.remove(at: sourceIndexPath.row)
        viewModel.buttons.insert(item, at: destinationIndexPath.row)
    }
}

// MARK - CHIBasePageControlDelegate
extension DashboardViewController: CHIBasePageControlDelegate {
    func didTouch(pager: CHIBasePageControl, index: Int) {
        
        timer.invalidate()
        timer.fire()
        pageControl.set(progress: index, animated: true)
        
        guard let visibleCurrentCellIndexPath = offerCollection.visibleCurrentCellIndexPath?.row else { return }
        
        let delta = index - visibleCurrentCellIndexPath
        let nextIndexPath = IndexPath(item: visibleCurrentCellIndexPath + delta, section: 0)
        let scrollPosition: UICollectionView.ScrollPosition = index < visibleCurrentCellIndexPath ? .right : .left
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [self] in
            offerCollection.scrollToItem(at: nextIndexPath as IndexPath, at: scrollPosition, animated: false)
        })
    }
}

