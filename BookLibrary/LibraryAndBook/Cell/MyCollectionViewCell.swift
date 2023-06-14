//
//  MyCollectionViewCell.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 09.06.23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    func configure(with book: Book) {
        imageView.image = book.image
        self.label.text = book.title
        label.layer.cornerRadius = 20
    }
}
