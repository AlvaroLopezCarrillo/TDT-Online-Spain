//
//  Channel.swift
//  TDT Online España
//
//  Created by Álvaro López Carrillo on 14/01/2020.
//  Copyright © 2020 Iberian Apps. All rights reserved.
//

import Foundation
import UIKit

class Channel: NSObject {
    
    var name: String?
    var logo: String?
    var url: String?
    
    
    override init() {
        super.init()
    }
    
    init(name: String?, logo: String?, url: String?){
        self.name = name
        self.logo = logo
        self.url = url
    }
    
}
