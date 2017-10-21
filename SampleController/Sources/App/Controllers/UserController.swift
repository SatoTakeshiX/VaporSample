//
//  UserController.swift
//  App
//
//  Created by satoutakeshi on 2017/10/21.
//

import Foundation
import Vapor
import HTTP

final class UserController :ResourceRepresentable{
    func makeResource() -> Resource<User> {
        return Resource(
            index: index,
            show: show
        )
    }
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try User.all().makeJSON()
    }
    
    func show(_ req: Request, _: User) throws -> ResponseRepresentable {
        let user = try req.parameters.next(User.self)
        return user
    }
    
}
