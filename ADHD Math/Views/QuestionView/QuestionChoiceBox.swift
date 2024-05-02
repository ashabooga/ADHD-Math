//
//  QuestionChoiceBox.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/5/24.
//

import SwiftUI

struct QuestionChoiceBox: View {
    
    let option: String
    @Binding var selectedAnswers: [String]
    let questionType: QuestionType
    
    var body: some View {
        
        var isSelected: Bool {
            selectedAnswers.contains(option)
        }
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.black)
                .frame(width: 40, height: 40)
            
            Button {
                if questionType == .singleChoice {
                    selectedAnswers = [option]
                } else if questionType == .multipleChoice {
                    if isSelected {
                        selectedAnswers = selectedAnswers.filter { $0 != option }
                    } else {
                        selectedAnswers.append(option)
                    }
                }
            } label: {
                if isSelected {
                    Rectangle()
                        .foregroundStyle(.background4)
                        .frame(width: 30, height: 30)
                } else {
                    Rectangle()
                        .foregroundStyle(.background3Accent)
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

#Preview {
    @State var selectedAnswers: [String] = ["Test"]
    
    return QuestionChoiceBox(option: "Test", selectedAnswers: $selectedAnswers, questionType: QuestionType.multipleChoice)
}
