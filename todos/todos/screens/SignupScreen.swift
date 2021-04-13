//
//  SignupScreen.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 12/04/2021.
//

import SwiftUI
import AlertToast

struct SignupScreen: View {
    @EnvironmentObject var user: User
    @State private var login:String=""
    
    @State private var password:String=""
    @State private var passwordRe:String=""
    @Binding var selection:String?
    @State private var toastTitle:String = ""
    @State private var showToast = false

    @Environment(\.presentationMode) var presentation
    func handleSignup(){
        if (!password.isEmpty || !login.isEmpty){
            if (password == passwordRe){
                var returned=user.handleRegister(login: login, password:password)
                if returned{
                    toastTitle="Success!"
                    showToast.toggle()
                    selection="Login"
                }
                else{
                    toastTitle="Failed to register"
                    showToast.toggle()
                }
            }
            else{
                toastTitle="Passwords does not match"
                showToast.toggle()
            }
        }
        else{
            toastTitle="Fields can't be empty"
            showToast.toggle()
        }

    }
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
//            Color.purple.ignoresSafeArea()
            VStack{
                HStack(alignment: .center){
                    Text("")
                    Spacer()
                    Text("Signup")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        
                    
                    Spacer()
                }
                .padding(.horizontal,40)
                .padding(.bottom,10)
                
                NeuInput(valuField: $login, iconName: "person.circle", placeholder: "Login")
                NeuInput(valuField: $password, iconName: "lock.fill", placeholder: "Password",secure:true)
                NeuInput(valuField: $passwordRe, iconName: "lock.fill", placeholder: "Re-enter password",secure:true)

                Button(action: {handleSignup()}) {
                    Text("Sign up")
                        .foregroundColor(.black)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title2)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                        
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal,30)
                .padding(.bottom,10)
                Button(action: {
                    selection="Login"
                }) {
                    Text("Go back")
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
            .toast(isPresenting: $showToast, duration: 1, tapToDismiss: true, alert: {
                AlertToast(displayMode:.hud,type: .regular, title: toastTitle)
            })

        }
    }
}

struct SignupScreen_Previews: PreviewProvider {
    @State static private var selection: String? = "Login"

    static var previews: some View {
        SignupScreen(selection:$selection)
    }
}

struct NeuInput: View {
    @Binding var valuField:String
    var iconName:String
    var placeholder:String
    var secure:Bool = false

    var body: some View {
        VStack {
            HStack {
                Image(systemName: iconName).foregroundColor(Color.Neumorphic.secondary).font(.system(size:30))
                if secure {
                    SecureField(placeholder, text:$valuField).foregroundColor(Color.Neumorphic.secondary)
                }
                else{
                    TextField(placeholder, text:$valuField).foregroundColor(Color.Neumorphic.secondary)

                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                    .softInnerShadow(RoundedRectangle(cornerRadius: 30))
            )
        }
        .padding(.horizontal,30)
        .padding(.bottom,10)
    }
}
