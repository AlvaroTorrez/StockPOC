//
//  AuthServiceProtocol.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/7/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//
import Foundation

enum AuthStatus: String {
    case SUCCESS
    case FAIL
}

protocol AuthServiceProtocol {
    var isAuthUser: Bool { get }
    
    func authUser(username: String, password: String, completion: @escaping (AuthStatus) -> Void)
}
