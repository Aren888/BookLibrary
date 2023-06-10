//
//  BookPreviewViewController.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 09.06.23.
//

import UIKit

class BookPreviewViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var bookModel: Book = Book(title: "", image: UIImage(), author: "", genre: "", publicationYear: 0, availability: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        componentsSetUp()
        configure()
    }
    
    @IBAction func settingsButtonAction(_ sender: Any) {
        let vc = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    

@IBAction func backButtonAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
}

func componentsSetUp() {
    backButton.layer.cornerRadius = 20
    backButton.layer.masksToBounds = true
    settings.layer.cornerRadius = 20
    settings.layer.masksToBounds = true
    label.layer.cornerRadius = 20
    label.layer.masksToBounds = true
    label.font = .boldSystemFont(ofSize: 12)
    imageView.layer.cornerRadius = 50
}
private func configure() {
    self.label.text = "\(bookModel.title)"
    self.imageView.image = bookModel.image
}

}
