//
//  User.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import Foundation
import SwiftyJSON

class User :ObservableObject{
    var authKey="from user"
    var baseUrl:String="https://madsprtest.herokuapp.com/"

    private func register(login:String,password:String,completionBlock: @escaping (Bool) -> Void){
        let url = URL(string: "\(baseUrl)users/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["login": login, "password": password]
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())

        URLSession.shared.dataTask(with: request) { data, response, error in
            let json = try! JSON(data: data!)
            if let dum = json["success"].bool{
                completionBlock(dum);
            }
            else{
                completionBlock(false)
            }
        }.resume()
    }
    public func handleRegister(login:String,password:String)->Bool {
       let group = DispatchGroup()
       group.enter()
        var response=true
        register(login:login,password:password){
            (succ) in
            response=succ
            group.leave()
        }
        group.wait()
        return response
    }
    
    private func loginUser(login:String,password:String,completionBlock: @escaping (String) -> Void){
        var baseUrl:String="https://madsprtest.herokuapp.com"

        let url = URL(string: "\(baseUrl)/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["login": login, "password": password]
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
    public func handleLogin(login:String,password:String)->String {
       let group = DispatchGroup()
       group.enter()
        var response=""
        loginUser(login:login,password:password){
            (authKey) in
            response=authKey
            if !response.isEmpty{
                UserDefaults.standard.set(response, forKey: "AuthKey")
            }
            group.leave()
        }
        group.wait()
        return response
    }
    public func fetchAuthKey()->String{
        var baseUrl:String="https://madsprtest.herokuapp.com"
        var savedAuth = UserDefaults.standard.string(forKey: "AuthKey")
        if let unwrapped = savedAuth{
            return unwrapped
        }
        else{
            return ""
        }
    }
    init(){

    }
}

