//
//  TaskRowView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 12/12/23.
//

import SwiftUI

struct TaskRowView: View {
    let lesson: LessonModel
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .foregroundStyle(lesson.isCompleted ? Color("CompletedViewColor") : Color(.white))
            
            HStack {
                Text(lesson.displayTitle)
                    .bold()
                    .foregroundStyle(Color.black)
                Spacer()
                TaskCompletionIconView(isCompleted: lesson.isCompleted)
            }
            .padding(.horizontal, 40)
            .font(.title)
            
        }
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let lesson1: LessonModel = LessonModel(id: 0, displayTitle: "Example Lesson", fileTitle: "", type: LessonType.quiz, isCompleted: false)
        
        TaskRowView(lesson: lesson1)
    }
}
