//
//  BankListViewController.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import UIKit
import CoreLocation
import UserNotifications
import GoogleMaps

final class OnMapViewController: UIViewController {
    private enum Dimensions {
        static let sideSpacing = 16
        static let topBarHeight = 40
        static let spaceToNavigationBar = 6
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(BankListViewCell.self)
        tableView.backgroundColor = UIColor.Base.white
        tableView.backgroundView = emptyView
        tableView.isHidden = true
        tableView.separatorInset = .zero
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        return tableView
    }()
    
    private lazy var emptyView = EmptyView(text: "", imageName: "search")
    
    private lazy var map = GMSMapView()
    
    private lazy var marker = GMSMarker()
    
    private lazy var camera = GMSCameraPosition()
    
    private var segmentControl = SegmentControl()
    
    var viewModel: OnMapViewModel
    
    var locationManager = LocationManager.shared
    
    init(viewModel: OnMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "На карте"
        view.backgroundColor = UIColor.Base.white
        configure()
        addSubviews()
        setupConstraints()
        setupSegmentControl()
        setupTabBar(show: true)
        setupMap()
        locationManager.locationManagerDelegate = viewModel
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTabBar(show: false)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(map)
        view.addSubview(segmentControl)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        map.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Dimensions.spaceToNavigationBar)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.sideSpacing)
            $0.height.equalTo(Dimensions.topBarHeight)
        }
    }
    
    private func setupTabBar(show: Bool) {
        tabBarController?.tabBar.isHidden = show
    }
    
    private func setupSegmentControl() {
        segmentControl.setupButtonsTitle(firstButtonTitle: "Карта", secondButtonTitle: "Список")
        segmentControl.firstButton.addTarget(self, action: #selector(showMap), for: .touchUpInside)
        segmentControl.secondButton.addTarget(self, action: #selector(showList), for: .touchUpInside)
    }
    
    func setupMap() {
        guard let position = viewModel.position else { return }
        
        marker.position = position
        marker.map = map
        camera = GMSCameraPosition(target: position, zoom: 17.0)
        map.animate(to: camera)
        map.delegate = self
        addMarkers()
    }
    
    private func addMarkers() {
        for item in viewModel.simpleBanks {
            let marker: GMSMarker = GMSMarker()
            marker.title = item.name
            marker.snippet = item.address
            marker.icon = item.kind == .filial ? UIImage(named: "filial") : UIImage(named: "atm")
            marker.appearAnimation = .pop
            marker.position = CLLocationCoordinate2D(latitude: item.coordinates[1], longitude: item.coordinates[0])
            DispatchQueue.main.async { [self] in
                marker.map = map
            }
        }
    }
    
    private func configure() {
        viewModel.loadData()
    }
    
    @objc private func showMap() {
        tableView.isHidden = true
        map.isHidden = false
        segmentControl.didClickButton(with: 0)
    }
    
    @objc private func showList() {
        tableView.isHidden = false
        map.isHidden = true
        segmentControl.didClickButton(with: 1)
    }
}

//MARK: - UITableViewDelegate
extension OnMapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMap()
        let coordinates = viewModel.simpleBanks[indexPath.row].coordinates
        camera = GMSCameraPosition(latitude: coordinates[1], longitude: coordinates[0], zoom: 17.0)
        map.animate(to: camera)
    }
}

//MARK: - UITableViewDataSource
extension OnMapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = viewModel.simpleBanks.count == 0 ? .none : .singleLine
        
        return viewModel.simpleBanks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BankListViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateWithEntity(bank: viewModel.simpleBanks[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - OnMapViewModelDelegate
extension OnMapViewController: OnMapViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: - GMSMapViewDelegate
extension OnMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        camera = GMSCameraPosition(latitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 15.0)
        map.animate(to: camera)
        return true
    }
}
