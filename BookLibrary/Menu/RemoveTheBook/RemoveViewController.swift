//
//  RemoveViewController.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 13.06.23.
//

import UIKit

class RemoveViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    var removedData: [Book] = []
    var selectedBookTitle: String = ""
    weak var delegate: BookDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataVariable()
        pickerView.reloadAllComponents()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func getDataVariable() {
        let vc = LibraryViewController()
        removedData = vc.data
        pickerView.reloadAllComponents()
    }
    
    @IBAction func removeBookAction(_ sender: Any) {
        delegate?.didRemoveBook(title: selectedBookTitle)
        getDataVariable()
        dismiss(animated: true)
    }
}


extension RemoveViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return removedData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return removedData[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBookTitle = removedData[row].title
        
        print("Selected fruit: \(removedData[row].title)")
    }
}
