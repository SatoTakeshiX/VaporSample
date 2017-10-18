import Vapor

extension Droplet {
    func setupRoutes() throws {

        //Group
        group("v1") { v1 in
            v1.get("users") { req in
                return "users"
            }
            v1.get("users", Int.parameter) { req in
                let userId = try req.parameters.next(Int.self)
                return "You requested User #\(userId)"
            }
        }
        
        let v2 = grouped("v2")
        v2.get("users"){ req in
            
            return "users"
        }
        v2.get("users", Int.parameter) { req in
            let userId = try req.parameters.next(Int.self)
            return "You requested User #\(userId)"
        }
    }
}


