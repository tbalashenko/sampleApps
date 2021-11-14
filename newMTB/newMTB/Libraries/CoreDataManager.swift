//
//  CoreDataManager.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 14.05.21.
//

import Foundation
import CoreData

enum CoreDataType: String {
    case atm = "AtmModel"
    case filial = "FilialModel"
}

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var atmManagedObjectContext = setupManagedObjectContext(modelName: .atm)
    
    lazy var filialManagedObjectContext = setupManagedObjectContext(modelName: .filial)
    
    private init() { }
    
    private func applicationDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    private func createManagedObjectModel(modelName: CoreDataType) -> NSManagedObjectModel? {
        let modelURL = Bundle.main.url(forResource: modelName.rawValue, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    private func createPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel,
                                                  modelName: CoreDataType) -> NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let modelName_sqlite = "\(modelName.rawValue).sqlite"
        var storeURL = applicationDocumentsDirectory()
        storeURL?.appendPathComponent(modelName_sqlite)
        let failureReason = "There was an error creating or loading the application's saved data."
        let options: [String : Any] = [ NSMigratePersistentStoresAutomaticallyOption : true,
                                        NSInferMappingModelAutomaticallyOption : false,
                                        NSSQLitePragmasOption : [ "journal_mode" : "DELETE" ] ]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        } catch {
            let dict: [String : Any] = [ NSLocalizedDescriptionKey : "Failed to initialize the application's saved data",
                                         NSLocalizedFailureReasonErrorKey : failureReason,
                                         NSUnderlyingErrorKey : error as Any ]
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }
    
    private func createManagedObjectCOntext(persistentStoreCoordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let coordinator = persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }
    
    func setupManagedObjectContext(modelName: CoreDataType) -> NSManagedObjectContext? {
        guard let managedObjectModel = createManagedObjectModel(modelName: modelName) else {
            return nil
        }
        let persistentStoreCoordinator = createPersistentStoreCoordinator(managedObjectModel: managedObjectModel, modelName: modelName)
        let managedObjectContext = createManagedObjectCOntext(persistentStoreCoordinator: persistentStoreCoordinator)
        return managedObjectContext
    }
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as Error
                Swift.debugPrint(error)
                abort()
            }
        }
    }
    
    func removeAll() {
        let modelsDict = [(context: atmManagedObjectContext, name: CoreDataType.atm.rawValue), (context: filialManagedObjectContext, name: CoreDataType.filial.rawValue)]
        for item in modelsDict {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: item.name)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let result = try item.context?.fetch(fetchRequest)
                result?.forEach { item.context?.delete($0) }
                try item.context?.save()
            } catch let error as NSError {
                Swift.debugPrint("Couldn't remove data. \(error), \(error.userInfo)")
            }
        }
    }
}
