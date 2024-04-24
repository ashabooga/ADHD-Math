//
//  PracticeView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/4/24.
//

import SwiftUI

struct ExerciseView: View {
    
    @State private var selectedTab: Int = 0
    @State private var showingBreakSheet = false
    @State private var showingHintSheet = false
    
    @Environment(\.dismiss) var dismiss
    
    let lesson: LessonModel
    @EnvironmentObject var lessonViewModel: LessonViewModel
    @StateObject var exerciseViewModel: ExerciseViewModel
    @State var exerciseResults: [Bool] = []
    
    @State var hasAnswered: Bool = false
    
    init(lesson: LessonModel) {
        self.lesson = lesson
        self._exerciseViewModel = StateObject(wrappedValue: ExerciseViewModel(fileName: lesson.fileTitle))
    }
    
    var body: some View {
        
        let questions = exerciseViewModel.fetchQuestions(num: lesson.type == LessonType.quiz ? 3 : 7)
        
        NavigationStack {
            ZStack {

                Color(.background3)
                    .ignoresSafeArea()

                TabView(selection: $selectedTab) {
                    ExerciseStartView(incrementTabIndexFunction: { self.incrementTabIndex() })
                        .tag(0)
                    ForEach(Array(questions.enumerated()), id: \.element.id) { (index, question) in
                        QuestionView(question: question, isTest: lesson.type == LessonType.test, manageAnswer: self.manageAnswer)
                            .contentShape(Rectangle()).gesture(DragGesture())
                            .tag(index + 1)
                    }
                    ExerciseEndView(incrementTabIndexFunction: { self.incrementTabIndex() }, exerciseResults: $exerciseResults)
                        .tag(questions.count + 1)
                }
                .ignoresSafeArea()
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
            }
            .navigationTitle(lesson.displayTitle)
            .navigationBarTitleDisplayMode(.inline)
        }

    }
    
    func manageAnswer(selectedAnswers: [String], question: QuestionModel) {
        
        var error: AnswerError = AnswerError.unknown
        
        if selectedAnswers.count == question.correctAnswers.count {
            if selectedAnswers.sorted() == question.correctAnswers.sorted() {
                
                exerciseResults.append(!hasAnswered)
                incrementTabIndex()
                hasAnswered = false
                return
            } else {
                hasAnswered = true
                error = AnswerError.incorrectAnswers
            }
        } else {
            hasAnswered = true
            error = AnswerError.incorrectNumChoices
        }
        
        print(error)
        
//        alert(error, isPresented: Binding<Bool>) {
//
//        }
        
    }
    
    func incrementTabIndex() {
        withAnimation {
            let numQuestions = lesson.type == LessonType.quiz ? 3 : 7
            
            if selectedTab == numQuestions + 1 {
                if (Double(exerciseResults.filter{ $0 }.count) / Double(exerciseResults.count)) > 0.6 {
                    lessonViewModel.completeLesson(lesson: lesson)
                }
                dismiss()
            } else {
                selectedTab += 1
            }
        }
    }
}


#Preview {
    ExerciseView(lesson: LessonModel(id: 0, displayTitle: "Practice", fileTitle: "example_lesson", type: .quiz, isCompleted: false))
        .environmentObject(LessonViewModel())
}
