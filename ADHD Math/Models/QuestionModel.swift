
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

public enum AnswerError: String {
    case incorrectNumChoices = "Incorrect number of Choices!"
    case incorrectAnswers = "Incorrect answer!"
    case unknown = "Unknown error with question answer."
}

struct QuestionModel: Identifiable, Decodable {
    var id: Int
    var hints: [HintModel]
    var question: QuestionContentModel
    var options: [String]
    var questionType: QuestionType
    var correctAnswers: [String]
    var videos: [String]
    
    init(id: Int, hints: [HintModel], question: QuestionContentModel, options: [String], questionType: QuestionType, correctAnswers: [String], videos: [String]) {
        self.id = id
        self.hints = hints
        self.question = question
        self.options = options
        self.questionType = questionType
        self.correctAnswers = correctAnswers
        self.videos = videos
    }
    
    
    func shuffleOptions() -> QuestionModel {
        return QuestionModel(id: id, hints: hints, question: question, options: options.shuffled(), questionType: questionType, correctAnswers: correctAnswers, videos: videos)
    }
}

struct QuestionContentModel: Decodable {
    var content: String
    var images: [ImageModel]?
}

struct HintModel: Decodable {
    var content: String
    var images: [ImageModel]?
}

struct ImageModel: Decodable {
    var url: String
    var height: CGFloat
    var width: CGFloat
    
    static let noImage = ImageModel(url: "noImage", height: 100.0, width: 100.0)
}
