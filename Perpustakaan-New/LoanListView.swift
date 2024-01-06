//
//  LoanListView.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI

struct LoanListView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @EnvironmentObject private var appState: AppState
    @Binding var currentSubview: AnyView
    @Binding var showingSubview: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Loan List")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    //                    .padding()
                    
                    Spacer()
                    
                    Button {
                        currentSubview = AnyView(NewLoanView())
                        showingSubview = true
                    } label: {
                        Text("New Loan")
                    }
                }
                .padding()
                
                
                List {
                    if viewModel.loans.isEmpty {
                        Text("no data")
                    } else {
                        ForEach(viewModel.loans.reversed(), id: \.loanID) { loan in
                            NavigationLink(
                                destination: LoanDetailView(loanID: loan.loanID),
                                label: {
                                    HStack {
                                        Text("\(loan.loanID)")
                                            .frame(width: 20)
                                        
                                        Text("\(loan.loanDate)")
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Text("\(loan.memberName)")
                                                .font(.title2)
                                            
                                            Text("\(loan.bookCount) books borrowed")
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing) {
                                            Text("Must return before \(loan.returnDate)")
                                            
                                            if loan.returnStatus == true {
                                                Text("Returned")
                                                    .foregroundColor(.blue)
                                            } else {
                                                Text("Not Returned")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        
                                    }
                                    .padding(4)
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    LoanListView()
//}
