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
        
            
            
        HStack {
            VStack {
                Text(lesson.displayTitle)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(Color.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(getLessonTypeAsString(lesson: lesson))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.leading)
            
            
            
            Spacer()
            Divider()
                .frame(width: 1, height: 75)
            TaskCompletionIconView(isCompleted: lesson.isCompleted)
                .padding(.leading)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(lesson.isCompleted ? Color("CompletedViewColor") : Color(.white))
        }

    }
    
    func getLessonTypeAsString(lesson: LessonModel) -> String {
        var output: String = ""
        
        switch lesson.type {
        case LessonType.quiz:
            output = "Practice"
        case LessonType.test:
            output = "Test"
        case LessonType.video:
            output = "Video"
        case LessonType.unknown:
            output = "Unknown"
        }
        
        return output
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let lesson1: LessonModel = LessonModel(id: 0, displayTitle: "Relating division to multiplication", fileTitle: "", type: LessonType.quiz, isCompleted: true)
        
        TaskRowView(lesson: lesson1)
    }
}
