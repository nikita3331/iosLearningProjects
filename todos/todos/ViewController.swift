//
//  ViewController.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 08/04/2021.
//

import SwiftUI
import iActivityIndicator

enum Tab {
    case Tab1
    case Tab2
}
struct ViewController: View {
    @State private var currentView: Tab = .Tab1
    @State private var showModal: Bool = false
    @StateObject var todos:Todos

    var edgesTop:CGFloat

    var body: some View {
            NavigationView {
                ZStack{
                    VStack{
                        CurrentScreen(currentView: self.$currentView)
                            .padding(.top,edgesTop)
                        TabBar(currentView: self.$currentView, showModal: self.$showModal)
                    }
                    .edgesIgnoringSafeArea(.top)
                    LoaderView(isVisible:todos.isLoading)
                        .padding(.bottom,50)
                    
                }

            }
            .background(Color(.white))
            .navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$showModal) { AddTodos(isVis:self.$showModal) }
            .environmentObject(todos)

    }
}
struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 5.0
    var isVisible: Bool = false
    var body: some View {
        if (isVisible){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
                .padding(.all,7)
                .background(Color.white)
                .cornerRadius(10)
                .scaleEffect(scaleSize, anchor: .center)
            
        }

    }
    
}

struct CurrentScreen: View {
    @Binding var currentView: Tab
    var body: some View {
        VStack {
            switch(self.currentView){
                case .Tab1 : AllTodos()
                case .Tab2 : Settings()
            }
        }
    }
}
struct ViewController_Previews: PreviewProvider {
    @StateObject static var todos = Todos(authKey: "dad")


    static var previews: some View {
        ViewController(todos:todos,edgesTop: 48.0)
    }
}
