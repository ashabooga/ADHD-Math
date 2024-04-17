//
//  QuestionChoiceView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/5/24.
//

import SwiftUI
import LaTeXSwiftUI

struct QuestionChoiceView: View {
    
    let option: String
    @State var isSelected: Bool
    let questionType: QuestionType
//    let label = MTMathUILabel()
    
    var body: some View {
        HStack {
            QuestionChoiceBox(isSelected: isSelected, questionType: questionType)
                .padding(10)
//            
//            LaTeX(option)
//                .imageRenderingMode(.original)
//                .font(.title)
            
            Spacer()
        }
    }
}

#Preview {
    QuestionChoiceView(option: "Which problem can we solve with $60\\div6$?", isSelected: false, questionType: QuestionType.multipleChoice)
}
