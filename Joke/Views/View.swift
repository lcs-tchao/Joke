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
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            // Show a joke if one exists
            if let currentJoke = viewModel.currentJoke {
                
                Group {
                    Text(currentJoke.setup ?? "")
                        .padding(.bottom, 100)
                    
                    Text(currentJoke.punchline ?? "")
 
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
