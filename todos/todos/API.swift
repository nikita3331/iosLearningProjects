//
//  API.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 08/04/2021.
//

import Foundation
import SwiftyJSON

class API:ObservableObject{
    private var baseUrl:String="https://madsprtest.herokuapp.com"
    var authKey:String=""
    public func addTodo(title:String,desc:String,completionBlock: @escaping (String) -> Void){
        let url = URL(string: "\(baseUrl)/todos/addTodo")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["title": title, "description": desc, "category": "water", "authKey":self.authKey]
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        URLSession.shared.dataTask(with: request) { data, response, error in
            let json = try! JSON(data: data!)
            if(json["success"] == true){
                completionBlock("suc");
            }
            else{
                completionBlock("suc");
            }
        }.resume()
    }
    public func setAuthKey(auth:String){
        self.authKey=auth
    }
    public func removeTodo(id:String,completionBlock: @escaping (String) -> Void){
        let url = URL(string: "\(baseUrl)/todos/removeTodo")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["todoId": id, "authKey":self.authKey]
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        URLSession.shared.dataTask(with: request) { data, response, error in
            let json = try! JSON(data: data!)
            if(json["success"] == true){
                completionBlock("suc");
            }
            else{
                completionBlock("suc");
            }
        }.resume()
    }
    func fetchAuthKey(completionBlock: @escaping (String) -> Void){
        let url = URL(string: "\(baseUrl)/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["login": "nikita", "password": "ddada"]
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        URLSession.shared.dataTask(with: request) { data, response, error in
            let json = try! JSON(data: data!)
            if(json["success"] == true){
                completionBlock(json["authKey"].string!);
            }
            else{
                completionBlock("");
            }
        }.resume()
    }
    func fetchTodos(authKey:String,completionBlock: @escaping (JSON) -> Void){
        let url = URL(string: "\(baseUrl)/todos/getTodos")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["authKey": authKey]
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        URLSession.shared.dataTask(with: request) { data, response, error in
            let json = try! JSON(data: data!)
            if(json["success"] == true){
                completionBlock(json["todos"]);
            }
            else{
                completionBlock([]);
            }
        }.resume()
    }
    init(){
        
    }
}
