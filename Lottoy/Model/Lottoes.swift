//
//  Lottoes.swift
//  Lottoy
//
//  Created by kibeom lee on 2018. 5. 31..
//  Copyright © 2018년 kibeom lee. All rights reserved.
//

import Foundation
import RealmSwift

class Lottoes: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var round: String = ""
    @objc dynamic var isdone: Bool = false
    @objc dynamic var win: String = ""
    @objc dynamic var num1: String = ""
    @objc dynamic var num2: String = ""
    @objc dynamic var num3: String = ""
    @objc dynamic var num4: String = ""
    @objc dynamic var num5: String = ""
    @objc dynamic var num6: String = ""
    @objc dynamic var bonus: String = ""
    @objc dynamic var date: Date = Date()
    
}
