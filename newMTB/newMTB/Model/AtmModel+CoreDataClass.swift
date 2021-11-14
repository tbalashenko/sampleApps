//
//  AtmModel+CoreDataClass.swift
//  
//
//  Created by Tatyana Balashenko on 18.05.21.
//
//

import Foundation
import CoreData

public class AtmModel: NSManagedObject {
    convenience init() {
        let managedObjectContext = CoreDataManager.shared.atmManagedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "AtmModel", in: managedObjectContext!)
        self.init(entity: entity!, insertInto: managedObjectContext)
    }
}
