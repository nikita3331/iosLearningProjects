//
//  LoginScreen.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 11/04/2021.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    @StateObject static var user = User()

    static var previews: some View {
        LoginScreen()
            .environmentObject(user)
    }
}
