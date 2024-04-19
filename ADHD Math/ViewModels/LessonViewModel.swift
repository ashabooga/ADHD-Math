

import Foundation

class LessonViewModel: ObservableObject {
    
    @Published var lessons = [LessonModel]()
    
    var fileName = "lessons"
    var lessonsKey = "lessons"
    
    init() {
        fetchFromUserDefaults()
    }
    
    func fetchFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: lessonsKey) {
            do {
                let decodedData = try JSONDecoder().decode([LessonModel].self, from: savedData)
                self.lessons = decodedData
            } catch {
                print("Failed to fetch lessons from UserDefaults")
            }
        } else {
            fetchFromJson()
        }
    }
    
    func fetchFromJson() {
        guard let url = Bundle.main.url(forResource: self.fileName, withExtension: "json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            do {
                if let jsonData = data {
                    let result = try JSONDecoder().decode([LessonModel].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.lessons = result
                    }
                } else {
                    print("No data")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func saveLessons() {
        do {
            let encodedData = try JSONEncoder().encode(lessons)
            UserDefaults.standard.set(encodedData, forKey: lessonsKey)
        } catch {
            print("Failed to save lessons to UserDefaults")
        }
    }
    
    func completeLesson(lesson: LessonModel) {
        if let index = lessons.firstIndex(where: { $0.id == lesson.id }) {
            lessons[index] = lesson.completeLesson()
        }
    }
    
    func getVideoFromFileName(fileName: String) -> LessonModel {
        if let video = lessons.first(where: { $0.fileTitle == fileName }) {
            if video.type == LessonType.video {
                return video
            }
        }
        
        return LessonModel.noVideo
    }
    
    func ensureVideo(lesson: LessonModel) -> LessonModel {
        if lesson.type != LessonType.video {
            return LessonModel.noVideo
        }
        
        return lesson
    }
     
}

