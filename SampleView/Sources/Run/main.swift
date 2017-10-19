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

// indexファイルを表示
drop.get("index") { request in
    return try drop.view.make("index.html")
}

//textファイルを表示
drop.get("txt") { request in
    return try drop.view.make("text.txt")
}

//leafテンプレートを表示
drop.get("leaf") { request in
    return try drop.view.make("hello", [
        "message": "Hello, world!"
        ])
}

drop.get("html") { request in
    return try drop.view.make("html")
}

try drop.run()

