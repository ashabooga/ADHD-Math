import Foundation
import SwiftUI

class ExerciseViewModel: ObservableObject {
    
    @Published var items = [QuestionModel]()
    var fileName: String
        
    init(fileName: String) {
        self.fileName = fileName
        fetchData()
    }
    
    func fetchData() {
        guard let url = Bundle.main.url(forResource: self.fileName, withExtension: "json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([QuestionModel].self, from: data)
                    DispatchQueue.main.async {
                        self.items = result
                    }
                } else {
                    print("No data")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchQuestions(num: Int) -> [QuestionModel] {
        
        guard items.count >= num else {
            return []
        }

        var questions = Array(items.shuffled().prefix(num))
        
        for index in 0..<questions.count {
            questions[index] = questions[index].shuffleOptions()
        }
        
        return questions
    }
}
