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
    var manageAnswer: ([String], QuestionModel) -> Void
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
                manageAnswer(selectedAnswers, question)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(Color(.background3Accent))
                    
                    Text("Check")
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
    
    func noFunc() {
        print("next tab")
    }
    
    return QuestionView(question: QuestionModel(id: 0, hints: [HintModel(content: "Hint 1")], question: QuestionContentModel(content: "here is an example content $\\color{blue}5\\div6$ [[image 0]] above is a lovely picture of $\\color{red}\\text{flowers}$!!!", images: [ImageModel(url: "pandaPNG", height: 250, width: 300)]), options: ["option 1", "option 2", "option 3", "option 4"], questionType: .singleChoice, correctAnswers: ["option 2"], videos: ["test"]), isTest: false, manageAnswer: { _,_ in noFunc() })
        .background(Color.background3.ignoresSafeArea())
}
