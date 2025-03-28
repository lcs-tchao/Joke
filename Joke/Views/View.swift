//
//  View.swift
//  Joke
//
//  Created by Yuk Yeung Chao on 2025-03-28.
//

import SwiftUI
struct JokeView: View {
    
    // MARK: Stored properties
    
    // Create the view model (temporarily show the default joke)
    @State var viewModel = JokeViewModel()
    
    // Controls punchline visibility
    @State var punchlineOpacity = 0.0
    
    // Starts a timer to wait on revealing punchline
    @State var punchlineTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
   
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            // Show a joke if one exists
            if let currentJoke = viewModel.currentJoke {
                
                Group {
                    Text(currentJoke.setup ?? "")
                        .padding(.bottom, 100)
                    
                    Text(currentJoke.punchline ?? "")
                        .opacity(punchlineOpacity)
                        .onReceive(punchlineTimer) { _ in
                            
                            withAnimation {
                                punchlineOpacity = 1.0
                            }
                            
                            // Stop the timer
                            punchlineTimer.upstream.connect().cancel()
                        }
 
                }
                .font(.title)
                .multilineTextAlignment(.center)
                
            }
            
        }
    }
}
 
#Preview {
    JokeView()
}
