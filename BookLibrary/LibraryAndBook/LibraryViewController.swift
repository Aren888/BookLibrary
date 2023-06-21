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
    let searchController = UISearchController()
    let segmentedControl = UISegmentedControl(items: ["All", "Available", "Borrowed", "Reserved"])
    
    
    let itemSpacing: CGFloat = 8
    let insetSize: CGFloat = 10
    var filteredData: [Book] = []
    var isSearching: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    var data = [Book(title: "1984", image: UIImage(named: "image1")!, author: "George Orwell", genre: "Dystopian", publicationYear: 1949, availability: .available, borrower: nil, reservation: nil),
                Book(title: "To Kill a Mockingbird", image: UIImage(named: "image2")!, author: "Harper Lee", genre: "Fiction", publicationYear: 1960, availability: .available, borrower: nil, reservation: nil),
                Book(title: "The Great Gatsby", image: UIImage(named: "image3")!, author: "F. Scott Fitzgerald", genre: "Classic", publicationYear: 1925, availability: .available, borrower: nil, reservation: nil),
                Book(title: "Harry Potter and the Sorcerer's Stone", image: UIImage(named: "image4")!, author: "J.K. Rowling", genre: "Fantasy", publicationYear: 1997, availability: .available, borrower: nil, reservation: nil),
                Book(title: "Pride and Prejudice", image: UIImage(named: "image5")!, author: "Jane Austen", genre: "Romance", publicationYear: 1813, availability: .borrowed, borrower: nil, reservation: nil),
                Book(title: "The Catcher in the Rye", image: UIImage(named: "image6")!, author: "J.D. Salinger", genre: "Coming-of-Age", publicationYear: 1951, availability: .borrowed, borrower: nil, reservation: nil),
                Book(title: "To the Lighthouse", image: UIImage(named: "image7")!, author: "Virginia Woolf", genre: "Modernist", publicationYear: 1927, availability: .borrowed, borrower: nil, reservation: nil),
                Book(title: "Moby-Dick", image: UIImage(named: "image8")!, author: "Herman Melville", genre: "Adventure", publicationYear: 1851, availability: .reserved, borrower: nil, reservation: nil),
                Book(title: "The Lord of the Rings", image: UIImage(named: "image9")!, author: "J.R.R. Tolkien", genre: "Fantasy", publicationYear: 1954, availability: .reserved, borrower: nil, reservation: nil),
                Book(title: "Crime and Punishment", image: UIImage(named: "image10")!, author: "Fyodor Dostoevsky", genre: "Psychological Fiction", publicationYear: 1866, availability: .reserved, borrower: nil, reservation: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data
        lineHorizontal3Button.layer.cornerRadius = 20
        collectiionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectiionView.delegate = self
        collectiionView.dataSource = self
        searchControllerSetUp()
        setupSegmentedControl()
    }
    
    func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Handle segmented control value change here
        filterBooksByAvailability()
    }
    
    func filterBooksByAvailability() {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0: // All
            filteredData = data
        case 1: // Available
            filteredData = data.filter { $0.availability == .available }
        case 2: // Borrowed
            filteredData = data.filter { $0.availability == .borrowed }
        case 3: // Reserved
            filteredData = data.filter { $0.availability == .reserved }
        default:
            filteredData = data
        }
        
        collectiionView.reloadData()
    }
    
    @IBAction func MenuButtonAction(_ sender: Any) {
        let vc = MenuViewController(nibName: "MenuViewController", bundle: nil)
        vc.menuDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        navigationController?.navigationBar.isHidden.toggle()
    }
    
    func searchControllerSetUp() {
        title = "Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func didAddBook(_ book: Book) {
        data.append(book)
        collectiionView.reloadData()
    }
    
    func didRemoveBook(title: String) {
        for index in 0..<data.count {
            if data[index].title == title {
                data.remove(at: index)
                break
            }
        }
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
        
        vc.bookModel = filteredData[indexPath.item]
        
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.isHidden.toggle()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        let book: Book
        book = filteredData[indexPath.item]
        
        cell.configure(with: book)
        
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

extension LibraryViewController: UISearchResultsUpdating, UISearchControllerDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterResults(for: searchText)
        }
    }

    private func filterResults(for searchText: String) {
        filteredData = []
        var searchArray: [Book] = []
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0: // All
            searchArray = data
        case 1: // Available
            searchArray = data.filter { $0.availability == .available }
        case 2: // Borrowed
            searchArray = data.filter { $0.availability == .borrowed }
        case 3: // Reserved
            searchArray = data.filter { $0.availability == .reserved }
        default:
            searchArray = data
        }

        for dataItem in searchArray {

            if dataItem.title.lowercased().contains(searchText.lowercased()) ||
                dataItem.author.lowercased().contains(searchText.lowercased()) {
                filteredData.append(dataItem)
            }
        }
        collectiionView.reloadData()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0: // All
            filteredData = data
        case 1: // Available
            filteredData = data.filter { $0.availability == .available }
        case 2: // Borrowed
            filteredData = data.filter { $0.availability == .borrowed }
        case 3: // Reserved
            filteredData = data.filter { $0.availability == .reserved }
        default:
            filteredData = data
        }
        collectiionView.reloadData()
    }
}
