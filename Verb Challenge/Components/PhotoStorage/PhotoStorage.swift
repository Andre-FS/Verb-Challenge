//
//  PhotoStorage.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoStorage {
    
    // MARK: - Internal
    
    func storePhotos(_ photos: [StorablePhoto]) {
        
        do {
            
            let realm = try Realm()
            
            try? realm.write {
                realm.add(photos, update: Realm.UpdatePolicy.modified)
            }
            
        } catch let error {
            print(error)
        }
        
    }
    
    func retrievePhotos() -> [Photo] {
        
        do {
            
            let realm = try Realm()
            let photos = realm.objects(StorablePhoto.self)
            
            return Array(photos)
            
        } catch let error {
            
            print(error)
            return []
            
        }
        
    }
    
}
