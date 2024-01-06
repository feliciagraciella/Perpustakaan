//
//  BookCatalogView.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI

struct BookCatalogView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @EnvironmentObject private var appState: AppState
    @Binding var currentSubview: AnyView
    @Binding var showingSubview: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Book Catalog")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            }
            
            
            List {
                if viewModel.books.isEmpty {
                    Text("no data")
                } else {
                    ForEach(viewModel.books, id: \.bookID) { book in
                        HStack {
                            VStack {
                                if let data = book.bookCover {
                                    Image(nsImage: NSImage(data: book.bookCover ?? Data()) ?? NSImage())
                                        .resizable()
                                        .scaledToFit()
                                    
                                }
                                else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                }
                                
                                Spacer()
                            }
                            .frame(width: 120)
                            
                            VStack(alignment: .leading) {
                                if book.availableStatus == true {
                                    Text("Available")
                                        .foregroundColor(.blue)
                                } else {
                                    Text("Unavailable")
                                        .foregroundColor(.red)
                                }
                                
                                Text("\(book.bookTitle)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text("by \(book.bookWriter)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("Overview: \n\(book.bookOverview)")
                                
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
}

//#Preview {
//    BookCatalogView()
//}
