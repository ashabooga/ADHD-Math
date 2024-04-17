//
//  BreakView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/15/24.
//

import SwiftUI

struct BreakView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color(.background5)
                    .ignoresSafeArea()
                
                VStack {
                    
                    
                    Group {
                        Text("Quick! Find something ")
                        + Text("shaped like a circle ")
                            .foregroundStyle(Color("CompletedTaskColor").opacity(90))
                        + Text("in the room!")
                    }
                    .fontWeight(.semibold)
                    .font(.title2)
                    .frame(width: 300)
                    .padding(.vertical, 30)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .shadow(radius: 10)
                            .foregroundStyle(Color("OffWhite"))
                            .frame(width: 325)
                    )
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Text("Back to task")
                                .bold()
                                .font(.title3)
                                .foregroundStyle(Color.black)

                            TaskCompletionIconView(isCompleted: false)
                        }
                        .padding(20)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.background3)
                        }
                    }

                }
                .padding(.top, 30)
                .padding(.bottom, 15)
            }
        }
        
        
    }
}

#Preview {
    BreakView()
}
