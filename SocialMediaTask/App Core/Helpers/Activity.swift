import NVActivityIndicatorView

public protocol ActivitayActionsDelegate: class
{
    static func startAnimating(withBackground: Bool)
    static func stopAnimating()
}

final class Activity: NSObject, ActivitayActionsDelegate
{
    // MARK: Properties
    
    private static let restorationIdentifier: String = "NVActivityIndicator"
    private static var currentView: UIView?
    {
        get
        {
            guard let topView = UIApplication.getTopViewController()?.view else { return nil }
            return topView
        }
    }
    
    private static var enabled = true
    
    // MARK: Methods
    
    static func stopWorking(_ status: Bool)
    {
        enabled = !status
    }
    
    static func startAnimating(withBackground: Bool = false)
    {
        guard enabled else { return }
        
        Activity.stopAnimating()
        
        DispatchQueue.main.async {
            guard let currentView = currentView else { return }
            let loaderView = DesignableView()
            loaderView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loaderView.cornerRadius = 10
            
            if withBackground
            {
                loaderView.backgroundColor = .white
            }
            
            let activity = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width / 2 ,
                                                                 y: UIScreen.main.bounds.height / 2,
                                                                 width: 50,
                                                                 height: 50),
                                                   type: .ballClipRotatePulse,
                                                   color: UIColor.blue,
                                                   padding: 0.0)
            
            activity.center = loaderView.center
            loaderView.center = currentView.center
            loaderView.restorationIdentifier = restorationIdentifier
            loaderView.addSubview(activity)
            currentView.addSubview(loaderView)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                currentView.bringSubviewToFront(loaderView)
            }
            
            activity.startAnimating()
        }
    }
    
    static func stopAnimating()
    {
        DispatchQueue.main.async {
            guard let currentView = currentView else { return }
            for item in currentView.subviews where item.restorationIdentifier == restorationIdentifier
            {
                item.removeFromSuperview()
            }
        }
    }
}
