//
//  TabBar.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 08/04/2021.
//

import SwiftUI

struct TabBar: View {
    @Binding var currentView: Tab
    @Binding var showModal: Bool

    var body: some View {
        HStack {
            TabBarItem(currentView: self.$currentView, imageName: "list.bullet", paddingEdges: .leading, tab: .Tab1)
            Spacer()
            ShowModalTabBarItem(radius: 55) { self.showModal.toggle() }
            Spacer()
            TabBarItem(currentView: self.$currentView, imageName: "gear", paddingEdges: .trailing, tab: .Tab2)
        }
        .frame(minHeight: 70,alignment: .bottom)
    }
}
struct TabBarItem: View {
    @Binding var currentView: Tab
    let imageName: String
    let paddingEdges: Edge.Set
    let tab: Tab
    var body: some View {
        VStack(spacing:0) {
            Image(systemName: imageName)
                .font(.system(size:self.currentView == tab ? 50 : 40))
                .padding(5)
                .padding(.bottom,self.currentView == tab ? 5 : 0)
                .cornerRadius(6)
        }
        .frame(width: 100, height: 50)
        .onTapGesture { self.currentView = self.tab }
        .padding(paddingEdges, 15)
    }
}
public struct ShowModalTabBarItem: View {
    let radius: CGFloat
    let action: () -> Void

    public init(radius: CGFloat, action: @escaping () -> Void) {
        self.radius = radius
        self.action = action
    }

    public var body: some View {
        VStack(spacing:0) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: radius, height: radius, alignment: .center)
                .foregroundColor(Color(.systemBlue))
                .background(Color(.white))
                .cornerRadius(radius/2)
                .overlay(RoundedRectangle(cornerRadius: radius/2).stroke(Color(.blue), lineWidth: 2))

        }
        .frame(width: radius, height: radius)
        .onTapGesture(perform: action)
    }
}
struct TabBar_Previews: PreviewProvider {
    @State static var currentView: Tab = .Tab1
    @State static var showModal: Bool = false

    static var previews: some View {
        TabBar(currentView: $currentView, showModal: $showModal)
    }
}
