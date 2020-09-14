import NVActivityIndicatorView

extension UIViewController
{
    typealias AlertCompletionHandler = () -> Void

    func showAlert(title: String = "", message: String, addCancelAction: Bool = true, okayHandler: AlertCompletionHandler? = nil,_ cancelHandler: AlertCompletionHandler? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (alertAction) in
            if let okayHandler = okayHandler {
                okayHandler()
            }
        }))
        
        if (addCancelAction){
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { alert in
                if let okayHandler = cancelHandler {
                    okayHandler()
                }
            }))
        }

        DispatchQueue.main.async(execute: { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        })
    }
    
    func loadActivity(_ loading: Bool)
    {
        loading ? Activity.startAnimating() : Activity.stopAnimating()
    }
}
