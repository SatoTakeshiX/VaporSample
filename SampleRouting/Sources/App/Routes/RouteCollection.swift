//
//  RouteCollection\.swift
//  SampleRoutingPackageDescription
//
//  Created by satoutakeshi on 2017/10/09.
//

import Foundation
import Vapor
import HTTP
import Routing

public class V3Collection: RouteCollection, EmptyInitializable {
    public required init() {}
    public func build(_ builder: RouteBuilder) {
        let v3 = builder.grouped("v3")
        let users = v3.grouped("users")
        let articles = v3.grouped("articles")
        users.get { request in
            return "Requested all users."
        }
        articles.get(String.parameter){ request in
            let articleName = try request.parameters.next(String.self)
            return "Requested \(articleName)"
        }
    }
}
