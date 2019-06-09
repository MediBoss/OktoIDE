//
//  File+CoreDataProperties.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/8/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//
//

import Foundation
import CoreData


extension File {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<File> {
        return NSFetchRequest<File>(entityName: "File")
    }

    @NSManaged public var name: String?
    @NSManaged public var content: String?
    @NSManaged public var ext: String?

}
