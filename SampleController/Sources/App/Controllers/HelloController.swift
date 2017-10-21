//
//  HelloController.swift
//  SampleControllerPackageDescription
//
//  Created by satoutakeshi on 2017/10/20.
//

import Foundation
import Vapor
import HTTP

final class HelloController {
    func sayHello(_ req: Request) throws -> ResponseRepresentable {
        guard let name = req.data["name"]?.string else {
            throw Abort(.badRequest)
        }
        
        return "Hello, \(name)"
    }
    
    func sayHelloAlternate(_ req: Request) -> ResponseRepresentable {
        do {
            let name: String = try req.parameters.next(String.self)
            return "Hello, \(name)"
        }
        catch {
            return Response(status: .badRequest)
        }
    }
}
