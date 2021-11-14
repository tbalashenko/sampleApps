//
//  FilialModel+CoreDataProperties.swift
//  
//
//  Created by Tatyana Balashenko on 14.05.21.
//
//

import Foundation
import CoreData

extension FilialModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilialModel> {
        return NSFetchRequest<FilialModel>(entityName: CoreDataType.filial.rawValue)
    }
    
    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var coordinates: [Double]?
    @NSManaged public var id: Int64
    @NSManaged public var kind: Int64
    @NSManaged public var name: String?
    @NSManaged public var phones: String?
    @NSManaged public var services: [String]?
    @NSManaged public var servicesForCorp: [String]?
    @NSManaged public var servicesForIndividuals: [String]?
    @NSManaged public var time: String?
}
