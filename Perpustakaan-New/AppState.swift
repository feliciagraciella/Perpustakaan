//
//  AppState.swift
//  Perpustakaan-New
//
//  Created by Felicia Graciella on 06/01/24.
//

import Foundation

enum Route {
    case bookCatalog
    case loanList
}

class AppState: ObservableObject{
    @Published var routes: [Route] = [.bookCatalog]
    
    var currentRoute: Route? {
        routes.last
    }
    
    func push(_ route: Route) {
        routes.append(route)
    }
    
    @discardableResult
    func pop() -> Route? {
        routes.popLast()
    }
}
