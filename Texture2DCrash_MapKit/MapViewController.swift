//
//  MapViewController.swift
//  Texture2DCrash_MapKit
//
//  Created by Anatoli Macarov on 4/27/18.
//  Copyright © 2018 Macarov. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    //To avoid a MKMapView obj releasing at the rendering time
    //the app should check the controller status - allowFastClose.
    var allowFastClose = true

    deinit {
        print("Map deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        mapView.delegate = self
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(40.611791, -89.466959), span: MKCoordinateSpanMake(0.00001, 0.00001)), animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }

    @IBAction func closeMapScreen(_ sender: Any) {
        //MARK: Comment TRUE to enable workaround and below mark ↓
        if self.allowFastClose || true {
            self.dismiss(animated: false, completion: nil)
        } else {
            //If it's restricted then try a few times till rendering is finished or tiles are loading slowly.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
                self?.dismiss(animated: false, completion: nil)
            })
        }
    }
}
extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("mapViewWillStartRenderingMap")
        //Block a close transition of the view controller in the first seconds of his life
        //because the app crashes when releasing a MKMapView obj at the rendering process.
        allowFastClose = false

        //MARK: Uncomment to get a fast crash and above mark ↑
        //closeMapScreen(self)
    }

    public func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        //If network is slow then the mapViewDidFinishRenderingMap func will have a long call delay.
        //It will block the user on the Field screen, to avoid this we need to give a time for expected rendering of cached tiles.
        let delay = 1.0/*Enough time to render cached tiles.*/
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.allowFastClose = true
        }
    }

    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("mapViewDidFinishRenderingMap")
        //Func will be called faster then 1 sec if tiles are cached and user can safety to close the view controller
        //from MapViewController->closeMapScreen().
        allowFastClose = true
    }
}
