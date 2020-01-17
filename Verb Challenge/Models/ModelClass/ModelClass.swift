//
//  ModelClass.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation

struct ModelClass: Hashable {
    
    // MARK: - Properties
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.description)
    }
    
    let description: String
    
    
    // MARK: - Initialization
    
    public init(_ classType: Any.Type) {
        self.description = String(describing: classType)
    }
    
    
    // MARK: - Hashable
    
    static func == (lhs: ModelClass, rhs: ModelClass) -> Bool {
        return lhs.description == rhs.description
    }
    
}
