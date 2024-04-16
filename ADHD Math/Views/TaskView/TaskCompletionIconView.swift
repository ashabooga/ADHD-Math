//
//  TaskCompletionIconView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 1/28/24.
//

import Foundation
import SwiftUI

struct TaskCompletionIconView: View {
    var isCompleted : Bool
    
    var body: some View {
        
        Image(systemName: isCompleted ? "circle.hexagongrid.fill" : "circle.hexagongrid")
            .resizable()
            .frame(width: 45, height: 40)
            .foregroundStyle(isCompleted ? Color("CompletedTaskColor") : Color(.black))
    }
}

struct TaskCompletionIconView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionIconView(isCompleted: false)
    }
}
