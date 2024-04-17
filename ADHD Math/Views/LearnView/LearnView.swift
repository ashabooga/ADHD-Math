//
//  LearnView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 1/29/24.
//

import SwiftUI
import AVKit

struct LearnView: View {
    
    let lesson: LessonModel
    @ObservedObject var videoViewModel = VideoViewModel()
    
    var body: some View {
        
        let video: VideoModel = videoViewModel.getVideoFromFileTitle(fileTitle: lesson.fileTitle)
        
        let url = Bundle.main.url(forResource: video.fileTitle, withExtension: "mp4")!
        
        NavigationStack {
            ZStack {
                Color(.background2)
                    .ignoresSafeArea()
                
                VStack {
                    NavigationLink {
                        VideoPlayerView(videoURL: url)
                    } label: {
                        VideoIconView(video: video)
                    }
                    .frame(height: 250)
                    
                    Spacer()
                }
                
            }
            .navigationTitle(video.displayTitle)
        }
    }
}

#Preview {
    LearnView(lesson: LessonModel(id: 0, displayTitle: "Example Video", fileTitle: "test", type: .video, isCompleted: false))
}
