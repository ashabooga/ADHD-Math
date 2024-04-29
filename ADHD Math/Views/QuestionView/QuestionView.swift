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
    var incrementIndex: () -> Void
    @Binding var exerciseResults: [Bool]
    @State var selectedAnswers: [String] = []
    
    @State var showingQuestionAlert: Bool = false
    @State private var questionAlertState: AlertState = AlertState.noAlert
    
    @State var hasAnswered: Bool = false
    
    @State private var isCorrect: Bool = false
    @State private var numHintsDisplayed: Int = 0
    
    var body: some View {
        
        ZStack {
            
            ScrollViewReader { value in
                ScrollView {
                        
                    viewForString(string: question.question.content, question: question)
                        .padding(.bottom, 30)

                    QuestionBoxView(question: question, isTest: isTest, selectedAnswers: $selectedAnswers, hintAction: { self.hintAction() })
                    
                    Button {
                        if isCorrect {
                            withAnimation(.spring) {
                                showingQuestionAlert = false
                            }
                            incrementIndex()
                        } else {
                            manageAnswer(selectedAnswers: selectedAnswers, question: question)
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 50)
                                .foregroundStyle(Color(.background3Accent))
                            
                            Text(hasAnswered ? isCorrect ? "Next" : "Check Again" : "Check")
                                .font(.title3)
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.top, -20)
                    .padding(.bottom, 30)

                    
                    if numHintsDisplayed > 0 {
                        
                        QuestionDisplayedHintsView(question: question, numHintsDisplayed: $numHintsDisplayed, hintAction: { self.hintAction() })
                            .id(1)
                            .onChange(of: numHintsDisplayed) {
                                withAnimation {
                                    value.scrollTo(1, anchor: .top)
                                }
                            }
                    }
                    
                }
                .padding(.top, 20)
            }
            
            
            if showingQuestionAlert {
                QuestionAlertView(isShowing: $showingQuestionAlert, state: $questionAlertState)
            }
        }
    }
    
    func hintAction() {
        print(numHintsDisplayed)
        if numHintsDisplayed < question.hints.count {
            numHintsDisplayed += 1
        }
    }
    
    func manageAnswer(selectedAnswers: [String], question: QuestionModel) {
    
        if selectedAnswers.count == question.correctAnswers.count {
            if selectedAnswers.sorted() == question.correctAnswers.sorted() {
                
                questionAlertState = AlertState(isCorrect: true, title: "Correct Answer!", content: "Click the 'next' button to continue.")
                showingQuestionAlert = true
                
                exerciseResults.append(!hasAnswered)
                isCorrect = true
                hasAnswered = true
                
                return
            } else {
                hasAnswered = true
                
                questionAlertState = AlertState(isCorrect: false, title: "Incorrect Answer", content: "Try again!")
                showingQuestionAlert = true
            }
        } else {
            hasAnswered = true
            questionAlertState = AlertState(isCorrect: false, title: "Incorrect Answer", content: "Please input \(question.correctAnswers.count) options.")
            showingQuestionAlert = true
        }
        
    }
}

#Preview {
    
    func noFunc() {
        print("next tab")
    }
    
    @State var exerciseResults: [Bool] = []
    
    return QuestionView(question: QuestionModel(id: 0, hints: [HintModel(content: "Hint 1")], question: QuestionContentModel(content: "here is an example content $\\color{blue}5\\div6$ [[image 0]] above is a lovely picture of $\\color{red}\\text{flowers}$!!!", images: [ImageModel(url: "pandaPNG", height: 250, width: 300)]), options: ["option 1", "option 2", "option 3", "option 4"], questionType: .singleChoice, correctAnswers: ["option 2"], videos: ["noVideo"]), isTest: false, incrementIndex: { noFunc() }, exerciseResults: $exerciseResults)
        .background(Color.background3.ignoresSafeArea())
}
