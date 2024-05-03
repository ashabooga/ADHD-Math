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
        var isBold: Bool = false
        
        
        VStack {
            
                
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                
                if item.contains("[[") {
                    
                    getImageFromItem(text: text, item: item, question: question)
                    
                } else {
                    if item == "" || item == " " {
                        EmptyView()
                    } else if item == "**" {
                        let _ = isBold = true
                    } else if item == "%%" {
                        let _ = isBold = false
                    } else if item.contains("$") {
                        if isBold {
                            LaTeX(item)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .padding(.top)
                        } else {
                            LaTeX(item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .padding(.top)
                        }
                    } else {
                        if isBold {
                            Text(item)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .padding(.top)
                        } else {
                            Text(item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .padding(.top)
                        }
                    }
                }
                
            }
        
            
        }
        .padding(.horizontal, 20)
    }
}

func getImageFromItem(text: String, item: String, question: QuestionModel) -> some View {
    
    let graphiePrefix: String = "[[https://cdn.kastatic.org/ka-perseus-graphie/"
    let imagePrefix: String = "[[image "
    var item = item
    
    var imageURLs: [String] = ["noImage"]
    
    if item.contains(graphiePrefix) {
        item = item.replacingOccurrences(of: " ", with: "")
    }
    
    

    if item.contains(graphiePrefix) {
        let trimmedItem = item.replacingOccurrences(of: graphiePrefix, with: "").replacingOccurrences(of: ".svg]]", with: "")
        let trimmedItems = trimmedItem.components(separatedBy: .whitespaces).filter({ $0 != "" && $0 != "\n" })
        print(trimmedItems)
        imageURLs = trimmedItems
        
    } else if item.starts(with: imagePrefix) {
        
        var image: ImageModel = ImageModel.noImage
        
        if question.question.content == text {
            
            let trimmedInt = Int(item.dropFirst(imagePrefix.count).dropLast(2)) ?? 0
            
            image = question.question.images?[trimmedInt] ?? ImageModel.noImage
            
        } else {
            
            let results = question.hints.filter { $0.content == text }
            
            if !results.isEmpty {
                let hint = results.first
                
                let trimmedInt = Int(item.dropFirst(imagePrefix.count).dropLast(2)) ?? -1
                
                image = hint?.images?[trimmedInt] ?? ImageModel.noImage
                
            }
        }
        
        imageURLs = [image.url]
        imageURLs = [String(imageURLs[0].dropFirst(graphiePrefix.count - 2).dropLast(4))]
    }
    
    var content: AnyView = AnyView(EmptyView())
    
    if imageURLs.count == 1 {
        content = AnyView(Image(uiImage: UIImage(named: imageURLs[0]) ?? UIImage(named: "noImage")!).resizable().scaledToFit())
    } else {
        content = AnyView(VStack {
            ForEach(Array(imageURLs.enumerated()), id: \.offset) { index, url in
                Image(uiImage: UIImage(named: url) ?? UIImage(named: "noImage")!).resizable().scaledToFit()
            }}.frame(maxWidth: 225))
    }
    
    return content
}

func getItemsInString(_ string: String) -> [String] {
    
    let pattern = #"\[\[(\w+\s\d+)\]\]"#
        
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
    
    var finalItems: [String] = []
    for item in items {
        if item.contains("**") {
            let splitItems = item.components(separatedBy: "**")
            var isOpener: Bool = true
            
            for (index, item) in splitItems.enumerated() {
                finalItems.append(item)
                if index < splitItems.count - 1 {
                    
                    if isOpener {
                        finalItems.append("**")
                    } else {
                        finalItems.append("%%")
                    }
                    
                    isOpener.toggle()
                }
            }
        } else {
            finalItems.append(item)
        }
    }
    
    print(finalItems)
    
    return finalItems
}
