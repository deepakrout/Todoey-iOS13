//
//  Category.swift
//  Todoey
//
//  Created by Deepak Rout on 6/28/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var bgColor: String = ""
    let items = List<Item>()
}
