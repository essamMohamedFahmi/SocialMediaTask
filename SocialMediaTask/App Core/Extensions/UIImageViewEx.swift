import Kingfisher

extension UIImageView
{
    func addBlurEffect(_ blurStyle: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.center = self.center
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

// MARK: Kingfisher

extension UIImageView
{
    convenience init(assetName: String, scale: UIView.ContentMode = .scaleAspectFit)
    {
        self.init(image: UIImage(named: assetName))
        contentMode = scale
    }
    
    func uploadImage(from imageURL: String?)
    {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
        
        let image = #imageLiteral(resourceName: "004-picture")
        self.kf.setImage(with: url, placeholder: image)
    }
}

