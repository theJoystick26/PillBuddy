//
//  Medication+CoreDataProperties.swift
//  PillBuddy
//
//  Created by Adin Joyce on 10/3/22.
//
//

import Foundation
import CoreData


extension Medication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medication> {
        return NSFetchRequest<Medication>(entityName: "Medication")
    }

    @NSManaged public var name: String?
    @NSManaged public var dosage: Int64
    @NSManaged public var daysLeft: Int64

}

extension Medication : Identifiable {

}
