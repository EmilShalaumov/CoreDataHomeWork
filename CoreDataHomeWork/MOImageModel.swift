//
//  MOImageModel.swift
//  CoreDataHomeWork
//
//  Created by Эмиль Шалаумов on 24.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation
import CoreData

@objc(MOImageModel)
internal class MOImageModel: NSManagedObject {
    @NSManaged var desc: String
    @NSManaged var image: NSObject
}
