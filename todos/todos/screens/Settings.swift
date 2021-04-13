//
//  ContentView.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI
import AlertToast
import Neumorphic

struct Settings: View {
    @EnvironmentObject var todos: Todos
    func handleLogOut(){
        let dummyVal:String=""
        UserDefaults.standard.set(dummyVal, forKey: "AuthKey")
        todos.setAuthKey(key: "")
    }
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            VStack{
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom,10)
                    .foregroundColor(.white)
                Button(action: {handleLogOut()}, label: {
                    Text("Log out")
                        .font(.system(size: 40))
                })
                .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            

        }
        
    }

}

struct Settings_Previews: PreviewProvider {
    @StateObject static var api = API()

    @StateObject static var todos = Todos(authKey: "")

    static var previews: some View {
        Settings()
            .environmentObject(todos)
    }
}



