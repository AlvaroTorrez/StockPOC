//
//  AuthService.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/7/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import Foundation

class AuthService: AuthServiceProtocol {
   
    var isAuthUser: Bool {
        return false
    }
    
    func authUser(username: String, password: String, completion: @escaping (AuthStatus) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if (username == "Test" && password == "123") {
                completion(.SUCCESS)
            } else {
                completion(.FAIL)
            }
        }
    }
}
