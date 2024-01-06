//
//  SideBar.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI

struct SideBar: View {
    @EnvironmentObject private var appState: AppState
    
    @State var clickStatus: Bool = true
    @State var clickStatus2: Bool = false
    
    var body: some View {
        List {
            HStack{
                Image(systemName: "books.vertical.fill")
                    .frame(width: 12)
                Text("Book Catalog")
            }
            .foregroundStyle(clickStatus ? .white : .primary)
            .listRowBackground(clickStatus ? Color.black.clipShape(RoundedRectangle(cornerRadius: 6)).padding(.horizontal, 10) : Color.clear.clipShape(RoundedRectangle(cornerRadius: 6)).padding(.horizontal))
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.3)) {
                    appState.routes.removeAll()
                    appState.push(.bookCatalog)
                    clickStatus = true
                    clickStatus2 = false
                }
            }
            
            HStack{
                Image(systemName: "doc.plaintext.fill")
                    .frame(width: 12)
                Text("Loan List")
            }
            .foregroundStyle(clickStatus2 ? .white : .primary)
            .listRowBackground(clickStatus2 ? Color.black.clipShape(RoundedRectangle(cornerRadius: 6)).padding(.horizontal, 10) : Color.clear.clipShape(RoundedRectangle(cornerRadius: 6)).padding(.horizontal))
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.3)) {
                    appState.routes.removeAll()
                    appState.push(.loanList)
                    clickStatus = false
                    clickStatus2 = true
                }
                
            }
            
        }
    }
}

#Preview {
    SideBar()
}
