//
//  FilialModel+CoreDataClass.swift
//  
//
//  Created by Tatyana Balashenko on 14.05.21.
//
//

import Foundation
import CoreData

public class FilialModel: NSManagedObject {
    convenience init() {
        let managedObjectContext = CoreDataManager.shared.filialManagedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "FilialModel", in: managedObjectContext!)
        self.init(entity: entity!, insertInto: managedObjectContext)
    }
}
