//
//  VideoPlayerView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/3/24.
//

import SwiftUI
import AVFoundation

struct VideoIconView: View {
    
    let fileTitle: String
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Image(uiImage: UIImage(named: fileTitle) ?? UIImage(named: "noImage")!)
                    .resizable()
                    .scaledToFit()
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundStyle(Color("Background5"))
                    .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
            }
//            .frame(width: 350)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.black)
                    .frame(height: geometry.size.width * 0.6)
            )
            .padding()
        }
    }
}

#Preview {
    VideoIconView(fileTitle: "2bae694ff1f095f170e50f5a2e87392f1e46c871")
}
