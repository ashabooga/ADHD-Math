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
                        ForEach(question.options, id: \.self) {
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
                    ForEach(question.options, id: \.self) { option in
                        QuestionChoiceView(option: option, isSelected: false, question: question)
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
            .padding(.bottom, 350)
            
        }
        
    }
}

#Preview {
    let question: QuestionModel = QuestionModel(id: 0, question: QuestionContentModel(content: "here is an example content $5\\div6$ \n[[image 1]]", images: [ImageModel(url: "test", height: 100, width: 100)]), options: ["option 1 $7\\times2=\\text{?}$", "option 2", "option 3", "option 4"], correctAnswers: ["option 2"], hints: [HintModel(content: "Hint 1")], questionType: .multipleChoice, videos: ["test"])
    
    return QuestionBoxView(question: question)
}
