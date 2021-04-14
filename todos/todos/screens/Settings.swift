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
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?

    func handleLogOut(){
        let dummyVal:String=""
        UserDefaults.standard.set(dummyVal, forKey: "AuthKey")
        todos.setAuthKey(key: "")
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
    }
    @ViewBuilder func showPickedImage()->some View{
        if let inputImage = inputImage {
            VStack{
                 Image(uiImage: inputImage)
                    .resizable()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding(.all,40)
            
        }
    }

    
    func handlePickImage(){
        showingImagePicker=true
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
                ScrollView{
                    VStack{
                        Text("Pick image")
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom,10)
                            .foregroundColor(.white)
                            .onTapGesture(perform: {handlePickImage()})
                        showPickedImage()
                        Button(action: {handleLogOut()}, label: {
                            Text("Log out")
                                .font(.system(size: 40))
                        })
                        .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
                .clipped()

            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage,fromGallery:false)
            }
            

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



