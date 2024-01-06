//
//  ContentView.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @EnvironmentObject private var appState: AppState
    @State private var currentSubview = AnyView(DummyView())
    @State private var showingSubview = false
    
    var body: some View {
        NavigationSplitView{
            SideBar()
                .onChange(of: appState.currentRoute) { oldValue, newValue in
                    showingSubview = false
                }
        } detail: {
            StackBarNavigationView(currentSubview: $currentSubview, showingSubview: $showingSubview){
                if let currentRoute = appState.currentRoute {
                    switch currentRoute {
                    case .bookCatalog:
                        BookCatalogView(currentSubview: $currentSubview, showingSubview: $showingSubview)
                            .environmentObject(viewModel)

                    case .loanList:
                        LoanListView(currentSubview: $currentSubview, showingSubview: $showingSubview)
                            .environmentObject(viewModel)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
        .environmentObject(ViewModel())
}
