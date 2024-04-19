//
//  QuestionView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/13/24.
//

import SwiftUI
import LaTeXSwiftUI

struct QuestionView: View {
    
    let question: QuestionModel
    
    var body: some View {
                
        ScrollView {
            
            VStack {

                viewForString(string: question.question.content, question: question)
                
                Spacer()
            }
            
            Spacer()
            
            QuestionBoxView(question: question)
        }
        .padding(.top, 20)
    }
}

#Preview {
    
    QuestionView(question: QuestionModel(id: 0, question: QuestionContentModel(content: "here is an example content $\\color{blue}5\\div6$ \n[[image 0]]above is a lovely picture of $\\color{red}\\text{flowers}$!!!", images: [ImageModel(url: "test2", height: 250, width: 300)]), options: ["option 1", "option 2", "option 3", "option 4"], correctAnswers: ["option 2"], hints: [HintModel(content: "Hint 1")], questionType: .multipleChoice, videos: ["test"]))
        .background(Color.background3.ignoresSafeArea())
}
