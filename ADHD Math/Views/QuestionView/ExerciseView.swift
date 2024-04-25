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
                        .contentShape(Rectangle()).gesture(DragGesture())
                        .tag(0)
                    ForEach(Array(questions.enumerated()), id: \.element.id) { (index, question) in
                        QuestionView(question: question, isTest: lesson.type == LessonType.test, incrementIndex: self.incrementTabIndex, exerciseResults: $exerciseResults)
                            .contentShape(Rectangle()).gesture(DragGesture())
                            .tag(index + 1)
                    }
                    ExerciseEndView(incrementTabIndexFunction: { self.incrementTabIndex() }, exerciseResults: $exerciseResults)
                        .contentShape(Rectangle()).gesture(DragGesture())
                        .tag(questions.count + 1)
                }
                .ignoresSafeArea()
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .navigationTitle(lesson.displayTitle)
            .navigationBarTitleDisplayMode(.inline)
        }

    }
    
    func incrementTabIndex() {
        withAnimation {
            let numQuestions = lesson.type == LessonType.quiz ? 3 : 7
            
            if selectedTab == numQuestions + 1 {
                if (Double(exerciseResults.filter{ $0 }.count) / Double(exerciseResults.count)) > 0.6 {
                    lessonViewModel.completeLesson(lesson: lesson)
                    
                    print(exerciseResults)
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
