//
//  PracticeView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/4/24.
//

import SwiftUI

struct PracticeView: View {
    
    @State private var selectedTab: Int = 0
    @State private var showingBreakSheet = false
    @State private var showingHintSheet = false
    
    @Environment(\.dismiss) var dismiss
    
    let lesson: LessonModel
    @StateObject var exerciseViewModel: ExerciseViewModel
    
    init(lesson: LessonModel) {
        self.lesson = lesson
        self._exerciseViewModel = StateObject(wrappedValue: ExerciseViewModel(fileName: lesson.fileTitle))
    }
    
    var body: some View {
        
        let questions = exerciseViewModel.fetchQuestions(num: 3)
        
        NavigationStack {
            ZStack {

                Color(.background3)
                    .ignoresSafeArea()

                TabView(selection: $selectedTab) {
                    
                    ForEach(Array(questions.enumerated()), id: \.element.id) { (index, question) in
                        QuestionView(question: question)
                            .contentShape(Rectangle()).gesture(DragGesture())
                            .tag(index)
                    }
                    
                }
                .ignoresSafeArea()
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
            }
            .navigationTitle(lesson.displayTitle)
            .navigationBarTitleDisplayMode(.inline)
            
        }

    }
}


#Preview {
    PracticeView(lesson: LessonModel(id: 0, displayTitle: "Practice", fileTitle: "example_lesson", type: .quiz, isCompleted: false))
}
