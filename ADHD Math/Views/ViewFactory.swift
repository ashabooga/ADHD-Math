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
        
        VStack {
            
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
    let imagePrefix: String = "[[image "
    
    var imageURL: String = "noImage"
    var imageWidth: CGFloat = 200
    var imageHeight: CGFloat = 200
    
    if item.starts(with: graphiePrefix) {
        let trimmedItem = String(item.dropFirst(graphiePrefix.count).dropLast(6))
        imageURL = trimmedItem
        
    } else if item.starts(with: imagePrefix) {
        
        var image: ImageModel = ImageModel.noImage
        
        if question.question.content == text {
            
            let trimmedInt = Int(item.dropFirst(imagePrefix.count).dropLast(2)) ?? 0
            
            image = question.question.images?[trimmedInt - 1] ?? ImageModel.noImage
            
        } else {
            
            let results = question.hints.filter { $0.content == text }
            
            if !results.isEmpty {
                let hint = results.first
                
                let trimmedInt = Int(item.dropFirst(imagePrefix.count).dropLast(2)) ?? -1
                
                image = hint?.images?[trimmedInt - 1] ?? ImageModel.noImage
                
            }
        }
        
        imageURL = image.url
        imageWidth = image.width
        imageHeight = image.height
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
