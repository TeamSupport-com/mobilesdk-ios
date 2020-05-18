//
//  SettingsViewController.swift
//  SnapEngage
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import UIKit
import SnapEngageSDK

class SettingsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var entryPageTextField: UITextField!
    @IBOutlet weak var providerTextField: UITextField!
    
    private var customVariables: [(String, Any)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        self.providerTextField.resignFirstResponder()
        self.urlTextField.resignFirstResponder()
    }
    
    @IBAction func save(_ sender: Any) {
        guard
            let jsUrlString = urlTextField.text,
            let jsUrl = URL(string: jsUrlString),
            let entryPageString = entryPageTextField.text,
            let entryPageUrl = URL(string: entryPageString),
            let provider = providerTextField.text
        else {
            self.showNotValidUrlsPopup()
            return
        }
        
        let configuration = ChatConfiguration(jsUrl: jsUrl, provider: provider, entryPageUrl: entryPageUrl, customVariables: self.createCustomVariablesDictionary())
        
        self.dismissKeyboard()
        
        NotificationCenter.default.post(name: NSNotification.Name("saveConfig"), object: nil, userInfo: [
            "config" : configuration
        ])
    }
    
    @IBAction func addBool(_ sender: Any) {
        let prefix = "boolean_"
        let value = Bool.random()
        
        self.addNewVariable(prefix: prefix, value: value)
    }
    
    @IBAction func addFloat(_ sender: Any) {
        let prefix = "float_"
        let value = Float.random(in: 0...1)
        
        self.addNewVariable(prefix: prefix, value: value)
        self.tableView.reloadData()
    }
    
    @IBAction func addDouble(_ sender: Any) {
        let prefix = "double_"
        let value = Double.random(in: 0...1)
        
        self.addNewVariable(prefix: prefix, value: value)
    }
    
    @IBAction func addString(_ sender: Any) {
        let prefix = "string_"
        let value = self.randomString(length: 5)
        
        self.addNewVariable(prefix: prefix, value: value)
    }
    
    @IBAction func clear(_ sender: Any) {
        self.customVariables.removeAll()
        self.tableView.reloadData()
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customVariables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customVariableCell", for: indexPath)
        
        let customVariable = self.customVariables[indexPath.row]
        
        cell.textLabel?.text = customVariable.0
        cell.detailTextLabel?.text = "\(customVariable.1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.customVariables.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Private
    
    private func createCustomVariablesDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        self.customVariables.forEach { (variable) in
            dict[variable.0] = variable.1
        }
        
        return dict
    }
    
    private func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
    
    private func addNewVariable(prefix: String, value: Any) {
        let count = self.customVariables.filter { $0.0.contains(prefix) }.count
        
        let key = prefix + "\(count + 1)"
        
        self.customVariables.append((key, value))
        self.tableView.reloadData()
    }
    
    private func showNotValidUrlsPopup() {
        let alert = UIAlertController(title: "Error", message: "Not valid urls", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

