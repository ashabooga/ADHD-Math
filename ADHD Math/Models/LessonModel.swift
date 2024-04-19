import Foundation

public enum LessonType: String, Codable {
    case video = "video"
    case quiz = "quiz"
    case test = "test"
    case unknown
}

struct LessonModel: Identifiable, Decodable, Encodable {
    var id: Int
    var displayTitle: String
    var fileTitle: String
    var type: LessonType
    var isCompleted: Bool = false
    
    init(id: Int, displayTitle: String, fileTitle: String, type: LessonType, isCompleted: Bool) {
        self.id = id
        self.displayTitle = displayTitle
        self.fileTitle = fileTitle
        self.type = type
        self.isCompleted = isCompleted
    }
    
    func completeLesson() -> LessonModel {
        return LessonModel(id: id, displayTitle: displayTitle, fileTitle: fileTitle, type: type, isCompleted: true)
    }
    
    static let noVideo: LessonModel = LessonModel(id: -1, displayTitle: "No Video", fileTitle: "noVideo", type: .video, isCompleted: true)
    static let noQuiz: LessonModel = LessonModel(id: -2, displayTitle: "No Quiz", fileTitle: "noQuiz", type: .quiz, isCompleted: true)
    static let noTest: LessonModel = LessonModel(id: -3, displayTitle: "No Test", fileTitle: "noTest", type: .test, isCompleted: true)
}
