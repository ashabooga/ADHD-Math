import Foundation

struct VideoModel: Decodable, Encodable, Identifiable {
    var id: Int
    var displayTitle: String
    var fileTitle: String
    var isCompleted: Bool = false
    
    static let noVideo = VideoModel(id: -1, displayTitle: "No Video", fileTitle: "no_video", isCompleted: false)
    
    init(id: Int, displayTitle: String, fileTitle: String, isCompleted: Bool) {
        self.id = id
        self.displayTitle = displayTitle
        self.fileTitle = fileTitle
        self.isCompleted = isCompleted
    }
}

