//
//  DI.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/7/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import Foundation

protocol DIProtocol {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) -> Component?
}

final class DI: DIProtocol {
    
    static let shared = DI()
    
    private init() {}
    
    var components: [String: Any] = [:]
    
    func register<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }
    
    func resolve<Component>(type: Component.Type) -> Component? {
        return components["\(type)"] as? Component
    }
}
