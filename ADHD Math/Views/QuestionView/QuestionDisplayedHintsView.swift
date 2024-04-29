//
//  QuestionDisplayedHintsView.swift
//  ADHD Math
//
//  Created by Cuello-Wolffe, Ben on 25/04/2024.
//

import SwiftUI

struct QuestionDisplayedHintsView: View {
    
    var question: QuestionModel
    @Binding var numHintsDisplayed: Int
    var hintAction: () -> Void
    
    var body: some View {
        
        VStack {
//            let range = 0..<min(numHintsDisplayed, question.hints.count)
//            ForEach(range) { index in
//                viewForString(string: question.hints[index].content, question: question)
//            }
            
            let max = min(numHintsDisplayed, question.hints.count)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 350, height: 5)
                .opacity(0.1)
            
            ForEach(question.hints.indices, id: \.self) { index in
                
                if index < max {
                    HStack {
                            
                        viewForString(string: question.hints[index].content, question: question)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 20)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350)
                                    .foregroundStyle(.offWhite)
                            }

                    }
                }
            }
            .padding(.top, 30)
            
            if numHintsDisplayed < question.hints.count {
                Button(action: {
                    hintAction()
                }, label: {
                    HStack {
                        Text("Another hint")
                        Image(systemName: "plus")
                    }
                    
                })
            }
        }
    }
}

#Preview {
    
    let question: QuestionModel = QuestionModel(id: 0, hints: [HintModel(content: "Okay get ready guys I'm gonna show you a super super cool image: [[image 0]] What's the answer? $25\\color{blue}\\div\\color{black}5$", images: [ImageModel(url: "pandaPNG", height: 300, width: 200)]), HintModel(content: "Okay get ready guys I'm gonna show you a super super cool image: [[image 0]] What's the answer? $25\\color{blue}\\div\\color{black}5$", images: [ImageModel(url: "pandaPNG", height: 300, width: 200)])], question: QuestionContentModel(content: "here is an example content $5\\div6$ \n[[image 1]]", images: [ImageModel(url: "noVideo", height: 100, width: 100)]), options: ["option 1 $7\\times2=\\text{?}$", "option 2", "option 3", "option 4"], questionType: .singleChoice, correctAnswers: ["option 2"], videos: ["noVideo"])
    @State var num = 2
    
    func noFunc() {
        print("Adding hint")
    }
    
    return QuestionDisplayedHintsView(question: question, numHintsDisplayed: $num, hintAction: { noFunc() })
}
