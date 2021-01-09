//
//  SetupDI.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/7/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import Foundation

final class SetupDI {
    static func initializer() {
        DI.shared.register(type: AuthServiceProtocol.self, component: AuthService())
    }
}
