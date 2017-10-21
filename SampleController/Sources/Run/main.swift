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


let hc = HelloController()
drop.get("hello", handler: hc.sayHello)
drop.get("helloAlt", String.parameter, handler: hc.sayHelloAlternate)


let users = UserController()
//ResourceRepresentableを適応しなければ、各エンドポイントそれぞれを登録する。
//drop.get("users", handler: users.index)
//drop.get("users", User.self, handler: users.show)

//ResourceRepresentableを適応すれば、resourceメソッドで一括で登録できる。
drop.resource("users", users)

try drop.run()
