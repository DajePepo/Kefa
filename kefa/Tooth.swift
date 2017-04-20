//
//  Tooth.swift
//  kefa
//
//  Created by Pietro Santececca on 20/03/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

class Tooth: NSObject {
    
    var id: Int
    var name: String
    var status: String
    
    init(id: Int, name: String?, status: String?) {
        self.id = id
        self.name = name != nil ? name! : ""
        self.status = status != nil ? status! : ""
        super.init()
    }

}
