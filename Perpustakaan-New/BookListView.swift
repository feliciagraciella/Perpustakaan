//
//  BookListView.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 07/01/24.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var viewModel: ViewModel
    
//    @State var shouldPresentSheet = false
    @State private var shouldPresentSheet: [Int: Bool] = [:]
    
    var body: some View {
        VStack {
            Text("Book List")
            
            Table(viewModel.books) {
                TableColumn("ID") { book in
                    Text("\(book.bookID)")
                }
                .width(20)
                
                TableColumn("Title", value: \.bookTitle)
                
                TableColumn("Writer", value: \.bookWriter)
                
                TableColumn("Overview", value: \.bookOverview)
                
                TableColumn("Status") { book in
                    if book.availableStatus == true {
                        Text("Available")
                    } else {
                        Text("Unavailable")
                    }
                }
                .width(70)
                
                TableColumn("Edit") { detail in
                    Button("Edit") {
                        shouldPresentSheet[detail.bookID] = true
                    }
                    .sheet(isPresented: Binding(
                        get: { shouldPresentSheet[detail.bookID] ?? false },
                        set: { shouldPresentSheet[detail.bookID] = $0 }
                    )) {
                        EditBookView(book: detail)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                .width(30)
                
                TableColumn("Delete") { detail in
                    Button("Delete") {
                    }
                    .foregroundColor(.red)
                    .buttonStyle(BorderlessButtonStyle())
                }
                .width(40)
            }
        }
    }
}

#Preview {
    BookListView()
        .environmentObject(AppState())
        .environmentObject(ViewModel())
}
