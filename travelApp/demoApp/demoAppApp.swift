//
//  demoAppApp.swift
//  demoApp
//
//  Created by Mykyta Brazhynskyy on 24/03/2021.
//

import SwiftUI

@main
struct demoAppApp: App {
    @StateObject var locations = Locations()
    var body: some Scene {
        WindowGroup {
            TabView{
                NavigationView{
                    ContentView(location: locations.primary)
                }.tabItem {
                    Image(systemName:"airplane.circle.fill")
                    Text("Discover")
                }
                NavigationView{
                    WorldView()
                }.tabItem {
                    Image(systemName:"star.fill")
                    Text("Locations")
                }
                NavigationView{
                    TipsView()
                }.tabItem {
                    Image(systemName:"list.bullet")
                    Text("Tips")
                }

            }
            .environmentObject(locations)
        }
    }
}

// This code can be found in the Swift package:
// https://github.com/johnno1962/HotSwiftUI

#if DEBUG
import Combine

private var loadInjection: () = {
    #if os(macOS)
    let bundleName = "macOSInjection.bundle"
    #elseif os(tvOS)
    let bundleName = "tvOSInjection.bundle"
    #elseif targetEnvironment(simulator)
    let bundleName = "iOSInjection.bundle"
    #else
    let bundleName = "maciOSInjection.bundle"
    #endif
    Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/"+bundleName)!.load()
}()

public let injectionObserver = InjectionObserver()

public class InjectionObserver: ObservableObject {
    @Published var injectionNumber = 0
    var cancellable: AnyCancellable? = nil
    let publisher = PassthroughSubject<Void, Never>()
    init() {
        cancellable = NotificationCenter.default.publisher(for:
            Notification.Name("INJECTION_BUNDLE_NOTIFICATION"))
            .sink { [weak self] change in
            self?.injectionNumber += 1
            self?.publisher.send()
        }
    }
}

extension SwiftUI.View {
    public func eraseToAnyView() -> some SwiftUI.View {
        return AnyView(self)
    }
    public func onInjection(bumpState: @escaping () -> ()) -> some SwiftUI.View {
        return self
            .onReceive(injectionObserver.publisher, perform: bumpState)
            .eraseToAnyView()
    }
}
#else
extension SwiftUI.View {
    @inline(__always)
    public func eraseToAnyView() -> some SwiftUI.View { return self }
    @inline(__always)
    public func onInjection(bumpState: @escaping () -> ()) -> some SwiftUI.View {
        return self
    }
}
#endif
