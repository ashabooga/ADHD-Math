//
//  QuestionView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/13/24.
//

import SwiftUI

struct QuestionView: View {
    
    let question: QuestionModel
    
    var body: some View {
                
        ScrollView {
            
//            HStack {
//                Text(question.question)
//                    .questionTitleText(isBold: false)
//                    .padding(20)
//                 
//                Spacer()
//            }
//            
//            Spacer()
//            
//            Image("image")
//                .resizable()
//                .frame(width: 350, height: 300)
//            
//            HStack {
//                Text(question.questions[1])
//                    .questionTitleText(isBold: true)
//                    .padding(20)
//                 
//                Spacer()
//            }
            
            Spacer()
            
            QuestionBoxView(question: question)
                .contentShape(Rectangle()).gesture(DragGesture())
        }
        .padding(.top, 20)
    }
}

//#Preview {
//    
//    QuestionView(question: QuestionModel(questions: ["Check this hotdog out:", "Didja know that my name is ben?"], answers: ["That's cool man"], hints: ["It's true, my name is ben"], hasBeenAsked: false, questionType: QuestionType.multipleChoice, options: ["That's cool man", "Who gives a grap", "Are you sure that's true?"]))
//        .background(Color.background3.ignoresSafeArea())
//}
