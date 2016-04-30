
import UIKit

class WebViewViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var url : String!
    var titleString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString(titleString,size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        self.view.backgroundColor = UIColor.blackColor()
        goButton.layer.cornerRadius = 17.5
        urlTextField.text = url
        
        urlTextField.delegate = self
        webView.delegate = self
         loadAddress()
    }

    func loadAddress(){
        let url=urlTextField.text
        let requestURL = NSURL(string: url!);
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
    }
    
    @IBAction func backButtonAction(sender: UIBarButtonItem) {
        webView.goBack()
    }

    @IBAction func nextButtonAction(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func refreshButtonAction(sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func stopLoadingAction(sender: UIBarButtonItem) {
        webView.stopLoading()
        activityIndicator.stopAnimating()

    }
    
    @IBAction func goButtonAction(sender: UIButton) {
        urlTextField.resignFirstResponder()
        loadAddress()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    override func viewDidDisappear(animated: Bool) {
        activityIndicator.stopAnimating()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        urlTextField.resignFirstResponder()
        loadAddress()
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
 
}
