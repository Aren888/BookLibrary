//
//  AddNewBookViewController.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 10.06.23.
//

import UIKit

class AddNewBookViewController: UIViewController {
    
    private let randomInt = Int.random(in: 1..<9)
    var onBookAdded: ((Book) -> Void)?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var publicationYearTextField: UITextField!
    @IBOutlet weak var availabilityStatusTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addBook(title: String, author: String, genre: String, publicationYear: Int, availabilityStatus: String) {
        let newBook = Book(title: title,
                           image: UIImage(named: "image\(randomInt)")!,
                           author: author,
                           genre: genre,
                           publicationYear: publicationYear,
                           availability: availabilityStatus)
        onBookAdded?(newBook)
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        if let title = titleTextField.text,
           let author = authorTextField.text,
           let genre = genreTextField.text,
           let publicationYear = Int(publicationYearTextField.text!),
           let availabilityStatus = availabilityStatusTextField.text {
            addBook(title: title, author: author, genre: genre, publicationYear: publicationYear, availabilityStatus: availabilityStatus)
            print("OK")
        }
       
        
    }
}

