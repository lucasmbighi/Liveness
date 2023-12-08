//
//  ContentView.swift
//  Example
//
//  Created by Lucas Bighi on 08/12/23.
//

import SwiftUI
import Liveness

struct ContentView: View {
    
    @State private var showLiveness = false
    @State private var photoTaken: Image?
    
    var body: some View {
        VStack {
            if let photoTaken {
                photoTaken
            } else {
                Text("Your photo will appear here")
            }
            Spacer()
            Button(action: {
                showLiveness.toggle()
            }, label: {
                Text("Start Liveness")
            })
        }
        .padding()
        .fullScreenCover(isPresented: $showLiveness, content: {
            Liveness.build(photoTaken: $photoTaken)
        })
    }
}
