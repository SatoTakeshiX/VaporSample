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

//http://0.0.0.0:8080/uri?query=hello
drop.get("uri") { req in
    
    let scheme = req.uri.scheme // http
    let host = req.uri.hostname // 0.0.0.0
    let port = req.uri.port //8080
    let path = req.uri.path // /uri
    let query = req.uri.query // query=hello

    //URIを表示
    return """
    \(scheme)
    \(host)
    \(port ?? 0)
    \(path)
    \(query ?? "")
    """
}

//user/:name/:age
drop.get("user", ":name", ":age") { req in
    
    let name = req.parameters["name"]?.string ?? ""
    let age = req.parameters["age"]?.int ?? 0
    
    return "\(name)は\(age)歳"
}

// /user?name=xxxx
drop.get("user") {req in
    
    let name = req.data["name"]?.string ?? ""
    return "あなたは\(name)です"
}

// /article?number?=xxx&title=xxx
drop.get("article") { req in
    let page = req.query?["page"]?.int ?? 0
    let title = req.query?["title"]?.string ?? ""
    return "今は\(page)ページ目です。タイトルは\(title)"
}



try drop.run()
