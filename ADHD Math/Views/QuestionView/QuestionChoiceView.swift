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
    @Binding var selectedAnswers: [String]
    let question: QuestionModel
    
    var body: some View {
        HStack {
            QuestionChoiceBox(option: option, selectedAnswers: $selectedAnswers, questionType: question.questionType)
                .padding(10)

            viewForString(string: option, question: question)
                .frame(maxWidth: 200, alignment: .leading)
            
            Spacer()
        }
        .frame(width: 300)
    }
}

#Preview {
    let question: QuestionModel = QuestionModel(id: 0, hints: [HintModel(content: "Hint 1")], question: QuestionContentModel(content: "\\blue\\square\\times 7~&=63", images: [ImageModel(url: "noVideo", height: 100, width: 100)]), options: ["option 1 $7\\times2=\\text{?}$", "option 2", "option 3", "option 4"], questionType: .multipleChoice, correctAnswers: ["option 2"], videos: ["noVideo"])
    @State var selectedAnswers: [String] = [""]
    
    return QuestionChoiceView(option: "$\\color{blue}{30}\\div\\color{green}10\\color{black}=\\color{red}{?}\\color{black}$", isSelected: false, selectedAnswers: $selectedAnswers, question: question)
}
