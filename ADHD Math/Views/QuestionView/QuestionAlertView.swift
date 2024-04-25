//
//  QuestionAlertView.swift
//  ADHD Math
//
//  Created by Cuello-Wolffe, Ben on 25/04/2024.
//

import SwiftUI

public struct AlertState {
    let isCorrect: Bool
    let title: String
    let content: String
    
    static let noAlert = AlertState(isCorrect: false, title: "Error", content: "No Alert.")
    
    init(isCorrect: Bool, title: String, content: String) {
        self.isCorrect = isCorrect
        self.title = title
        self.content = content
    }
}

struct QuestionAlertView: View {
    
    @Binding var isShowing: Bool
    @Binding var state: AlertState
    @State private var offset: CGFloat = -1000
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.offWhite)
                .shadow(radius: 10)
                .frame(width: 350, height: 100)
            
            HStack {
                
                Image(systemName: state.isCorrect ? "checkmark.square.fill" : "xmark.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(state.isCorrect ? .green : .red)
                    .padding(.leading, 5)
                    .padding(.trailing, 10)
                
                Divider()
                    .frame(width: 1, height: 50)
                
                VStack {
                    Text(state.title)
                        .bold()
                    
                    Text(state.content)
                        .frame(maxWidth: 190)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
            }
            .padding(.trailing, 20)
            
        }
        .overlay {
            HStack {
                Spacer()
                
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.black)
                .padding(.trailing, 20)
                .padding(.bottom, 40)
            }
        }
        .offset(x: 0, y: offset)
        .onAppear {
            withAnimation(.spring) {
                offset = -300
            }
        }
        
        
    }
    
    
    func close() {
        withAnimation(.spring) {
            offset = -1000
            isShowing = false
        }
    }
}

#Preview {
    
    @State var isShowing: Bool = true
    @State var alertState: AlertState = AlertState(isCorrect: true, title: "Correct Answer!", content: "Click the 'Next' button to continue.")
    
    return QuestionAlertView(isShowing: $isShowing, state: $alertState)
}
