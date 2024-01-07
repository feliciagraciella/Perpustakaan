//
//  EditBookView.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 07/01/24.
//

import SwiftUI

struct EditBookView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    var book: BookModel

    
    @State var bookTitle = ""
    @State var bookWriter = ""
    @State var bookOverview = ""
    @State var bookCover: Data?
    
    @State private var isImporting = false
    @State var fileName = "no file chosen"
    @State var fileURL: [URL]?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title")
                    .frame(width: 70)
                
                TextField("Title", text: $bookTitle)
            }
            
            HStack {
                Text("Writer")
                    .frame(width: 70)
                
                TextField("Writer", text: $bookWriter)
            }
            
            HStack {
                Text("Overview")
                    .frame(width: 70)
                
                TextEditor(text: $bookOverview)
            }
            
            HStack {
                Text("Cover")
                    .frame(width: 70)
                
                if let bookCover {
                    Image(nsImage: NSImage(data: bookCover) ?? NSImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Button {
                        isImporting = true
                    } label: {
                        Text("Upload Image")
                    }
                    .fileImporter(isPresented: $isImporting, allowedContentTypes: [.image], allowsMultipleSelection: false, onCompletion: {
                        (Result) in
                        
                        do{
                            fileURL = try Result.get()
                            print(fileURL)
                            self.fileName = fileURL?.first?.lastPathComponent ?? "file not available"
                            
                            
                            if let fileURL, let imageData = try? Data(contentsOf: fileURL.first!) {
                                self.bookCover = imageData
                            }
                        }
                        catch{
                           print("error reading file \(error.localizedDescription)")
                        }
                        
                    })
                    .onChange(of: fileURL) {
                        if let fileURL, let imageData = try? Data(contentsOf: fileURL.first!) {
                            self.bookCover = imageData
                        }
                        
                    }
                    
                    Text(self.fileName)
                }
                
            }

            Spacer()
        }
        .padding()
        .toolbar(content: {
            Button("Cancel") {
                dismiss()
            }
            
            Button("Save") {
                if let bookCover {
                    viewModel.updateBook(bookID: book.bookID, bookTitle: bookTitle, bookWriter: bookWriter, bookOverview: bookOverview, bookCover: bookCover)
                } else {
                    viewModel.updateBook(bookID: book.bookID, bookTitle: bookTitle, bookWriter: bookWriter, bookOverview: bookOverview, bookCover: nil)
                }
                
                
                dismiss()
            }
        })
        .frame(width: 400, height: 400)
        .onAppear {
            bookTitle = book.bookTitle
            bookWriter = book.bookWriter
            bookOverview = book.bookOverview
            bookCover = book.bookCover
        }
    }
}

//#Preview {
//    EditBookView(bookID: 1)
//}
