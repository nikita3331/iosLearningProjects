//
//  User.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import Foundation
import SwiftyJSON

class User :ObservableObject{
    var authKey=""
    var baseUrl:String="https://madsprtest.herokuapp.com/"

    func register(completionBlock: @escaping (String) -> Void){
        let url = URL(string: "\(baseUrl)users/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["login": "nikita", "password": "ddada"]
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())

        URLSession.shared.dataTask(with: request) { data, response, error in
            let json = try! JSON(data: data!)
            print(json)
            if let dum = json["success"].string{
                completionBlock(dum);
            }
            else{
                completionBlock("")
            }
        }.resume()
    }
    private func handleRegister() {
       let group = DispatchGroup()
       group.enter()
        register(){
            (succ) in
            //print("register",succ)
            group.leave()
        }
        group.wait()
    }
    init(){
       //handleRegister()
    }
}

