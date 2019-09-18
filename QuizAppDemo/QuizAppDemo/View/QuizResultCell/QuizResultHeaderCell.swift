
import UIKit

class QuizResultHeaderCell: UITableViewCell {

    @IBOutlet weak var lblTotalQuetions: UILabel!
    @IBOutlet weak var lblNonAttemtedQuetions: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    @IBOutlet weak var lblInCorrectAnswer: UILabel!
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
