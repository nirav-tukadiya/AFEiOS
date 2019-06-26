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
        let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine;
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)!;
        self.present(flutterViewController, animated: true, completion: nil)
        
        
        //Set up data channel to send/receive data from AFE_Flutter
        let afeDataChannel = FlutterMethodChannel(name: "in.androidgeek.afe/data",
                                                  binaryMessenger: flutterViewController)
        
        
        //setting up method call handler to receive data from AFE_Flutter
        afeDataChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            
            //receiving data from AFE_Flutter and showing results in UI
            
            guard call.method == "FromClientToHost" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            flutterViewController.dismiss(animated: true, completion: nil)
            
            var dictonary:NSDictionary? = call.arguments as? NSDictionary
            
            if(call.arguments != nil){
                
                self?.lResult.text = "\((dictonary!["operation"] as! String)=="Add" ? "Addition" : "Multiplication"): \(dictonary!["result"]!)"
               
            }else{
                self?.lResult.text = "Could not perform the operation"
            }
 
        })
        
        //Sending data to AFE_Flutter
        
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(first, forKey: "first")
        jsonObject.setValue(second, forKey: "second")
        
        var convertedString: String? = nil
        do{
            let data1 =  try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            convertedString = String(data: data1, encoding: String.Encoding.utf8)
        } catch let myJSONError {
            print(myJSONError)
        }
        
        afeDataChannel.invokeMethod("fromHostToClient", arguments: convertedString)
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

