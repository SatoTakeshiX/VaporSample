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

//Qiita APIの仕様
// https://qiita.com/api/v2/docs


//qiitaのAPIを実行

//GET /api でリクエスト
drop.get("api"){ req in
    //client でQiita APIにアクセスする
    let response = try drop.client.get("https://qiita.com/api/v2/tags?page=1&per_page=20&sort=count")
    return response
}

//GET /api_query でリクエスト
drop.get("api_query"){ req in
    
    //クエリーを引数で明示的に指定する
    let response = try drop.client.get("https://qiita.com/api/v2/tags", query: [
        "page" : 1,
        "per_page" : 20,
        "sort" : "count"
        ])
    
    return response
}



try drop.run()
