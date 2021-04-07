//
//  Todos.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import Foundation
import SwiftyJSON

struct Todo{
    var title:String
    var id:Int
    var picked:Bool
    var description:String
    var category:String
}
struct LoginResponse:Decodable{
    var reason:Int
    var success:Int
    var authKey:String?
}
class Todos :ObservableObject{
    @Published var todos:[Todo]=[]
    var authKey:String = ""
    var baseUrl:String="https://madsprtest.herokuapp.com/"
    @Published var isLoading:Bool=false
    private func findIndex(id:Int)->Int{
        let index = self.todos.firstIndex(where: { (item) -> Bool in
          item.id == id // test if this is the item you're looking for
        })
        if let newIndex = index{
            return newIndex
        }
        else{
            return 0
        }
    }
    public func setPickedTodo(id:Int){
        let index=findIndex(id: id)
        todos[index].picked = !todos[index].picked
    }
    public func removeTodo(id:Int){
        let index=findIndex(id: id)
        todos.remove(at: index)
    }
    public func addTodo(title:String,desc:String,cat:String){
//        let newTodo=Todo(title: title, id: todos.count, picked: false,description:desc,category: cat)
//        todos.append(newTodo)
        
        self.isLoading=true
       let group = DispatchGroup()
        group.enter()
        addTodoAPI(title: title, desc: desc){
            (suc) in
            print("is suc",suc)
            group.leave()
        }
        group.wait()
        fetchTodos()
        self.isLoading=false
    }
    func addTodoAPI(title:String,desc:String,completionBlock: @escaping (String) -> Void){
        let url = URL(string: "\(baseUrl)todos/addTodo")!
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
    func fetchAuthKey(completionBlock: @escaping (String) -> Void){
        let url = URL(string: "\(baseUrl)users/login")!
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
    func fetchMyTodos(completionBlock: @escaping (JSON) -> Void){
        let url = URL(string: "\(baseUrl)todos/getTodos")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["authKey": self.authKey]
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
    private func parseTodos(jsonTodos:JSON){
        var dummy:[Todo]=[]

        for (index,todo) in jsonTodos.arrayValue.enumerated() {
            let tit = todo["title"].string!
            let desc = todo["description"].string!
            let category = todo["category"].string!
            let newTodo=Todo(title: tit, id: index, picked: false, description: desc,category: category)
            dummy.append(newTodo)
        }
        DispatchQueue.main.async {
            self.todos=dummy
        }
    }
    private func fetchTodos() {
        DispatchQueue.main.async {
            self.isLoading=true
        }
       let group = DispatchGroup()
        group.enter()
        fetchMyTodos(){
            (todoss) in
            self.parseTodos(jsonTodos: todoss)
            group.leave()
        }
        group.wait()
        DispatchQueue.main.async {
            self.isLoading=false
        }


       //anything after this point won't execute until we get a result from someAsyncFunction()
    }
    init(){
        let group = DispatchGroup()
        group.enter()
         fetchAuthKey(){
             (authKey) in
             if (!authKey.isEmpty){
                 self.authKey=authKey
             }
             group.leave()
         }
         group.wait()
        fetchTodos()
    }
}
