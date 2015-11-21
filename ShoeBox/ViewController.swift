//
//  ViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 19/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Get a reference to firebase locations endpoint
    var ref = Firebase(url: "https://shoebox.firebaseio.com/locations")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Attach a closure to read the data from firebase
        ref.observeEventType(.Value, withBlock: { snapshot in
                print(snapshot.value)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

