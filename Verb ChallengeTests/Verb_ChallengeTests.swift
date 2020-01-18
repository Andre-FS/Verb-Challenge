//
//  Verb_ChallengeTests.swift
//  Verb ChallengeTests
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Verb_Challenge

private let FlickrPhotoURL = URL(string: "https://farm66.staticflickr.com/65535/49403612466_88a784008e_c.png")!

class Verb_ChallengeTests: XCTestCase {

    override func setUp() {
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Unit Test Database"
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
    }

    override func tearDown() {
    }

    func testStorePhotos() {
        
        let realm = try! Realm()
        
        let numberOfStoredPhotosBefore = realm.objects(StorablePhoto.self).count
        
        let testPhoto = StorablePhoto(url: FlickrPhotoURL)
        let photoStorage = PhotoStorage()
        photoStorage.storePhotos([testPhoto])
        
        let numberOfStoredPhotosAfter = realm.objects(StorablePhoto.self).count
        
        XCTAssertTrue(numberOfStoredPhotosAfter == numberOfStoredPhotosBefore + 1)
        
    }
    
    func testRetrievePhotos() {
        
        let realm = try! Realm()
        
        let testPhoto = StorablePhoto(url: FlickrPhotoURL)
        let photoStorage = PhotoStorage()
        photoStorage.storePhotos([testPhoto])
        
        let storedPhoto = realm.objects(StorablePhoto.self).first!
        
        XCTAssertTrue(storedPhoto.urlString == FlickrPhotoURL.absoluteString)
        
    }
    
    func testFlickrModelParsing() {
        
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "FlickrMockResponse", withExtension: "json") else {
            
            XCTFail("Unable to find mock FlickrMockResponse.json file")
            return
            
        }

        let jsonData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let model = try! decoder.decode(FlickrPhotoResponse.self, from: jsonData)

        XCTAssertEqual(model.photos.photo.count, 5)
        XCTAssertEqual(model.photos.photo.first!.farm, 66)
        XCTAssertEqual(model.photos.photo.first!.id, "49403631676")
        XCTAssertEqual(model.photos.photo.first!.secret, "b5552f1a23")
        XCTAssertEqual(model.photos.photo.first!.server, "65535")
        XCTAssertEqual(model.photos.photo.first!.url!.absoluteString, "https://farm66.staticflickr.com/65535/49403631676_b5552f1a23_c.png")
        
    }

}
