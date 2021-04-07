//
//  ContentView.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI

struct AllTodos: View {
    @EnvironmentObject var todos: Todos
    var pickedId:Int?=nil
    func onTodoPress(id:Int){
        todos.setPickedTodo(id:id)
    }
    func onRemove(id:Int){
        todos.removeTodo(id:id)
    }
    var body: some View {
        ZStack{
            Color.purple.ignoresSafeArea()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllTodos()
            .environmentObject(Todos())
    }
}

struct TodoItem: View {
    var todo:Todo
    var onPress:(Int)->Void
    var onRemove:(Int)->Void
    
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
        Button(action: {onPress(todo.id)}, label: {
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
                    .padding(.vertical,10)
                    
                }
                .background(bgColor)
                .cornerRadius(10)
                .padding(.top,10)
                .padding(.horizontal,30)
            })

    }
}
