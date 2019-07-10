//
//  CoachingSummary.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// CoachingSummary
struct CoachingSummary: Codable {
    
    // MARK: Public enums
    
    enum CodingKeys: String, CodingKey {
        case activeTodo                     = "activeTodo"
        case activeChat                     = "activeChat"
        case numberOfTodoItems              = "numberOfTodoItems"
        case numberOfCompletedTodoItems     = "numberOfCompletedTodoItems"
        case selected                       = "selected"
    }
    
    // MARK: Public variables
    
    var activeTodo: Bool?
    var activeChat: Bool?
    var numberOfTodoItems: Int?
    var numberOfCompletedTodoItems: Int?
    var selected: Bool?
}
