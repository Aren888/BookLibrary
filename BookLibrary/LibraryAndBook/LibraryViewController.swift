//
//  ViewController.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 09.06.23.
//

import UIKit

class LibraryViewController: UIViewController, MenuAddBookDelegate {

    @IBOutlet weak var lineHorizontal3Button: UIButton!
    @IBOutlet weak var collectiionView: UICollectionView!
    
    let itemSpacing: CGFloat = 8
    let insetSize: CGFloat = 10
    var data = [Book(title: "1984", image: UIImage(named: "image1")!, author: "George Orwell", genre: "Dystopian", publicationYear: 1949, availability: "available", borrower: nil, reservation: nil),
                Book(title: "To Kill a Mockingbird", image: UIImage(named: "image2")!, author: "Harper Lee", genre: "Fiction", publicationYear: 1960, availability: "available", borrower: nil, reservation: nil),
                Book(title: "The Great Gatsby", image: UIImage(named: "image3")!, author: "F. Scott Fitzgerald", genre: "Classic", publicationYear: 1925, availability: "available", borrower: nil, reservation: nil),
                Book(title: "Harry Potter and the Sorcerer's Stone", image: UIImage(named: "image4")!, author: "J.K. Rowling", genre: "Fantasy", publicationYear: 1997, availability: "available", borrower: nil, reservation: nil),
                Book(title: "Pride and Prejudice", image: UIImage(named: "image5")!, author: "Jane Austen", genre: "Romance", publicationYear: 1813, availability: "available", borrower: nil, reservation: nil),
                Book(title: "1984", image: UIImage(named: "image1")!, author: "George Orwell", genre: "Dystopian", publicationYear: 1949, availability: "available", borrower: nil, reservation: nil),
                Book(title: "To Kill a Mockingbird", image: UIImage(named: "image2")!, author: "Harper Lee", genre: "Fiction", publicationYear: 1960, availability: "available", borrower: nil, reservation: nil),
                Book(title: "The Great Gatsby", image: UIImage(named: "image3")!, author: "F. Scott Fitzgerald", genre: "Classic", publicationYear: 1925, availability: "available", borrower: nil, reservation: nil),
                Book(title: "Harry Potter and the Sorcerer's Stone", image: UIImage(named: "image4")!, author: "J.K. Rowling", genre: "Fantasy", publicationYear: 1997, availability: "available", borrower: nil, reservation: nil),
                Book(title: "Pride and Prejudice", image: UIImage(named: "image5")!, author: "Jane Austen", genre: "Romance", publicationYear: 1813, availability: "available", borrower: nil, reservation: nil),
                Book(title: "1984", image: UIImage(named: "image1")!, author: "George Orwell", genre: "Dystopian", publicationYear: 1949, availability: "available", borrower: nil, reservation: nil),
                Book(title: "To Kill a Mockingbird", image: UIImage(named: "image2")!, author: "Harper Lee", genre: "Fiction", publicationYear: 1960, availability: "available", borrower: nil, reservation: nil),
                Book(title: "The Great Gatsby", image: UIImage(named: "image3")!, author: "F. Scott Fitzgerald", genre: "Classic", publicationYear: 1925, availability: "available", borrower: nil, reservation: nil),
                Book(title: "Harry Potter and the Sorcerer's Stone", image: UIImage(named: "image4")!, author: "J.K. Rowling", genre: "Fantasy", publicationYear: 1997, availability: "available", borrower: nil, reservation: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineHorizontal3Button.layer.cornerRadius = 20
        collectiionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectiionView.delegate = self
        collectiionView.dataSource = self
    }
    
    @IBAction func MenuButtonAction(_ sender: Any) {
        let vc = MenuViewController(nibName: "MenuViewController", bundle: nil)
            vc.menuDelegate = self
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
    }
    
    func didAddBook(_ book: Book) {
        data.append(book)
        collectiionView.reloadData()
    }
}


// TODO: -  UICollectionViewDelegate  UICollectionViewDataSource  UICollectionViewDelegateFlowLayout

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You Tapped Me \(indexPath.row + 1)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookPreviewViewControllerID") as! BookPreviewViewController
        vc.bookModel = data[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        cell.configure(with: data[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.size.width - itemSpacing - 2*insetSize)/2, height: (view.bounds.size.width)/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: insetSize, bottom: 10, right: insetSize)
    }
    

}


