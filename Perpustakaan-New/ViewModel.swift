//
//  ViewModel.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI
import Foundation

class ViewModel: ObservableObject {
    @Published var loans = [LoanModel]()
    
    @Published var books = [BookModel]()
//    @Published var members: TransactionDetail?
    @Published var loanDetail: LoanDetailModel?
    
    let prefix = "http://127.0.0.1:8000/api"
    
    init() {
        fetchBooks()
        fetchLoans()
//        fetchMembers()
        
    }
    
    func fetchBooks() {
        guard let url = URL(string: "\(prefix)/books") else {
            print("URL not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print("error", error)
                return
            }
            
            do {
                if let data = data {
                    print(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")
                    
                    let result = try JSONDecoder().decode(BookDataModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.books = result.data
                    }
                } else {
                    print("no data")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError)
            }
        }.resume()
    }
    
    func fetchLoanDetail(loanID: Int) {
        guard let url = URL(string: "\(prefix)/loans/\(loanID)") else {
            print("URL not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    print(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")
                    
                    let result = try JSONDecoder().decode(LoanDetailDataModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.loanDetail = result.data
                    }
                } else {
                    print("no data")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError)
            }
        }.resume()
    }

    func fetchLoans() {
        guard let url = URL(string: "\(prefix)/loans") else {
            print("URL not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
//                    print(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")
                    
                    let result = try JSONDecoder().decode(LoanDataModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.loans = result.data
                    }
                } else {
                    print("no data")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError)
            }
        }.resume()
    }
    
    func returnBook(loanID: Int, bookID: Int) {
        guard let url = URL(string: "\(prefix)/return/\(loanID)/\(bookID)") else {
            print("URL not found")
            return
        }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }

                    do {
                        let result = try JSONDecoder().decode(ResponseModel.self, from: data)
                        DispatchQueue.main.async {
                            print(result.message)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else {
                    print("No data received")
                }
            }.resume()
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }

    struct ResponseModel: Decodable {
        let message: String
    }
    
}

