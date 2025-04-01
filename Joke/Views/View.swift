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
    
    // Controls button visibility
    @State var buttonOpacity = 0.0
    
    // Controls whether save button is enabled
    @State var jokeHasBeenSaved = false
    
    
    // Starts a timer to wait on revealing punchline
    @State var punchlineTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
   
    // Starts a timer to wait on revealing button to get new joke
    @State var buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
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
                
                Button {
                    
                    // Save the joke
                    viewModel.saveJoke()
                    
                    // Disable this button until next joke is loaded
                    jokeHasBeenSaved = true
                    
                } label: {
                    Text("Save for later")
                }
                .tint(.green)
                .buttonStyle(.borderedProminent)
                .opacity(buttonOpacity)
                .padding(.bottom, 20)
                .disabled(jokeHasBeenSaved)
                
                Button {
                 
                    // Hide punchline and button
                    withAnimation {
                        viewModel.currentJoke = nil
                        punchlineOpacity = 0.0
                        buttonOpacity = 0.0
                    }
                                        
                    // Get a new joke
                    Task {
                        await viewModel.fetchJoke()
                    }
                    
                    // Restart timers
                    punchlineTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
                    buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                    
                    // Enable save button again
                    jokeHasBeenSaved = false
                    
                } label: {
                 
                    Text("New Joke")
                    
                }
                .buttonStyle(.borderedProminent)
                .opacity(buttonOpacity)
                .onReceive(buttonTimer) { _ in
                    
                    withAnimation {
                        buttonOpacity = 1.0
                    }
                    
                    // Stop the timer
                    buttonTimer.upstream.connect().cancel()
                }
                
            }
            
        }
    }
}
 
#Preview {
    JokeView()
}
