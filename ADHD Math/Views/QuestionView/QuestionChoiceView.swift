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
            
            Spacer()
        }
    }
}

#Preview {
    let question: QuestionModel = QuestionModel(id: 0, hints: [HintModel(content: "Hint 1")], question: QuestionContentModel(content: "here is an example content $5\\div6$ \n[[image]]", images: [ImageModel(url: "test", height: 100, width: 100)]), options: ["option 1 $7\\times2=\\text{?}$", "option 2", "option 3", "option 4"], questionType: .multipleChoice, correctAnswers: ["option 2"], videos: ["test"])
    @State var selectedAnswers: [String] = [""]
    
    return QuestionChoiceView(option: "$\\color{green}36\\color{black} \\div \\color{purple}9$ equals $\\color{green}36\\color{black}$ total dots split into rows of $\\color{purple}9$.", isSelected: false, selectedAnswers: $selectedAnswers, question: question)
}
