//
//  HelpButtonView.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 2/28/24.
//

import SwiftUI

struct HelpButtonView: View {
    
    @State var showingExpandedButton = false
    @State private var showingBreakSheet = false
    @State private var showingHintSheet = false
    
    var question: QuestionModel
    
    var body: some View {
        HStack {
            
            Button {
                withAnimation(.spring) {
                    self.showingExpandedButton.toggle()
                }
            } label: {
                
                withAnimation(.spring) {
                    Image(systemName: "circle.hexagongrid.fill")
                        .resizable()
                        .frame(width: 38, height: 35)
                        .rotationEffect(.degrees(showingExpandedButton ? -180 : 0))
                        .foregroundStyle(Color.black)
                }
            }

            if showingExpandedButton {
                
                Button {
                    showingHintSheet = true
//                    showingExpandedButton = false
                } label: {
                    Text("hint")
                        .questionText(color: .black)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color("Background3"))
                                .frame(width: 75, height: 50)
                        )
//                        .shadow(radius: 2)
                }
                .contentShape(Rectangle()).gesture(DragGesture())
                .sheet(isPresented: $showingHintSheet, content: {
                    HintView(fileTitle: question.videos.first ?? LessonModel.noVideo.fileTitle)
                        .presentationDetents([.fraction(0.7), .large])
                        .presentationDragIndicator(.visible)
                })
                .padding(.leading, 35)
                .padding(.trailing, 40)
                
                Button {
                    showingBreakSheet = true
//                    showingExpandedButton = false
                } label: {
                    Text("take a break")
                        .questionText(color: .black)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color("Background5"))
                                .frame(width: 140, height: 50)
                        )
//                        .shadow(radius: 1)
                }
                .contentShape(Rectangle()).gesture(DragGesture())
                .sheet(isPresented: $showingBreakSheet, content: {
                    BreakView()
                        .presentationDetents([.fraction(0.4)])
                        .presentationDragIndicator(.visible)
                })
                .padding(.trailing, 15)

                
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color("OffWhite"))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        )
    }
}

#Preview {
    let question: QuestionModel = QuestionModel(id: 0, question: QuestionContentModel(content: "here is an example content $5\\div6$ \n[[image 1]]", images: [ImageModel(url: "test", height: 100, width: 100)]), options: ["option 1 $7\\times2=\\text{?}$", "option 2", "option 3", "option 4"], correctAnswers: ["option 2"], hints: [HintModel(content: "Hint 1")], questionType: .multipleChoice, videos: ["test"])
    
    return HelpButtonView(question: question)
}
