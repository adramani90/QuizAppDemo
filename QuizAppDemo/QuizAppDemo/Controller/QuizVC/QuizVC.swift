

import UIKit

class QuizVC: UIViewController {
    // MARK :- IBOutlet
    private let TTL_SUBMIT_TEXT = "Submit"
    private let TTL_NEXT_TEXT = "Next"
    private let ALERT_SUBMIT = "Are you sure you want to submit?"

    @IBOutlet weak var clvQuiz: UICollectionView!{
        didSet{
        self.clvQuiz.registerNib(withName: CellIdentifier.quizCell, identifier: CellIdentifier.quizCell)
        self.clvQuiz.delegate = self
        self.clvQuiz.dataSource = self
        }
    }
    @IBOutlet weak var viewBtnPrevious: UIView!
    @IBOutlet weak var viewBtnNext: UIView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    // MARK :- Variable
    
    let arrQuetions = Quetion.getAllQuestions()
    var currentIndexPath = IndexPath.init(row: 0, section: 0)
    // MARK :- View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupInitInfo()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK :- Functions
    private func setupInitInfo()
    {
        self.viewBtnPrevious.isHidden = true
        [self.viewBtnNext,self.viewBtnPrevious].forEach { (vw) in
            vw?.backgroundColor = UIColor.AppColor.colorThemeDark
            vw?.makeCornerRedius(with: 3)
        }
    }
    
    
    // MARK :- Action Method
    @IBAction func btnPreviousQuetionAction(_ sender: Any) {
        if self.currentIndexPath.row > 0{
            let indexPath = IndexPath.init(row: self.currentIndexPath.row - 1, section: 0)
            self.currentIndexPath = indexPath
            DispatchQueue.main.async {
                self.clvQuiz.scrollToItem(at: indexPath, at:.centeredHorizontally, animated: true)
                self.view.layoutIfNeeded()
                self.clvQuiz.layoutIfNeeded()
            }
        }
        self.setSubmitButtonTitle()
    }
    
    @IBAction func btnNextQuetionAction(_ sender: Any) {
        if self.currentIndexPath.row < (self.arrQuetions.count - 1){
            let indexPath = IndexPath.init(row: self.currentIndexPath.row + 1, section: 0)
            print(indexPath)
            self.currentIndexPath = indexPath
            DispatchQueue.main.async {
                self.clvQuiz.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.view.layoutIfNeeded()
                self.clvQuiz.layoutIfNeeded()
            }
        }
      self.setSubmitButtonTitle()
    }
    
    private func setSubmitButtonTitle()
    {
        if self.btnNext.titleLabel?.text == TTL_SUBMIT_TEXT{
            self.navigateToQuizResult()
        }
        if (self.arrQuetions.count - 1) == self.currentIndexPath.row{
            self.btnNext.setTitle(TTL_SUBMIT_TEXT, for: .normal)
            self.btnNext.setTitle(TTL_SUBMIT_TEXT, for: .selected)
        }else{
            self.btnNext.setTitle(TTL_NEXT_TEXT, for: .normal)
            self.btnNext.setTitle(TTL_NEXT_TEXT, for: .selected)
        }
        self.viewBtnPrevious.isHidden = self.currentIndexPath.row == 0 ? true : false
    }
    
    
    // MARK :- Navigation
    private func navigateToQuizResult(){
        self.showAlert(title: "Quiz", message: ALERT_SUBMIT, firstBtnName: "Yes", firstBtnHandler: { (action) in
            let vc = UIStoryboard.main.instantiateViewController(withIdentifier: VCIdentifier.quizResultVC) as! QuizResultVC
            vc.arrQuetions = self.arrQuetions
            self.navigationController?.pushViewController(vc, animated: true)
        }, secondBtnName: "No") { (action) in
            
        }
    }
}

extension QuizVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrQuetions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = CellIdentifier.quizCell + String(indexPath.row)
        collectionView.registerNib(withName: CellIdentifier.quizCell, identifier: cellIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! QuizCell
        
        self.configurationQuizCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.width
        let h = collectionView.frame.height
        return CGSize.init(width: w, height: h)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private func configurationQuizCell(cell:QuizCell,indexPath:IndexPath)
    {
        let data = self.arrQuetions[indexPath.row]
        cell.lblQuetion.text = data.question
        
        cell.btnAnsOne.setTitle(data.options[0], for: .normal)
        cell.btnAnsOne.setTitle(data.options[0], for: .selected)
        
        cell.btnAnsTwo.setTitle(data.options[1], for: .normal)
        cell.btnAnsTwo.setTitle(data.options[1], for: .selected)
        
        cell.btnAnsThree.setTitle(data.options[2], for: .normal)
        cell.btnAnsThree.setTitle(data.options[2], for: .selected)
        
        cell.btnAnsFour.setTitle(data.options[3], for: .normal)
        cell.btnAnsFour.setTitle(data.options[3], for: .selected)
        

        [cell.btnAnsOne,cell.btnAnsTwo,cell.btnAnsThree,cell.btnAnsFour].enumerated().forEach { (ind,btn) in
            btn?.tag = ind
        }
        cell.btnAnsOne.addTarget(self, action: #selector(self.btnOptionOneAction(_:)), for: .touchUpInside)
        cell.btnAnsTwo.addTarget(self, action: #selector(self.btnOptionOneAction(_:)), for: .touchUpInside)
        cell.btnAnsThree.addTarget(self, action: #selector(self.btnOptionOneAction(_:)), for: .touchUpInside)
        cell.btnAnsFour.addTarget(self, action: #selector(self.btnOptionOneAction(_:)), for: .touchUpInside)


    }
    
    @objc func btnOptionOneAction(_ sender: UIButton){
        guard let indexpath = self.clvQuiz.indexPathFor(view: sender) else {
            return
        }
        let data = self.arrQuetions[indexpath.row]
        data.answered = sender.tag

        if let cell = self.clvQuiz.cellForItem(at: indexpath) as? QuizCell{
            [cell.btnAnsOne,cell.btnAnsTwo,cell.btnAnsThree,cell.btnAnsFour].forEach { (btn) in
                let colorTitle = btn == sender ? .white : UIColor.AppColor.colorBlue
                let colorBG = btn == sender ? UIColor.AppColor.colorThemeDark : .white
                btn?.backgroundColor = colorBG
                btn?.setTitleColor(colorTitle, for: .normal)
                btn?.setTitleColor(colorTitle, for: .selected)
                data.isAttempt = 1
            }
        }
    }
    
}
