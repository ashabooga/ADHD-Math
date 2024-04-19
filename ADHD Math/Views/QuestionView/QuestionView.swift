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
    let isTest: Bool
    @State var selectedAnswers: [String] = []
    
    var body: some View {
                
        ScrollView {
            
            VStack {

                viewForString(string: question.question.content, question: question)
                
                Spacer()
            }
            
            Spacer()
            
            QuestionBoxView(question: question, isTest: isTest, selectedAnswers: $selectedAnswers)
            
            Button {
                print(selectedAnswers.description)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(Color(.background3Accent))
                    
                    LaTeX("Check")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
            }
            .padding(.top, -40)
        }
        .padding(.top, 20)
    }
}

#Preview {
    
    QuestionView(question: QuestionModel(id: 0, hints: [HintModel(content: "Hint 1")], question: QuestionContentModel(content: "here is an example content $\\color{blue}5\\div6$ \n[[image 0]]\n above is a lovely picture of $\\color{red}\\text{flowers}$!!!", images: [ImageModel(url: "test2", height: 250, width: 300)]), options: ["option 1", "option 2", "option 3", "option 4"], questionType: .singleChoice, correctAnswers: ["option 2"], videos: ["test"]), isTest: false)
        .background(Color.background3.ignoresSafeArea())
}
