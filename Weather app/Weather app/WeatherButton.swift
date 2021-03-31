//
//  WeatherButton.swift
//  Weather app
//
//  Created by Mykyta Brazhynskyy on 31/03/2021.
//

import Foundation
import SwiftUI
struct CustomButton: View {
    var title:String
    var myAction:()->Void
    var body: some View {
        Button(action: myAction, label: {
            Text(title)
                .foregroundColor(Color("LightBlue"))
                .font(.system(size: 40))
                .padding(.all,5)
                .background(Color(.white))
                .cornerRadius(10)
            
        })
    }
}
