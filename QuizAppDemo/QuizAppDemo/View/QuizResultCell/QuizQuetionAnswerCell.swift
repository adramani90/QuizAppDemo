
import UIKit

class QuizQuetionAnswerCell: UITableViewCell {

    @IBOutlet weak var lblQuetions: UILabel!
    @IBOutlet weak var lblGivenAnswer: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
