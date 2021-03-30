//
//  WorldView.swift
//  demoApp
//
//  Created by Mykyta Brazhynskyy on 30/03/2021.
//
import MapKit
import SwiftUI
struct WorldView: View {
    @EnvironmentObject var locations:Locations
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.50722,
            longitude: -0.1275
        ), span: MKCoordinateSpan(
            latitudeDelta: 40,
            longitudeDelta: 40
        )
    )
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems:locations.places
        ){
            item in
            MapAnnotation(coordinate:
                CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude),
                      content:{
                    NavigationLink(
                        destination: ContentView(location: item),
                        label: {
                            Image(item.country)
                                .resizable()
                                .cornerRadius(10)
                                .frame(width:80,height:40)
                                .shadow(radius:3)
                        })
                }
            )
        }
            .navigationTitle("Halko")
    }
}

struct WorldView_Previews: PreviewProvider {
    static var previews: some View {
        WorldView()
    }
}
