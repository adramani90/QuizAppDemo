

import UIKit

class QuizCell: UICollectionViewCell {    
    // MARK :- IBOutlet
    @IBOutlet weak var imgQuiz: UIImageView!
    @IBOutlet weak var lblQuetion: UILabel!
    @IBOutlet weak var btnAnsOne: UIButton!
    @IBOutlet weak var btnAnsTwo: UIButton!
    @IBOutlet weak var btnAnsThree: UIButton!
    @IBOutlet weak var btnAnsFour: UIButton!
    
    // MARK :- Variable
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        [btnAnsOne,btnAnsTwo,btnAnsThree,btnAnsFour].forEach { (btn) in
            btn?.makeBorder(with: 1, borderColor: UIColor.AppColor.colorThemeDark, cornerRedius: 5)
        }
    }

}
