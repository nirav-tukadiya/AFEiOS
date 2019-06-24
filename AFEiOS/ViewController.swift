//
//  ViewController.swift
//  AFEiOS
//
//  Created by NIRAV on 24/06/19.
//  Copyright © 2019 NIRAV. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    @IBOutlet weak var firstNumber: UITextField!
    @IBOutlet weak var secondNumber: UITextField!
    @IBOutlet weak var bSend: UIButton!
    @IBOutlet weak var lResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func validateInputs(_ sender: Any) {
        let (first, second) = isInputValid()
        if(first != 0 && second != 0){
            sendDataToFlutterModule(first: first, second: second)
        }
    }
    
    func sendDataToFlutterModule(first: Int, second: Int) {
        // TODO will be implemented later
        let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine;
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)!;
        self.present(flutterViewController, animated: false, completion: nil)
        
    }
    
    func isInputValid() -> (Int, Int){
        
        let sFirst = firstNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let sSecond = secondNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if(sFirst.isEmpty){
            showMessage(msg: "Please enter first number")
        }else if(sSecond.isEmpty){
            showMessage(msg: "Please enter second number")
        }else{
            return (Int(sFirst)!, Int(sSecond)!)
        }
        return (0,0)
    }
    
    func showMessage(msg: String){
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

