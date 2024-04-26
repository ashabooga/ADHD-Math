//
//  LearnView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 1/29/24.
//

import SwiftUI
import AVKit

struct LearnView: View {
    
    @EnvironmentObject var lessonViewModel: LessonViewModel
    let lesson: LessonModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background2)
                    .ignoresSafeArea()
                
                VStack {
                    if let url = Bundle.main.url(forResource: lesson.fileTitle, withExtension: "mp4") {
                        NavigationLink {
                            VideoPlayerView(videoURL: url)
                                .onAppear(perform: {
                                    lessonViewModel.completeLesson(lesson: lesson)
                                })
                        } label: {
                            VideoIconView(fileTitle: lesson.fileTitle)
                        }
                        .frame(height: 250)
                        
                        Spacer()
                    } else {
                        Text("Video Not Found")
                    }
                }
                
            }
            .navigationTitle(lesson.displayTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LearnView(lesson: LessonModel(id: 0, displayTitle: "Example Video", fileTitle: "test", type: .video, isCompleted: false))
        .environmentObject(LessonViewModel())
}
