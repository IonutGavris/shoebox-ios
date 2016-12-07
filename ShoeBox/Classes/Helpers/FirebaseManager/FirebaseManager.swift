//
//  FirebaseManager.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 02/12/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit
import Firebase

typealias FirebaseManagerClosure = (NSArray?) -> Void

class FirebaseManager {

    static func extractAllSuggestions(using completion: @escaping (([Suggestion]) -> Void)) {
        
        extractFirebaseData(for: NSLocalizedString("shoeBox_suggestions_language_key", comment: ""), usingClosure: { results in
            
            var allSuggestions = [Suggestion]()
            if let results = results {
                for dict in results {
                    if dict is NSNull {
                        continue
                    }

                    let suggestion = Suggestion(dictionary: dict as! [String : AnyObject])
                    allSuggestions.append(suggestion)
                }
            }
            completion(allSuggestions)
        })
    }
    
    static func extractAllLocations(using completion: @escaping (([Location]) -> Void)) {
    
        extractFirebaseData(for: "locations", usingClosure: { results in
            
            var allLocations = [Location]()
            if let results = results {
                for dict in results {
                    let location = Location(dictionary: dict as! [String : AnyObject])
                    allLocations.append(location)
                }
            }
            completion(allLocations)
        })
    }
    
    
    private static func extractFirebaseData(for path: String, usingClosure completion: @escaping FirebaseManagerClosure) {
        
        let ref = FIRDatabase.database().reference(withPath: path)

        ref.observe(.value, with: { snapshot in
            var results: NSArray?
            if let array = snapshot.value as? NSArray {
                results = array
            }
            completion(results)
        })
    }
}
