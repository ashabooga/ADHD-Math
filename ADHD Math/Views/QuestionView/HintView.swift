//
//  HintView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/17/24.
//

import SwiftUI

struct HintView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var fileTitle: String
    
    var body: some View {
        let url = Bundle.main.url(forResource: fileTitle, withExtension: "mp4")!
        
        NavigationStack {
            VStack {
                NavigationLink {
                    HintVideoPlayerView(videoURL: url)
                } label: {
                    VideoIconView(fileTitle: fileTitle)
                }
                .padding(.vertical, 30)
                    
                HStack {
                
                    Button(action: {
                        print("hi")
                    }, label: {
                        Text("Need another hint?")
                            .font(.title3)
                    })
                    
                    Spacer()
                }
                .padding(.leading, 40)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Back to task")
                            .bold()
                            .font(.title3)
                            .foregroundStyle(Color.black)

                        TaskCompletionIconView(isCompleted: false)
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("Background3Accent"))
                    }
                }
            }
            .navigationTitle("Hint")
        }
    }
}

#Preview {
    HintView(fileTitle: "test")
}
