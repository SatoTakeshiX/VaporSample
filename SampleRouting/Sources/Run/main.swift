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

//postメソッドを実行
drop.post("welcome"){ req in
    return "Hello"
}

//ネスト
drop.get("welcome/to/vapor"){ req in
    return "Hello"
}

//引数で指定
drop.get("welcome", "to", "vapor"){ req in
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

//その他のエンドポイントの指定
drop.add(.trace, "welcome") { request in
    return "Hello"
}

//フォールバック
drop.get("anything", "*") { request in
    return "/anythingの後ろのどんなものでもマッチする"
}

drop.add(.trace, "welcom", value: {req in
    
    return ""
})

//リダイレクト
drop.get("vapor") { request in
    return Response(redirect: "http://vapor.codes")
}

//jsonを返す。
drop.get("json") { request in
    var json = JSON()
    try json.set("number", 123)
    try json.set("text", "unicorns")
    try json.set("bool", false)
    return json
}

//404
drop.get("404") { request in
    throw Abort(.notFound)
}

//error
drop.get("error") { request in
    throw Abort(.badRequest, reason: "Sorry 😱")
}

//group
drop.group("v1") { v1 in
    
    //GET /v1/users
    v1.get("users") { req in
        return "users"
    }
    //GET /v1/users/:id
    v1.get("users", Int.parameter) { req in
        let userId = try req.parameters.next(Int.self)
        return "You requested User #\(userId)"
    }
}

//grouped
let v2 = drop.grouped("v2")
v2.get("users"){ req in
    return "users"
}
v2.get("users", Int.parameter) { req in
    let userId = try req.parameters.next(Int.self)
    return "You requested User #\(userId)"
}

//Collection
//let v3 = V3Collection()
//try drop.collection(v3)

//EmptyInitializableを適応させると型指定でルーティングを設定出来る
try drop.collection(V3Collection.self)

try drop.run()
