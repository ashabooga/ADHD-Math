import SwiftUI
import LaTeXSwiftUI

func viewForString(string: String, question: QuestionModel) -> some View {
    return CustomTextView(text: string, question: question)
}

struct CustomTextView: View {
    var text: String
    var question: QuestionModel

    var body: some View {
        let items: [String] = getItemsInString(text)
        
        HStack {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                if item.starts(with: "[[") {
                    
                    let image = getImageFromItem(text: text, item: item, question: question)
                    
                    image
                    
                } else {
                    LaTeX(item)
                }
            }
        }
    }
}

func getImageFromItem(text: String, item: String, question: QuestionModel) -> some View {
    
    let graphiePrefix: String = "[[https://cdn.kastatic.org/ka-perseus-graphie/"
    
    var imageURL: String = "noImage"
    var imageWidth: CGFloat = 200
    var imageHeight: CGFloat = 200
    
    if item.starts(with: graphiePrefix) {
        let trimmedItem = String(item.dropFirst(graphiePrefix.count).dropLast(6))
        let imageURL = trimmedItem
        
    } else if item.starts(with: "[[image") {
        
        if question.question.content == text {
            
        } else {
            
            let results = question.hints.filter { $0.content == text }
            
            if !results.isEmpty {
                let hint = results.first
                
//                let imageURL = hint?.images?.first?.url
                
            }
        }
    }
    
    let image = Image(imageURL).resizable().scaledToFit().frame(width: imageWidth, height: imageHeight)
    
    return image
}

func getItemsInString(_ string: String) -> [String] {
    
    let pattern = #"\[\[.*?\]\]"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return []
        }

        let matches = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))
        var items: [String] = []
        

        var currentIndex = string.startIndex
        for match in matches {
            if let range = Range(match.range, in: string) {

                let prefix = String(string[currentIndex..<range.lowerBound])
                items.append(prefix)

                let matchedSubstring = String(string[range])
                items.append(matchedSubstring)

                currentIndex = range.upperBound
            }
        }
        
        let remainingText = String(string[currentIndex...])
        items.append(remainingText)
        
        return items
}
