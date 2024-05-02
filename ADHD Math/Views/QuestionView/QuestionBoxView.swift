import SwiftUI
import LaTeXSwiftUI

struct QuestionBoxView: View {
    
    let question: QuestionModel
    let isTest: Bool
    @Binding var selectedAnswers: [String]
    @State var inputtedAnswer: String = ""
    
    var hintAction: () -> Void
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                switch question.questionType {
                    
                case QuestionType.dropdown:
                    Picker("Pick One", selection: $selectedAnswers[0]) {
                        ForEach(question.options, id: \.self) {
                            Text($0)
                        }
                    }
                    .contentShape(Rectangle()).gesture(DragGesture())
                    .pickerStyle(.wheel)
                    .frame(width: 300)
                    
                case QuestionType.text:
                    TextField("Answer Here", text: $selectedAnswers[0])
                        .contentShape(Rectangle()).gesture(DragGesture())
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 250)
                    
                case QuestionType.number:
//                    let _ = print("number!")
                    TextField("", text: $inputtedAnswer)
                        .contentShape(Rectangle()).gesture(DragGesture())
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                        .multilineTextAlignment(.center)
                        .onChange(of: inputtedAnswer) {
                            selectedAnswers = [inputtedAnswer]
                        }
                    
                default:
                    ForEach(question.options, id: \.self) { option in
                        QuestionChoiceView(option: option, isSelected: false, selectedAnswers: $selectedAnswers, question: question)
                            .frame(width: 300)
                            .contentShape(Rectangle()).gesture(DragGesture())
                    }
                }
 
            }
            .padding(.vertical, 30)
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color("Background3Accent"))
                    .frame(width: 350)
            )
            .overlay(alignment: .topTrailing, content: {
                if !isTest {
                        
                    HelpButtonView(hintAction: { hintAction() }, question: question)
                        .padding(.top, -30)
                        .padding(.trailing, -30)
                        .contentShape(Rectangle()).gesture(DragGesture())
                }
            })
            
        }
        
    }
}

#Preview {
    let question: QuestionModel = QuestionModel(id: 0, hints: [HintModel(content: "Hint 1")], question: QuestionContentModel(content: "here is an example content $5\\div6$ \n[[image 1]]", images: [ImageModel(url: "noVideo", height: 100, width: 100)]), options: ["1", "2", "3"], questionType: .number, correctAnswers: ["option 2"], videos: ["noVideo"])
    @State var selectedAnswers: [String] = []
    
    func noFunc() {
        print("display hint")
    }
    
    return QuestionBoxView(question: question, isTest: false, selectedAnswers: $selectedAnswers, hintAction: { noFunc() })
}
