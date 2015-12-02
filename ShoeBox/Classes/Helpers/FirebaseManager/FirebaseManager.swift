//
//  FirebaseManager.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 02/12/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

typealias FirebaseManagerClosure = NSArray? -> Void

class FirebaseManager: NSObject {

    class func extractFirebaseDataForPath(path: String, usingClosure completion: FirebaseManagerClosure) {
        let urlString = Constants.ENDPOINT_FIREBASE + "/\(path)"
        let ref = Firebase(url: urlString)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            var results: NSArray?
            if let array = snapshot.value as? NSArray {
                results = array
            }
            completion(results)

            }, withCancelBlock: { error in
                print(error.description)
        })
    }
}
