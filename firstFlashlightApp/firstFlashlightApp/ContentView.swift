//
//  ContentView.swift
//  firstFlashlightApp
//
//  Created by Ethan Wen on 6/24/26.
//

import SwiftUI

// Main Content View
struct ContentView: View {
    @State var backgroundColor = Color.white
    var body: some View {
        ZStack {
            VStack {
                backgroundColor
                Text("Flashlight")
                Button("Flash Color") {
                    backgroundColor = Color.blue
                }
            }
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
