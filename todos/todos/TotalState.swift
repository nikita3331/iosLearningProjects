//
//  User.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import Foundation
import SwiftyJSON

class TotalState :ObservableObject{
    var authKey="from user"
    private var baseUrl:String="https://madsprtest.herokuapp.com"
    @Published var api:API?=nil
    @Published var todos:Todos?=nil

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

    init(){
        fetchAuthKey{
            (auth) in
            DispatchQueue.main.async {
                self.api=API()
                self.todos=Todos(authKey: auth)
            }

        }
       //handleRegister()
    }
}
