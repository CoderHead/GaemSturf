//
//  ViewController.swift
//  GaemSturf
//
//  Created by Jonathan Willis on 9/10/19.
//  Copyright © 2019 WillisWare, LLC. All rights reserved.
//
import CoreLocation
import MapKit
import UIKit

class ViewController:
    UIViewController,
    CLLocationManagerDelegate,
    MKMapViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!

    let _locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleTextField.delegate = self

        getLocation()

        let viewRegion = MKCoordinateRegion(center: mapView.centerCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(viewRegion, animated: true)
    }

    //MARK: Actions
    @IBAction func submitButtonDidTapInside(_ sender: UIButton) {
        titleLabel.text = titleTextField.text!.capitalized
    }
    @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
        submitButton.isEnabled = !textField.text!.isEmpty
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func photoImageViewDidTap(_ sender: UITapGestureRecognizer) {
        titleTextField.resignFirstResponder()

        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self

        present(imagePickerController, animated: true, completion: nil)
    }

    func getLocation() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            _locationManager.requestWhenInUseAuthorization()
            break
        case .denied, .restricted:
            let alertTitle = NSLocalizedString("LocationAlertTitle", comment: "The title of the alert for denied location services.")
            let alert = UIAlertController(title: alertTitle, message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }

        _locationManager.delegate = self
        _locationManager.activityType = .otherNavigation
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.distanceFilter = 0
        _locationManager.pausesLocationUpdatesAutomatically = true
        _locationManager.startUpdatingLocation()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        photoImageView.image = UIImage(named: "defaultPhoto")
        dismiss(animated: true, completion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { fatalError() }

        locationLabel.text = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
        mapView.setCenter(currentLocation.coordinate, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationLabel.text = "Something's jacked! \(error)"
    }
}
