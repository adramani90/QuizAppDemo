

import UIKit

class StartQuizVC: UIViewController {

    // MARK :- IBOutlet
    
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    
    // MARK :- Variable
    
    
    
    // MARK :- View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addGradiantView(direction: .vertical)
    
    }

    
    // MARK :- Functions
    
    
    // MARK :- Action Method
    @IBAction func btnStartQuizAction(_ sender: Any) {
        self.navigateToQuizVC()
    }
    
    
    
    // MARK :- Navigation
    private func navigateToQuizVC(){
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: VCIdentifier.quizVC) as! QuizVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
