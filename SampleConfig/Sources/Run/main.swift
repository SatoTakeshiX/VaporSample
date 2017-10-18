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

//Config/server.jsonのcustom-keyを呼び出す
let customeValue = drop.config["server", "custom-key"]?.string ?? "default"
print(customeValue)

//Config/app.jsonのtest-nameを呼び出す
let firstTestName = drop.config["app", "test-names", 0]?.string ?? "default"
print(firstTestName)

//Config/app.jsonのmongoを呼び出す
let monogoURL = drop.config["app", "mongo", "url"]?.string ?? "default"
print(monogoURL)

//JSONのオブジェクトを取得するには.objectを使用する
let monogo = drop.config["app", "mongo"]?.object ?? ["key": "default"]
print(monogo)

//各環境で異なる値を取得できる
let host = drop.config["server", "host"]?.string ?? "0.0.0.0"
print("host:\(host)")
let port = drop.config["server", "port"]?.int ?? 9000
print("port:\(port)")

//CLIからConfigを読み込む
let analyticsKey = drop.config["keys", "analytics"]?.string ?? "default"
print(analyticsKey)


try drop.run()
