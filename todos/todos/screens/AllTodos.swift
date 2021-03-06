//
//  ContentView.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI
import Neumorphic

struct AllTodos: View {
    @EnvironmentObject var todos: Todos
    var pickedId:Int?=nil
    func onTodoPress(id:String){
            todos.setPickedTodo(id:id)
        
    }
    func onRemove(id:String){
        todos.removeTodo(id:id)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color.Neumorphic.main.ignoresSafeArea()
                VStack{
                    Text("All your todos")
                        .font(.largeTitle)
                    VStack(alignment: .leading, spacing: 0) {
                            ForEach(todos.todos,id:\.id){
                                item in TodoItem(todo:item,onPress:onTodoPress,onRemove:onRemove)
                                    
                            }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                }
            }
        }
        
    }
    
}


struct TodoItem: View {
    var todo:Todo
    var onPress:(String)->Void
    var onRemove:(String)->Void

    @ViewBuilder func showImage()-> some View{
        if (todo.picked){
            Button(action: {onRemove(todo.id)}, label: {
                Image(systemName:"trash.circle")
                   .resizable()
                   .frame(width: 40, height: 40, alignment: .center)
                   .padding(.vertical,5)
                    .foregroundColor(Color.red)
            })

            
        }
    }
    @ViewBuilder func showDesc()-> some View{
        if (todo.picked){
            Text(todo.description)
                .foregroundColor(.black)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal,20)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
    
    var body: some View {
        var bgColor=todo.picked ? Color.white:Color.green

        Button(action: {onPress(todo.id)}) {
            VStack{
                VStack{
                    Text(todo.title)
                        .foregroundColor(.gray)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal,20)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    showDesc()
                    showImage()
                }
            }
            .cornerRadius(10)
        }
        .softButtonStyle(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal,30)
        .padding(.top,20)
    }
}
struct ContentView_Previews: PreviewProvider {
    @StateObject static var api = API()

    @StateObject static var todos = Todos(authKey: "f15c81b769e895100fbe2fde31534347bf582050")
    

    static var previews: some View {
        AllTodos()
            .environmentObject(todos)

    }
}
