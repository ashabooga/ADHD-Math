//
//  FinishedExerciseView.swift
//  ADHD Math
//
//  Created by Cuello-Wolffe, Ben on 19/04/2024.
//

import SwiftUI

struct ExerciseEndView: View {
    
    var incrementTabIndexFunction: () -> Void
    @Binding var exerciseResults: [Bool]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("End of exercise")
            
            Spacer()
            
            if (Double(exerciseResults.filter{ $0 }.count) / Double(exerciseResults.count)) > 0.6 {
                TaskCompletionIconView(isCompleted: true)
            } else {
                TaskCompletionIconView(isCompleted: false)
            }
            
            Spacer()
            
            Button(action: {
                incrementTabIndexFunction()
            }, label: {
                Text("Back to tasks")
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
    
    @State var exerciseResults: [Bool] = [true, false, true, true, false, true]
    
    return ExerciseEndView(incrementTabIndexFunction: { print("next tab") }, exerciseResults: $exerciseResults)
}
