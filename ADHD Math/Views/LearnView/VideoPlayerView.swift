//
//  VideoPlayerView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/3/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    @State private var player = AVPlayer()
    let videoURL: URL
    
    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                player = AVPlayer(url: videoURL)
                player.play()
            }
    }
}

#Preview {
    VideoPlayerView(videoURL: Bundle.main.url(forResource: "test", withExtension: "mp4")!)
}
