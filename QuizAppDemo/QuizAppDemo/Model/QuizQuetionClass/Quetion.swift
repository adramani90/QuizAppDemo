

import Foundation



class Quetion{

    let kCorrectAns = "correctAns"
    let kAnswered = "answered"
    let kQuestion = "question"
    let kOptions = "options"
    let kIsAttempt = "isAttempt"

    
    var correctAns : Int
    var answered : Int
    var options : [String] = []
    var question : String
    var isAttempt : Int


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init?(dictionary: [String:Any]){
        if dictionary.isEmpty{
            return nil
        }
        self.correctAns = dictionary[kCorrectAns] as? Int ?? 0
        self.answered = dictionary[kAnswered] as? Int ?? 0
        self.question = dictionary[kQuestion] as? String ?? ""
        self.options = dictionary[kOptions] as? [String] ?? []
        self.isAttempt = dictionary[kIsAttempt] as? Int ?? 0
    }

    class func getAllQuestions() -> [Quetion]
    {
        if let path = Bundle.main.path(forResource: "Question", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let result = jsonResult as? [[String:Any]] {
                    return result.compactMap(Quetion.init)
                }
            } catch {
                // handle error
                print(error.localizedDescription)
                return []
            }
        }
        return []
    }
}
