//
//  ContentView.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI
import AlertToast
struct Settings: View {
    @EnvironmentObject var todos: Todos
    func handleLogOut(){
        print("log out")
    }
    var body: some View {
        ZStack{
            Color.purple.ignoresSafeArea()
            VStack{
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom,10)
                    .foregroundColor(.white)
                Button(action: {handleLogOut()}, label: {
                    Text("Log out")
                        .font(.system(size: 40))
                        .padding(.horizontal,40)
                        .background(Color.white, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10.0)
                })
                .padding(.top,30)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            

        }
        
    }

}

struct Settings_Previews: PreviewProvider {
    @StateObject static var api = API()

    @StateObject static var todos = Todos(authKey: "dada")

    static var previews: some View {
        Settings()
            .environmentObject(todos)
    }
}



