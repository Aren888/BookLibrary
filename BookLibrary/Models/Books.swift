//
//  Books.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 09.06.23.
//

import Foundation
import UIKit

struct Book {
    var title: String
    var image: UIImage
    var author: String
    var genre: String
    var publicationYear: Int
    var availability: String
    var borrower: Borrower?
    var reservation: Reservation?
}

struct Borrower {
    var name: String
    var surname: String
    var phoneNumber: String
}

struct Reservation {
    var reservationDate: Date
    var borrower: Borrower
}
