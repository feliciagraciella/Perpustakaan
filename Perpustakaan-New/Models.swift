//
//  Models.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI
import Foundation

//MARK: - Loan List
struct LoanDataModel: Decodable {
    let data: [LoanModel]
}

struct LoanModel: Decodable {
    let loanID: Int
    let memberName: String
    let loanDate: String
    let returnStatus: Bool
    let returnDate: String
    let bookCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case loanID
        case memberName
        case loanDate
        case bookCount
        case returnDate
        case returnStatus = "returnStatus"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        loanID = try container.decode(Int.self, forKey: .loanID)
        memberName = try container.decode(String.self, forKey: .memberName)
        loanDate = try container.decode(String.self, forKey: .loanDate)
        returnDate = try container.decode(String.self, forKey: .returnDate)
        bookCount = try container.decode(Int.self, forKey: .bookCount)

        let returnStatusValue = try container.decode(Int.self, forKey: .returnStatus)
        returnStatus = returnStatusValue == 1
    }
}

//MARK: - Loan Detail
struct LoanDetailDataModel: Codable {
    let data: LoanDetailModel
}

struct LoanDetailModel: Codable {
    let loanID: Int
    let memberName: MemberModel
    let details: [Detail]
    let returnDate: String
    let returnStatus: Bool

    enum CodingKeys: String, CodingKey {
        case loanID, memberName, details, returnDate
        case returnStatus = "returnStatus"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        loanID = try container.decode(Int.self, forKey: .loanID)
        memberName = try container.decode(MemberModel.self, forKey: .memberName)
        details = try container.decode([Detail].self, forKey: .details)
        returnDate = try container.decode(String.self, forKey: .returnDate)

        let returnStatusValue = try container.decode(Int.self, forKey: .returnStatus)
        returnStatus = returnStatusValue == 1
    }
}

struct MemberDataModel: Decodable {
    let data: [MemberModel]
}


struct MemberModel: Codable, Hashable, Identifiable {
    let memberID: Int
    let memberName: String
    let loans: Int
    
    var id: Self { self }
    
    private enum CodingKeys: String, CodingKey {
        case memberID
        case memberName
        case loans
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        memberID = try container.decode(Int.self, forKey: .memberID)
        memberName = try container.decode(String.self, forKey: .memberName)
        loans = try container.decode(Int.self, forKey: .loans)
    }
}

struct Detail: Codable {
    let detailID, loanID, bookID: Int
    let bookTitle: String
    let bookCover: Data?
    let actualReturnDate: String?

    enum CodingKeys: String, CodingKey {
        case detailID, bookID, loanID, bookTitle, bookCover, actualReturnDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        detailID = try container.decode(Int.self, forKey: .detailID)
        loanID = try container.decode(Int.self, forKey: .loanID)
        bookID = try container.decode(Int.self, forKey: .bookID)
        bookTitle = try container.decode(String.self, forKey: .bookTitle)
        bookCover = try container.decodeIfPresent(Data.self, forKey: .bookCover)
        actualReturnDate = try container.decodeIfPresent(String.self, forKey: .actualReturnDate)
    }
}

//MARK: - Book Catalog
struct BookDataModel: Decodable {
    let data: [BookModel]
}

struct BookModel: Decodable, Hashable, Identifiable {
    let bookID: Int
    let bookTitle: String
    let bookCover: Data?
    let bookWriter: String
    let bookOverview: String
    let availableStatus: Bool
    
    var id: Self { self }

    private enum CodingKeys: String, CodingKey {
        case bookID
        case bookTitle
        case bookCover
        case bookWriter
        case bookOverview
        case availableStatus
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bookID = try container.decode(Int.self, forKey: .bookID)
        bookTitle = try container.decode(String.self, forKey: .bookTitle)
        bookWriter = try container.decode(String.self, forKey: .bookWriter)
        bookOverview = try container.decode(String.self, forKey: .bookOverview)

        bookCover = try container.decodeIfPresent(Data.self, forKey: .bookCover)

        let availableStatusValue = try container.decode(Int.self, forKey: .availableStatus)
        availableStatus = availableStatusValue == 1
    }
}

struct ResponseModel: Decodable {
    let message: String
}
