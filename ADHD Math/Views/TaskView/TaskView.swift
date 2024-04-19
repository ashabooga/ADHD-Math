//
//  ContentView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 12/10/23.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var lessonViewModel: LessonViewModel
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(.background1)
                    .ignoresSafeArea()
                
                if lessonViewModel.lessons.isEmpty {
                    NoLessonsView()
                } else {
                    ScrollView(.vertical, showsIndicators: true) {
     
                        ForEach(lessonViewModel.lessons) { item in
                            
                            NavigationLink {
                                
                                if item.type == LessonType.video {
                                    LearnView(lesson: item)
                                        .environmentObject(self.lessonViewModel)
                                } else {
                                    ExerciseView(lesson: item)
                                }
                            } label: {
                                TaskRowView(lesson: item)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }.padding(.top, 10)
                }
            }
            .navigationTitle("Lessons")
            .overlay (
                Text("\(lessonViewModel.lessons.filter( { $0.isCompleted } ).count) of \(lessonViewModel.lessons.count)")
                    .titleText(color: Color.white)
                    .padding(.trailing, 20)
                    .offset(x: 0, y: -45)
            , alignment: .topTrailing)
        }
    }
}

#Preview {
    NavigationStack{
        TaskView()
            .environmentObject(LessonViewModel())
    }
}
