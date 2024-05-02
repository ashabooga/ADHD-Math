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
    @FocusState var isFocused: Bool
    
    @State private var isCorrect: Bool = false
    @State private var numHintsDisplayed: Int = 0
    
    var body: some View {
        
        ZStack {
            
            ScrollViewReader { value in
                ScrollView {
                        
                    viewForString(string: question.question.content, question: question)
                        .padding(.bottom, 30)
                        .frame(maxWidth: 375)
                        .frame(minHeight: 250)
                    
                    if question.questionType == QuestionType.multipleChoice {
                        Text("Select \(question.correctAnswers.count) options:")
                            .frame(width: 325, alignment: .leading)
                            .opacity(0.4)
                            .bold()
                    } else if question.questionType == QuestionType.singleChoice {
                        Text("Select one option:")
                            .frame(width: 325, alignment: .leading)
                            .opacity(0.4)
                            .bold()
                    }

                    QuestionBoxView(question: question, isTest: isTest, selectedAnswers: $selectedAnswers, isFocused: $isFocused, hintAction: { self.hintAction() })
                        
                    
                    Button {
                        withAnimation {
                            isFocused = false
                        }
                        
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
                    .padding(.top, 10)
                    .padding(.bottom, isFocused && numHintsDisplayed == 0 ? 400 : 30)
                    
                    
                    
                    EmptyView()
                    .id(0)

                    
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
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                .onChange(of: isFocused) {
                    if isFocused {
                        withAnimation {
                            value.scrollTo(0, anchor: .top)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            
            if showingQuestionAlert {
                QuestionAlertView(isShowing: $showingQuestionAlert, state: $questionAlertState)
            }
        }
    }
    
    func hintAction() {
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
    
    return QuestionView(question: QuestionModel(id: 0, hints: [HintModel(content: "Hint 1")], question: QuestionContentModel(content: "here is an example content $\\color{blue}5\\div6$", images: [ImageModel(url: "pandaPNG", height: 250, width: 300)]), options: ["option 1", "option 2", "option 3", "option 4"], questionType: .multipleChoice, correctAnswers: ["option 2", "option 3"], videos: ["noVideo"]), isTest: false, incrementIndex: { noFunc() }, exerciseResults: $exerciseResults)
        .background(Color.background3.ignoresSafeArea())
}
