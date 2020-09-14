import UIKit

extension UITextField
{
    func checkMaxLength(maxLength: Int)
    {
        if let text = self.text, text.count > maxLength
        {
            self.deleteBackward()
        }
    }
}
