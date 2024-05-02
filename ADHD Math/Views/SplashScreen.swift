//
//  SplashScreen.swift
//  ADHD Math
//
//  Created by Ben Cuello-Wolffe on 5/2/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var animate: Bool = false
    @State var isActive: Bool = false

    var body: some View {
        
        if isActive {
            TaskView()
        } else {
            
            ZStack {
                
                Color(.background3Accent)
                    .ignoresSafeArea()
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .scaleEffect(animate ? 1.1 : 1.0)
                }
            }
            .onAppear {
                addAnimation()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    SplashScreen()
}
