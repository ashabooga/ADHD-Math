import SwiftUI

struct QuestionBoxView: View {
    
    let question: QuestionModel
    @State var selectedAnswer = [""]
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                switch question.questionType {
                    
                case QuestionType.dropdown:
                    Picker("Pick One", selection: $selectedAnswer[0]) {
                        ForEach(question.options ?? [""], id: \.self) {
                            Text($0)
                        }
                    }
                    .contentShape(Rectangle()).gesture(DragGesture())
                    .pickerStyle(.wheel)
                    .frame(width: 300)
                    
                case QuestionType.text:
                    TextField("Answer Here", text: $selectedAnswer[0])
                        .contentShape(Rectangle()).gesture(DragGesture())
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 250)
                    
                case QuestionType.number:
                    TextField("", text: $selectedAnswer[0])
                        .contentShape(Rectangle()).gesture(DragGesture())
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                    
                default:
                    ForEach(question.options ?? [""], id: \.self) { option in
                        QuestionChoiceView(option: option, isSelected: false, questionType: question.questionType)
                            .frame(width: 300)
                            .contentShape(Rectangle()).gesture(DragGesture())
                    }
                }
                
                Button {
                    
                } label: {
                    Text("Submit")
                }

                
            }
            .padding(.vertical, 30)
            .background(
                RoundedRectangle(cornerRadius: 25)
//                    .shadow(radius: 10)
                    .foregroundStyle(Color("Background3Accent"))
                    .frame(width: 350)
            )
            
            HStack {
                
                Spacer()
                
                HelpButtonView()
                    .contentShape(Rectangle()).gesture(DragGesture())
                
            }
            .padding(.trailing, 10)
            .padding(.bottom, 300)
            
        }
        
    }
}

//#Preview {
//    QuestionBoxView(question: QuestionModel(questions:/* ["Check this hotdog out", "Didja know that my name is ben?"], answers: ["That's cool man"], hints: ["It's true, my name is ben"], hasBeenAsked: false, questionType: QuestionType.singleChoice, options: ["13", "15", "22"]))*/
//}
