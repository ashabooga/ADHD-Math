//
//  ContentView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 12/10/23.
//

import SwiftUI

struct TaskView: View {
    @StateObject var lessonViewModel = LessonViewModel()
    
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
                                } else if item.type == LessonType.quiz {
                                    Text("working on it")
                                }
                            } label: {
                                TaskRowView(lesson: item)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }.padding(.top, 10)
                }
            }
            .environmentObject(lessonViewModel)
            .navigationTitle("Lessons")
            .overlay (
                Text("1 of 10")
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
    }
}
