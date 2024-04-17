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
    let question: QuestionModel
//    let label = MTMathUILabel()
    
    var body: some View {
        HStack {
            QuestionChoiceBox(isSelected: isSelected, questionType: question.questionType)
                .padding(10)

            viewForString(string: option, question: question)
            
            Spacer()
        }
    }
}

#Preview {
    let question: QuestionModel = QuestionModel(id: 0, question: QuestionContentModel(content: "here is an example content $5\\div6$ \n[[image]]", images: [ImageModel(url: "test", height: 100, width: 100)]), options: ["option 1 $7\\times2=\\text{?}$", "option 2", "option 3", "option 4"], correctAnswers: ["option 2"], hints: [HintModel(content: "Hint 1")], questionType: .multipleChoice, videos: ["test"])
    
    return QuestionChoiceView(option: "Which problem can we solve with $60\\div6$?", isSelected: false, question: question)
}
