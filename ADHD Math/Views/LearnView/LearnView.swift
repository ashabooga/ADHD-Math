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
        let url = Bundle.main.url(forResource: lesson.fileTitle, withExtension: "mp4")!
        
        NavigationStack {
            ZStack {
                Color(.background2)
                    .ignoresSafeArea()
                
                VStack {
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
                }
                
            }
            .navigationTitle(lesson.displayTitle)
        }
    }
}

#Preview {
    LearnView(lesson: LessonModel(id: 0, displayTitle: "Example Video", fileTitle: "test", type: .video, isCompleted: false))
}
