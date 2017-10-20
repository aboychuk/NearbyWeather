//
//  WelcomeScreenViewController.swift
//  NearbyWeather
//
//  Created by Erik Maximilian Martens on 15.04.17.
//  Copyright © 2017 Erik Maximilian Martens. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var getInstructionsButtons: UIButton!
    
    
    // MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("WelcomeScreenVC_NavigationBarTitle", comment: "")
        navigationController?.navigationBar.styleStandard(withTransluscency: false, animated: true)
        checkValidTextFieldInput()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        inputTextField.becomeFirstResponder()
    }
    
    // MARK: - Helper Functions
    
    func setUp() {
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.text! = NSLocalizedString("WelcomeScreenVC_Description", comment: "")
        
        saveButton.setTitle(NSLocalizedString("WelcomeScreenVC_SaveButtonTitle", comment: ""), for: .normal)
        saveButton.setTitleColor(UIColor(red: 39/255, green: 214/255, blue: 1, alpha: 1.0), for: .normal)
        saveButton.setTitleColor(.white, for: .highlighted)
        saveButton.setTitleColor(.gray, for: .disabled)
        saveButton.layer.cornerRadius = 5.0
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        saveButton.layer.borderWidth = 1.0
        
        getInstructionsButtons.setTitle(NSLocalizedString("WelcomeScreenVC_GetInstructionsButtonTitle", comment: ""), for: .normal)
        getInstructionsButtons.setTitleColor(UIColor(red: 39/255, green: 214/255, blue: 1, alpha: 1.0), for: .normal)
        getInstructionsButtons.setTitleColor(.white, for: .highlighted)
    }
    
    
    // MARK: - TextField Interaction
    
    @IBAction func inputTextFieldEditingChanged(_ sender: UITextField) {
        checkValidTextFieldInput()
        if saveButton.isEnabled {
            saveButton.layer.borderColor = UIColor(red: 39/255, green: 214/255, blue: 1, alpha: 1.0).cgColor
        } else {
            saveButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private func checkValidTextFieldInput() {
        let text = inputTextField.text ?? ""
        saveButton.isEnabled = text.characters.count == 32
    }
    
    
    // MARK: - Button Interaction
    
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        inputTextField.resignFirstResponder()
        UserDefaults.standard.set(inputTextField.text, forKey: "nearby_weather.openWeatherMapApiKey")
        
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "SetPermissionsVC") as! SetPermissionsViewController
        
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    @IBAction func didTapGetInstructionsButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://openweathermap.org/appid")!, options: [:], completionHandler: nil)
    }
}
