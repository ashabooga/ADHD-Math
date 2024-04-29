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
    var hintAction: () -> Void
    
    var body: some View {
        let url = Bundle.main.url(forResource: fileTitle, withExtension: "mp4")!
        
        NavigationStack {
            
            ZStack {
                Color("OffWhite").ignoresSafeArea()
                VStack {
                    HStack {
                        
                        Text("Watch a video on the topic:")
                            .font(.title3)
                        Spacer()
                    }
                    .padding()
                    
                    NavigationLink {
                        HintVideoPlayerView(videoURL: url)
                    } label: {
                        VideoIconView(fileTitle: fileTitle)
                    }
                        
                    HStack {
                    
                        Button(action: {
                            hintAction()
                            dismiss()
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
                .navigationTitle("Hints")
            }
        }
    }
}

#Preview {
    
    func noFunc() {
        print("display hint")
    }
    
    return HintView(fileTitle: "noVideo", hintAction: { noFunc() })
}
