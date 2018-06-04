//
//  ViewController.swift
//  Texture2DCrash_MapKit
//
//  Created by Anatoli Macarov on 4/27/18.
//  Copyright © 2018 Macarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("*************************************\n" +
            "The VectorKit crash repro steps - you need quickly open/close the map screen on iOS 11. Tap 'Show Map Screen' button.\n" +
            "If you installed app first time please wait to cache Apple's tiles (You need to see them on the map).\n" +
            "If you can not crash then re-run app and try on the device too.\n" +
            "The crash happens in 2-8 attempts.\n" +
            "If you are not lucky then use the marks in the MapViewController class. Please follow them and uncomment necessary lines of code.\n" +
            "*************************************\n")
    }
}
