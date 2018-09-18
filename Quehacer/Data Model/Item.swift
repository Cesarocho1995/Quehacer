//
//  Item.swift
//  Quehacer
//
//  Created by Cesar Enrique Mora Guerra on 9/10/18.
//  Copyright © 2018 Cesar Enrique Mora Guerra. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var  title : String = ""
    @objc dynamic var  done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
