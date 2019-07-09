//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Darin Marcus Armstrong on 7/8/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    
        guard let title = titleTextField.text, title != "",
            let body = bodyTextView.text, body != "" else {return}
        
        if let entry = entry{
            EntryController.shared.updateEntryWith(entry: entry, title: title, body: body) { (true) in
                print("success")
            }
            self.navigationController?.popViewController(animated: true)
        } else {
            EntryController.shared.addEntryWith(title: title, body: body) { (true) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func updateViews() {
        if entry != nil {
            titleTextField.text = entry?.title
            bodyTextView.text = entry?.body
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
}

extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
