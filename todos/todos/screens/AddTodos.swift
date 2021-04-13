//
//  ContentView.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI
import AlertToast
import Neumorphic

struct AddTodos: View {
    @EnvironmentObject var todos: Todos
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    @State private var showToast = false
    @State private var toastTitle:String = ""
    @Binding var isVis:Bool

    func handleAddTodo(){
        if (title.isEmpty || description.isEmpty){
            toastTitle="Fill info"
            showToast.toggle()
        }
        else{
            toastTitle="Adding todo"
            showToast.toggle()
            todos.addTodo(title: title, desc: description,cat:category)
            title=""
            description=""
            category=""
            isVis=false
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
                    Text("Add todo")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        
                    
                    Spacer()
                    Button(action: {isVis=false}, label: {
                        Text("X")
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                    })
                }
                .padding(.horizontal,40)
                .padding(.bottom,10)
                

                VStack(alignment: .leading, spacing: 0) {
                    VStack{
                        Text("Add title")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                       
                        TextField(
                                "Title",
                                 text: $title
                        )
                        .padding(.horizontal,20)
                        .padding(.vertical,5)
                        .border(Color.gray, width: 2)
                        .cornerRadius(5)
                        Text("Add category")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                       
                        TextField(
                                "Category",
                                 text: $category
                        )
                        .padding(.horizontal,20)
                        .padding(.vertical,5)
                        .border(Color.gray, width: 2)
                        .cornerRadius(5)
                        Text("Add description")
                            .font(.title2)
                            .multilineTextAlignment(.center)

                        TextEditor(text: $description)
                            .frame(maxHeight:200)
                            .border(Color.gray, width: 2)
                            .cornerRadius(5)
                    }
                    .padding(.all,20)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                }
                .padding(.horizontal,30)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                
                Button(action: {handleAddTodo()}) {
                    Text("Add")
                        .foregroundColor(.black)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title2)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                        
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal,30)

            }
            .toast(isPresenting: $showToast, duration: 1, tapToDismiss: true, alert: {
                AlertToast(displayMode:.hud,type: .regular, title: toastTitle)
            })

        }
        
        
    }
}

struct AddTodos_Previews: PreviewProvider {
    @State static var showModal: Bool = true
    @StateObject static var api = API()

    @StateObject static var todos = Todos(authKey: "da")

    static var previews: some View {
        AddTodos(isVis:$showModal)
            .environmentObject(todos)
    }
}



