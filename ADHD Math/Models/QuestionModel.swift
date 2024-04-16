
import Foundation
import SwiftUI

public enum QuestionType: String, Codable {
    case number = "numeric_input"
    case dropdown = "dropdown"
    case text = "text_input"
    case multipleChoice = "multiple_choice"
    case singleChoice = "single_choice"
    case unknown
}

public enum AnswerError: Error {
    case incorrectType
    case empty
}

struct QuestionModel: Identifiable, Decodable {
    var id: Int
    var question: QuestionContentModel
    var options: [String]
    var correctAnswers: [String]
    var hints: [HintModel]
    var questionType: QuestionType
    var videos: [String]
}

struct QuestionContentModel: Decodable {
    var content: String
    var images: [ImageModel]?
}

struct HintModel: Identifiable, Decodable {
    var id = UUID()
    var content: String
    var images: [ImageModel]?
}

struct ImageModel: Identifiable, Decodable {
    var id = UUID()
    var url: String
    var height: Int
    var width: Int
    
    static let noImage = ImageModel(id: UUID(), url: "noImage", height: 100, width: 100)
}
