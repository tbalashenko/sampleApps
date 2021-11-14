//
//  AtmModel+CoreDataProperties.swift
//  
//
//  Created by Tatyana Balashenko on 18.05.21.
//
//

import Foundation
import CoreData

extension AtmModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AtmModel> {
        return NSFetchRequest<AtmModel>(entityName: CoreDataType.atm.rawValue)
    }
    
    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var coordinates: [Double]?
    @NSManaged public var currencies: [String]?
    @NSManaged public var id: Int64
    @NSManaged public var isTerminal: Bool
    @NSManaged public var metro: String?
    @NSManaged public var name: String?
    @NSManaged public var time: String?
}
