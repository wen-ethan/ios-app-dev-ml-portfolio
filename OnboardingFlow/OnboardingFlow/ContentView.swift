//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by Ethan Wen on 7/1/26.
//
// https://developer.apple.com/tutorials/develop-in-swift/design-an-interface

import SwiftUI

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

struct ContentView: View {
    var body: some View {
        TabView {
            WelcomePage()
            FeaturesPage()
        }
        .background(Gradient(colors: gradientColors))
        .tabViewStyle(.page)
        .foregroundStyle(.white)
    }
}

#Preview {
    ContentView()
}
