//
//  Category.swift
//  Quehacer
//
//  Created by Cesar Enrique Mora Guerra on 9/10/18.
//  Copyright © 2018 Cesar Enrique Mora Guerra. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var  name : String = ""
    let items = List<Item>()
}
