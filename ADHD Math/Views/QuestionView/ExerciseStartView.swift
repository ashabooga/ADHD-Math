//
//  ExerciseStartView.swift
//  ADHD Math
//
//  Created by Cuello-Wolffe, Ben on 24/04/2024.
//

import SwiftUI

struct ExerciseStartView: View {
    
    var incrementTabIndexFunction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Starting Exercise")
            
            Spacer()
            
            Button(action: {
                incrementTabIndexFunction()
            }, label: {
                Text("Let's Go!")
                    .foregroundStyle(Color.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 75)
                            .foregroundStyle(Color.offWhite)
                            .shadow(radius: 15)
                    )
            })
            .padding(.vertical, 30)
        }
    }
}

#Preview {
    ExerciseStartView(incrementTabIndexFunction: { print("next tab") })
}
