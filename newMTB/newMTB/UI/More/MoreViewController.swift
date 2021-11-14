//
//  MoreViewController.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import UIKit
import KeychainSwift

final class MoreViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(MoreViewControllerCell.self)
        tableView.backgroundColor = UIColor.Base.white
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        return tableView
    }()
    
    var menuItems: [String] = ["На карте", "Реквизиты банка", "Сайт банка", "Новости", "Выйти"]
    
    var coreDataManager = CoreDataManager.shared
    
    let keychain = KeychainSwift()
    let timeOfLastRequest = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Base.white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension MoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
            case 0:
                let targetVC = OnMapViewController(viewModel: OnMapViewModel())
                navigationController?.pushViewController(targetVC, animated: true)
            case 4:
                coreDataManager.removeAll()
                keychain.delete("time")
                KeychainSwift().clear()
            default:
                break
        }
    }
}

//MARK: - UITableViewDataSource
extension MoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreViewControllerCell = tableView.dequeueReusableCell(for: indexPath)
        let title = menuItems[indexPath.row]
        cell.configure(title: title)
        cell.selectionStyle = .none
        return cell
    }
}
