import App

/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands, 
/// if no command is given, it will default to "serve"
let config = try Config()
try config.setup()

let drop = try Droplet(config)
try drop.setup()

drop.get("welcome"){ req in
    return "Hello"
}
drop.get("welcome", "to", "vapor"){ req in
    return "Hello"
}

drop.get("anything", "*") { request in
    return "/anythingの後ろのどんなものでもマッチする"
}

drop.add(.trace, "welcom", value: {req in
    
    return ""
})

drop.post("welcome"){ req in
    return "Hello"
}


//Type Parameter
drop.get("users", Int.parameter) { req in
    let userId = try req.parameters.next(Int.self)
    return "You requested User #\(userId)"
}


//// 下記と同じ
//drop.get("users", ":id") { req in
//    guard let userId = req.parameters["id"]?.int else {
//        throw Abort.badRequest
//    }
//
//    return "You requested User #\(userId)"
// }


try drop.run()
