//
//  ContentView.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI
import AlertToast
struct AddTodos: View {
    @EnvironmentObject var todos: Todos
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    @State private var showToast = false
    @State private var toastTitle:String = ""

    func handleAddTodo(){
        if (title.isEmpty || description.isEmpty){
            toastTitle="Fill info"
        }
        else{
            toastTitle="Adding todo"
            showToast.toggle()
            todos.addTodo(title: title, desc: description,cat:category)
            title=""
            description=""
            category=""
        }

    }
    var body: some View {
        ZStack{
            Color.purple.ignoresSafeArea()
            VStack{
                Text("Add todo")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom,10)
                    .foregroundColor(.white)
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
                    .padding(.all,10)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(todos.isLoading ? Color.red : Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal,40)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                VStack{
                    Button(action: {handleAddTodo()}, label: {
                        VStack{
                            Text("Add")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
                        .padding(.vertical,10)
                        .background(Color.white)
                        .cornerRadius(10)
                    })
                }
                .padding(.horizontal,40)
                .padding(.bottom,40)
            }
            .toast(isPresenting: $showToast, duration: 1, tapToDismiss: true, alert: {
                AlertToast(displayMode:.hud,type: .regular, title: toastTitle)

            })

        }
        
    }

}

struct AddTodos_Previews: PreviewProvider {
    static var previews: some View {
        AddTodos()
            .environmentObject(Todos())
    }
}



