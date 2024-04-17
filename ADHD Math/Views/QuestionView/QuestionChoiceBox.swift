//
//  QuestionChoiceBox.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/5/24.
//

import SwiftUI

struct QuestionChoiceBox: View {
    
    @State var isSelected: Bool
    let questionType: QuestionType
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.black)
                .frame(width: 40, height: 40)
            
            Button {
                if questionType == QuestionType.singleChoice {
                    isSelected = true
                } else if questionType == QuestionType.multipleChoice {
                    isSelected = !isSelected
                }
            } label: {
                if isSelected {
                    Rectangle()
                        .foregroundStyle(.background4)
                        .frame(width: 30, height: 30)
                } else {
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

#Preview {
    QuestionChoiceBox(isSelected: false, questionType: QuestionType.multipleChoice)
}
