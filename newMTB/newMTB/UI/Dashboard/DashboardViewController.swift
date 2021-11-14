//
//  ViewController.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 22.04.21.
//

import UIKit
import SnapKit

final class DashboardViewController: UIViewController {
    
    private enum Dimensions {
        static let sideSpacing = 16
        static let topBarHeight = 40
        static let spaceToNavigationBar = 6
    }
    
    private var segmentControl = SegmentControl()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(AccountTableViewCell.self)
        tableView.backgroundColor = UIColor.Base.white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    var viewModel: DashboardViewModel
    
    var accountsArray: [Account] = []
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Base.white
        addSubviews()
        setupConstraints()
        setupNavigationBar()
        setupSegmentControl()
        configure()
    }
    
    private func addSubviews() {
        view.addSubview(segmentControl)
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    private func setupConstraints() {
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Dimensions.spaceToNavigationBar)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.sideSpacing)
            $0.height.equalTo(Dimensions.topBarHeight)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configure() {
        viewModel.addRandomAccounts { [self] in
            accountsArray = viewModel.accountsArray
        }
    }
    
    private func setupSegmentControl() {
        segmentControl.setupButtonsTitle(firstButtonTitle: "Счета", secondButtonTitle:  "Документы")
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.Base.gray
    }
    
    @objc private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [self] in
            accountsArray.removeAll()
            configure()
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateWithEntity(accountsArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DashboardViewController: UITableViewDelegate {}
