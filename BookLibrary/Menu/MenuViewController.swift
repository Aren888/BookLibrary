//
//  MenuViewController.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 10.06.23.
//

import UIKit

protocol MenuAddBookDelegate: AnyObject {
    func didAddBook(_ book: Book)
    func didRemoveBook(title: String)
}


class MenuViewController: UIViewController, BookDelegate {

    weak var menuDelegate: MenuAddBookDelegate?
    
    @IBOutlet weak var removeBook: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var addNewBook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    lazy var blurredView: UIView = {
        let containerView = UIView()
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
        customBlurEffectView.frame = self.view.bounds
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmedView.frame = self.view.bounds
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    func setupView() {
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
        dismissButton.layer.cornerRadius = 20
        addNewBook.layer.cornerRadius = 20
        removeBook.layer.cornerRadius = 20
    }
    
    @IBAction func removeBookAction(_ sender: Any) {
        let vc = RemoveViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    @IBAction func addNewBookAction(_ sender: Any) {
        let vc = AddNewBookViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    func didAddNewBook(_ book: Book) {
        menuDelegate?.didAddBook(book)
        dismiss(animated: true)
        dismissAction(dismissButton!)
    }
    
    func didRemoveBook(title: String) {
        menuDelegate?.didRemoveBook(title: title)
        dismiss(animated: true)
        dismissAction(dismissButton!)
    }
}
