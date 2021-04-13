//
//  LoginScreen.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 11/04/2021.
//

import SwiftUI
import Neumorphic

struct LoginScreen: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var todos: Todos

    @State private var login:String=""
    @State private var password:String=""
    @Binding var selection:String?
    func handleLogin(){
        var returned=user.handleLogin(login: login, password:password)
        if !returned.isEmpty{
            todos.setAuthKey(key: returned)
            todos.fetchInitialTodos()
            
        }
    }
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            VStack{
                HStack(alignment: .center){
                    Text("")
                    Spacer()
                    Text("Please log in")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        
                    
                    Spacer()
                }
                .padding(.horizontal,40)
                .padding(.bottom,10)
                
                VStack {
                    HStack {
                        Image(systemName: "person.circle").foregroundColor(Color.Neumorphic.secondary).font(.system(size:30))
                        TextField("Login", text: $login).foregroundColor(Color.Neumorphic.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                        .softInnerShadow(RoundedRectangle(cornerRadius: 30))
                    )
                }
                    .padding(.horizontal,30)
                    .padding(.bottom,10)
                VStack {
                    HStack {
                        Image(systemName: "lock.fill").foregroundColor(Color.Neumorphic.secondary).font(.system(size:30))
                        SecureField("Password", text: $password).foregroundColor(Color.Neumorphic.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                        .softInnerShadow(RoundedRectangle(cornerRadius: 30))
                    )
                }
                    .padding(.horizontal,30)
                    .padding(.bottom,10)
                
                Button(action: {handleLogin()}) {
                    Text("Login")
                        .foregroundColor(.black)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title2)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                        
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal,30)
                .padding(.bottom,10)
                
                Button(action: {selection="SignUp"}) {
                    Text("Sign up")
                        .foregroundColor(.black)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title2)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal,30)
                .frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)



            }
            .frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
            

        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    @StateObject static var user = User()
    @State static private var selection: String? = "Login"

    static var previews: some View {
        LoginScreen(selection: $selection)
            .environmentObject(user)
    }
}
