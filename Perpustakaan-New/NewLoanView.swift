//
//  NewLoanView.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI

struct NewLoanDetail: Identifiable {
    let bookID: Int
    let bookTitle: String
    let id = UUID()
}

enum MemberStatus: String, CaseIterable {
    case old = "Old"
    case new = "New"
}

struct NewLoanView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var memberStatus: MemberStatus = .old
    @State var memberName = ""
    @State var selectedMember: MemberModel?
    
    var availableBooks: [BookModel] {
        return viewModel.books.filter { $0.availableStatus }
        }
    
    @State var selectedBook: BookModel?
    @State var details: [NewLoanDetail] = []
    
    @State var showingAlert = false
    @State var showingAlert2 = false
    
    @State var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Loan")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Picker("Member Status", selection: $memberStatus) {
                ForEach(MemberStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            
            .pickerStyle(.radioGroup)
            .horizontalRadioGroupLayout()
            
            if memberStatus == .old {
                HStack {
                    Picker("Member Name", selection: $selectedMember) {
                        ForEach(viewModel.members, id: \.memberID) { member in
                            Text("\(member.memberID) - \(member.memberName)").tag(member as MemberModel?)
                        }
                    }
                    
                    if let selectedMember {
                        if selectedMember.loans > 0 {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
            } else {
                HStack {
                    Text("Member Name")
                    
                    TextField("Name", text:$memberName)
                }
            }
            
            HStack {
                Picker("Book", selection: $selectedBook) {
                    ForEach(availableBooks, id: \.bookID) { item in
                        Text(item.bookTitle).tag(item as BookModel?)
                    }
                        
                }
                
                Button {
                    if details.count < 2 {
                        if details.contains(where: { $0.bookID == selectedBook?.bookID }) {
                            alertMessage = "Book already added"
                            showingAlert.toggle()
                        } else {
                            let newDetail = NewLoanDetail(bookID: selectedBook?.bookID ?? 0, bookTitle: selectedBook?.bookTitle ?? "")
                            details.append(newDetail)
                        }
                        
//                        let newDetail = NewLoanDetail(bookID: selectedBook?.bookID ?? 0, bookTitle: selectedBook?.bookTitle ?? "")
//                        
//                        
//                        details.append(newDetail)
                    } else {
                        alertMessage = "Max 2 Books"
                        showingAlert.toggle()
                    }
                } label: {
                    Text("Add")
                }
                .alert(alertMessage, isPresented: $showingAlert) {
//                   Button("OK", role: .cancel) { }
                }
                .disabled(selectedMember?.loans ?? 1 > 0 || (memberName == "" && memberStatus == .new))
            }
            
            Table(details) {
                TableColumn("Book ID") { detail in
                        Text("\(detail.bookID)")
                    }
                TableColumn("Book Title", value: \.bookTitle)
                
                TableColumn("Cancel") { detail in
                    Button("Delete") {
                        if let index = details.firstIndex(where: { $0.id == detail.id }) {
                            details.remove(at: index)
                        }
                    }
                    .foregroundColor(.red)
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
            HStack {
                Spacer()
                
                Button {
                    let bookIDs = details.map { $0.bookID }
                    
                    if memberStatus == .old {

                        let memberID = selectedMember?.memberID

                        if let memberID {
                            viewModel.newLoan(bookIDs: bookIDs, memberID: memberID)
                        }
                        
                        details = []
                        viewModel.fetchLoans()
                        viewModel.fetchBooks()
                        selectedMember = viewModel.members.first(where: {$0.loans < 1})
                        
                        showingAlert2.toggle()
                    } else {
                        viewModel.newMember(memberName: memberName) 
                        
                        if let newMemberID = viewModel.members.last?.memberID {
                            viewModel.newLoan(bookIDs: bookIDs, memberID: newMemberID)
                            viewModel.fetchLoans()
                            viewModel.fetchBooks()
                            details = []
                            memberName = ""
                            selectedBook = availableBooks.first
                            showingAlert2.toggle()
                        }
                    }
                } label: {
                    Text("Create Loan")
                }
                .alert("New loan added", isPresented: $showingAlert2) {
                   /*Button("OK", role: .cancel)*/ /*{ }*/
                }
                .disabled(details.count < 1 || (memberName == "" && memberStatus == .new))
            }
        }
        .onAppear {
            selectedMember = viewModel.members.first(where: {$0.loans < 1})
            selectedBook = availableBooks.first
        }
        .padding()
    }
}

#Preview {
    NewLoanView()
}
