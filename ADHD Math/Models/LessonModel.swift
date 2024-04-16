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
}
