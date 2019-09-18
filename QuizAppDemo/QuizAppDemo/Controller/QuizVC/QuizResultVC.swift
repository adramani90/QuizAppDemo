
import UIKit

class QuizResultVC: UIViewController {
    
    private let TXT_TOTALQ = "Total Quetions: "
    private let TXT_TOTALNON_ATTEMPTED = "Non Attempted: "
    private let TXT_CORRECTANS = "Correct Answer: "
    private let TXT_INCORRECT = "In Correct Answer: "
    private let TXT_YOURANS = "Your Answer: "

    // MARK :- IBOutlet
    @IBOutlet weak var tblQuizResult: UITableView!{
        didSet{
            self.tblQuizResult.registerNib(withName: CellIdentifier.quizResultHeaderCell, identifier: CellIdentifier.quizResultHeaderCell)
            self.tblQuizResult.registerNib(withName: CellIdentifier.quizQuetionAnswerCell, identifier: CellIdentifier.quizQuetionAnswerCell)
            self.tblQuizResult.delegate = self
            self.tblQuizResult.dataSource = self
            self.tblQuizResult.tableFooterView = UIView.init(frame: .zero)
        }
    }
        
    
    // MARK :- View Cycle
    var arrQuetions:[Quetion] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    // MARK :- Functions
    private func setupInitInfo()
    {
        
    }
    // MARK :- Action Method
    
    @IBAction func btnRestartAppAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    
}

extension QuizResultVC:UITableViewDelegate,UITableViewDataSource{
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrQuetions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.quizQuetionAnswerCell, for: indexPath) as! QuizQuetionAnswerCell
        let data = self.arrQuetions[indexPath.row]
        cell.lblQuetions.text = data.question
        cell.lblGivenAnswer.text = TXT_YOURANS + ((data.isAttempt == 1) ? String(data.options[data.answered]) : TXT_TOTALNON_ATTEMPTED)
        if data.isAttempt == 0{
            cell.lblGivenAnswer.textColor =  UIColor.AppColor.colorBlue
        }else if (data.isAttempt == 1 && data.answered == data.correctAns){
            cell.lblGivenAnswer.textColor =  UIColor.AppColor.colorGreen
        } else {
            cell.lblGivenAnswer.textColor =  UIColor.AppColor.colorRed
        }
        cell.backgroundColor = UIColor.white
        cell.contentView.backgroundColor = UIColor.white
        cell.lblCorrectAnswer.text = TXT_CORRECTANS + String(data.options[data.correctAns])
        cell.lblCorrectAnswer.textColor = UIColor.AppColor.colorGreen

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let totalQ = self.arrQuetions.count
        let nonAttempted = (self.arrQuetions.filter({$0.isAttempt == 0})).count
        let correct = (self.arrQuetions.filter({$0.answered == $0.correctAns})).count
        let inCorrect = (self.arrQuetions.filter({$0.answered != $0.correctAns})).count
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.quizResultHeaderCell) as! QuizResultHeaderCell
        cell.lblTotalQuetions.text = TXT_TOTALQ + String(totalQ)
        cell.lblNonAttemtedQuetions.text = TXT_TOTALNON_ATTEMPTED + String(nonAttempted)
        cell.lblCorrectAnswer.text = TXT_CORRECTANS + String(correct)
        cell.lblInCorrectAnswer.text = TXT_INCORRECT + String(inCorrect)

        cell.lblTotalQuetions.textColor = UIColor.AppColor.colorBlack
        cell.lblNonAttemtedQuetions.textColor = UIColor.AppColor.colorBlue
        cell.lblCorrectAnswer.textColor = UIColor.AppColor.colorGreen
        cell.lblInCorrectAnswer.textColor = UIColor.AppColor.colorRed
        cell.backgroundColor = UIColor.AppColor.colorThemeLight
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
}
