//
//  LoanDetailView.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI

struct LoanDetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    var loanID: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            if let data = viewModel.loanDetail {
                Text(data.memberName.memberName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding([.horizontal, .top])
                
                Text("Return Date: \(data.returnDate)")
                    .padding(.horizontal)
            }
            
            List {
                if let data = viewModel.loanDetail {
                    ForEach(data.details, id: \.detailID) { item in
                        
                        HStack {
                            if let data = item.bookCover {
                                Image(nsImage: NSImage(data: data) ?? NSImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100) // Placeholder image size
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("\(item.bookTitle)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                if let actRetDate = item.actualReturnDate {
                                    Text("Returned")
                                        .foregroundColor(.blue)
                                } else {
                                    Text("Not Returned")
                                        .foregroundColor(.red)
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                viewModel.returnBook(loanID: loanID, bookID: item.bookID)
                                
                                viewModel.fetchLoanDetail(loanID: loanID)
                            } label: {
                                Text("Return")
                            }
                        }
                        
                    }
                } else {
                    Text("no data")
                }
                
            }
            .onAppear {
                viewModel.fetchLoanDetail(loanID: loanID)
            }
        }
        
        
    }
}

//#Preview {
//    LoanDetailView()
//}
