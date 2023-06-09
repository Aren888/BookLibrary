//
//  Books.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 09.06.23.
//

import Foundation
import UIKit

struct Book: Equatable {
    var title: String
    var image: UIImage
    var author: String
    var genre: String
    var publicationYear: Int
    var availability: AvailabilityStatus
    var borrower: Borrower?
    var reservation: Reservation?
    
    static func == (lhs: Book, rhs: Book) -> Bool { true }
}

struct Borrower {
    var name: String
    var surname: String
    var phoneNumber: String
}

enum AvailabilityStatus {
    case available
    case borrowed
    case reserved
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "available":
            self = .available
        case "borrowed":
            self = .borrowed
        case "reserved":
            self = .reserved
        default:
            return nil
        }
    }
    
    var availabilityStatusValue: String {
        switch self {
        case .available:
            return "Available"
        case .borrowed:
            return "Borrowed"
        case .reserved:
            return "Reserved"
        }
    }
}


struct Reservation {
    var reservationDate: Date
    var borrower: Borrower
}
