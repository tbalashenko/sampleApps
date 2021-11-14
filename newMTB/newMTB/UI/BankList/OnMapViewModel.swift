//
//  BankListViewModel.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import UIKit
import CoreLocation
import CoreData
import KeychainSwift

protocol OnMapViewModelDelegate: AnyObject {
    func reloadData()
    func setupMap()
}

final class OnMapViewModel {
    let filialUrl = "https://alseda.by/api/v1/info/filial/?bank=20"
    let atmUrl = "https://alseda.by/api/v1/info/atm/?bank=20"
    var location = LocationManager.shared.location
    
    var position: CLLocationCoordinate2D? {
        guard
            let latitude = location?.coordinate.latitude,
            let longitude = location?.coordinate.longitude
        else { return nil }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    let timeOfLastRequest = UserDefaults.standard
    let isConnection = NetworkMonitor.shared.isConnected
    let keychain = KeychainSwift()
    
    var banks: [BankEntity] = []
    var simpleBanks: [SimpleBank] = []
    var coreDataManager = CoreDataManager.shared
    
    weak var delegate: OnMapViewModelDelegate?

    func loadData() {
        let isShouldUpdate = shouldUpdate()
        
        if !isConnection || !isShouldUpdate {
            let group = DispatchGroup()
            DispatchQueue.global(qos: .userInteractive).async { [self] in
                group.enter()
                fetchFilial {
                    group.leave()
                }
                
                group.enter()
                fetchATM {
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    createSortArray { }
                    delegate?.reloadData()
                    delegate?.setupMap()
                }
            }
        } else if isShouldUpdate {
            let group = DispatchGroup()
            DispatchQueue.global(qos: .userInteractive).async { [self] in
                group.enter()
                sendRequest {
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    createSortArray { }
                    delegate?.reloadData()
                }
            }
        }
    }
    
    func shouldUpdate() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nowDate = Date()
        
        guard
            let time = keychain.get("time"),
            let formatedDate = formatter.date(from: time)
        else { return true }

        return nowDate > formatedDate.addingTimeInterval(60 * 60 * 24)
    }
    
    func sendRequest(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            let group = DispatchGroup()
            group.enter()
            NetworkManager.shared.request(
                url: filialUrl,
                successHandler: { [weak self] (response: FilialResponse) in
                    self?.handleResponse(response: response)
                    group.leave()
                },
                errorHandler: { [weak self] (error: NetworkManager.MWNetworkError) in
                    self?.handleError(error: error, entity: .filial)
                    group.leave()
                }
            )
            group.enter()
            NetworkManager.shared.request(
                url: atmUrl,
                successHandler: { [weak self] (response: AtmResponse) in
                    self?.handleResponse(response: response)
                    group.leave()
                },
                errorHandler: { [weak self] (error: NetworkManager.MWNetworkError) in
                    self?.handleError(error: error, entity: .atm)
                    group.leave()
                })
            group.notify(queue: .main) {
                createSortArray {
                    completion()
                }
            }
        }
    }
    
    func createSortArray(completion: @escaping () -> Void) {
        if simpleBanks.isEmpty {
            for item in banks {
                guard
                    let name = item.name,
                    let city = item.city,
                    let address = item.address,
                    let coordinates = item.coordinates
                else { continue }
                
                switch item {
                    case is AtmEntity:
                        let bankKind = BankKind.atm
                        let fullAddress = city + ", " + address
                        let distance = getDistance(bankLatitude: coordinates[1], bankLongitude: coordinates[0])
                        
                        let bank = SimpleBank(name: name, address: fullAddress, distance: distance, coordinates: coordinates, kind: bankKind)
                       
                        simpleBanks.append(bank)
                    case is FilialEntity:
                        let bankKind = BankKind.filial
                        let fullAddress = address
                        let distance = getDistance(bankLatitude: coordinates[1], bankLongitude: coordinates[0])
                        
                        let bank = SimpleBank(name: name, address: fullAddress, distance: distance, coordinates: coordinates, kind: bankKind)
                        
                        simpleBanks.append(bank)
                    default:
                        continue
                }
            }
        }
        simpleBanks = simpleBanks.sorted(by: { $0.distance ?? Double(Int.max) < $1.distance ?? Double(Int.min) })
        completion()
    }
    
    private func handleResponse(response: FilialResponse) {
        if let time = response.serverTime {
            keychain.set(time, forKey: "time")
        }
        
        let filials = response.items ?? []
        banks += filials
        
        guard
            let context = coreDataManager.filialManagedObjectContext,
            checkIsDBEmpty(context: context, entity: .filial, error: .none)
        else { return }
        
        saveFilialInCD(items: filials)
    }
    
    private func handleResponse(response: AtmResponse) {
        let atms = response.items ?? []
        banks += atms
        
        guard
            let context = coreDataManager.atmManagedObjectContext,
            checkIsDBEmpty(context: context, entity: .atm, error: .none)
        else { return }
        
        saveATMInCD(items: atms)
    }
    
    private func saveATMInCD(items: [AtmEntity]) {
        guard let context = coreDataManager.atmManagedObjectContext else { return }
        
        for item in items {
            _ = AtmModel(item: item)
            coreDataManager.saveContext(context: context)
        }
    }
    
    private func saveFilialInCD(items: [FilialEntity]) {
        guard let context = coreDataManager.filialManagedObjectContext else { return }
        
        for item in items {
            _ = FilialModel(item: item)
            coreDataManager.saveContext(context: context)
        }
    }
    
    private func handleError(error: NetworkManager.MWNetworkError, entity: CoreDataType) {
        switch entity {
            case .filial:
                guard
                    let context = coreDataManager.filialManagedObjectContext,
                    checkIsDBEmpty(context: context, entity: .filial, error: error)
                else {
                    print("data not exist")
                    return
                }
                
                fetchFilial { }
            case .atm:
                guard
                    let context = coreDataManager.atmManagedObjectContext,
                    checkIsDBEmpty(context: context, entity: .atm, error: error)
                else {
                    print("data not exist")
                    return
                }
                fetchATM { }
        }
    }
    
    private func checkIsDBEmpty(context: NSManagedObjectContext, entity: CoreDataType, error: NetworkManager.MWNetworkError?) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        do {
            let result = try context.fetch(fetchRequest)
            return result.isEmpty
        } catch {
            print(error)
            return false
        }
    }
    
    private func fetchATM(completion: @escaping () -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AtmModel")
        do {
            guard let managedObjectContext = coreDataManager.atmManagedObjectContext else { return }
            
            let results = try managedObjectContext.fetch(fetchRequest)
            for result in results as! [AtmModel] {
                guard
                    let address = result.address,
                    let name = result.name,
                    let coordinates = result.coordinates
                else { return }
                
                let distance = getDistance(bankLatitude: coordinates[1], bankLongitude: coordinates[0])
                let atm = SimpleBank(name: name, address: address, distance: distance, coordinates: coordinates, kind: .atm)
                simpleBanks.append(atm)
            }
            completion()
        } catch {
            print(error)
        }
    }
    
    private func fetchFilial(completion: @escaping () -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FilialModel")
        do {
            guard let managedObjectContext = coreDataManager.filialManagedObjectContext else { return }
            let results = try managedObjectContext.fetch(fetchRequest)
            for result in results as! [FilialModel] {
                guard
                    let address = result.address,
                    let name = result.name,
                    let coordinates = result.coordinates
                else { return }
                
                let distance = getDistance(bankLatitude: coordinates[1], bankLongitude: coordinates[0])
                let filial = SimpleBank(name: name, address: address, distance: distance, coordinates: coordinates, kind: .filial)
                simpleBanks.append(filial)
            }
            completion()
        } catch {
            print(error)
        }
    }
    
    private func getDistance(bankLatitude: CLLocationDegrees, bankLongitude: CLLocationDegrees) -> Double? {
        guard let loc1 = location else { return nil }
        
        let loc2 = CLLocation(latitude: bankLatitude, longitude: bankLongitude)
        let distance = (loc1.distance(from: loc2) / 1000)
        return distance
    }
}

// MARK: - LocationManagerDelegate
extension OnMapViewModel: LocationManagerDelegate {
    func updateLocation(location: CLLocation) {
        print(location)
        self.location = location
        createSortArray { [weak self] in
            self?.delegate?.reloadData()
            self?.delegate?.setupMap()
        }
    }
}
