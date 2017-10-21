//
//  User.swift
//  App
//
//  Created by satoutakeshi on 2017/10/21.
//

import Foundation
import Vapor
import FluentProvider
import HTTP
final class User :Model {
    var storage = Storage()
    var name: String
    
    init(row: Row) throws {
        name = try row.get("name")
    }
    
    init(name: String) {
        self.name = name
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", name)
        return row
    }
}
// How the model converts from / to JSON.
// For example when:
//     - Creating a new Post (POST /posts)
//     - Fetching a post (GET /posts, GET /posts/:id)
//
extension User: JSONRepresentable {
    convenience init(json: JSON) throws {
        self.init(
            name: try json.get("name")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("name", name)
        return json
    }
}

// MARK: HTTP

// This allows Post models to be returned
// directly in route closures
extension User: ResponseRepresentable { }

