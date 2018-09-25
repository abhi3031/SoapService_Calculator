
import UIKit

class ViewController: UIViewController,CalculatorDelegate{

    var  respounce:String = ""
    @IBOutlet weak var inputA: UITextField!
    
    @IBOutlet weak var inputB: UITextField!
    
    @IBOutlet weak var answer: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   

    
    @IBAction func addbtn(_ sender: Any) {
    
        let obj = CalculatorTask();
        obj.delegate = self;
        obj.add(InputA: inputA.text! , InputB: inputB.text!);
       
        
        
        
    }
    func getAnswer(str: String) {
        DispatchQueue.main.async {
            self.answer.text = str;
        }
        
    }
   
}

