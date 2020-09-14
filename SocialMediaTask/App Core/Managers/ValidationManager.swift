//
//  ValidationManager.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

extension UITextField
{
    func validatedText(validationType: ValidatorType) throws -> String {
        
        switch validationType
        {
        case .name:
            return try ValidationManger.validateUsername(username: self)
        case .email:
            return try ValidationManger.validateEmail(emailtext: self)
        case .phone:
            return try ValidationManger.validatePhoneNumberwithoutLength(phonetxtf: self)
        case .password:
            return try ValidationManger.validatePassword(password: self)
        case .passwordMatches(let confirmFiled):
            return try ValidationManger.validatePassword(password: self, confirmpassword: confirmFiled)
        case .age:
            return try ValidationManger.validateBirthDate(birthDateTextFiled: self)
        case .required(let fieldKey):
            return try ValidationManger.validateRequired(textField: self, key: fieldKey)
        case .invalidId :
            return try ValidationManger.validateId(textField: self)
        }
    }
    
    func shake()
    {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 5
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x + 6, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x - 6, y: center.y))
        layer.add(animation, forKey: "position")
    }
    
    func clear() {
        self.text = ""
    }

}

enum ValidatorType {
    case email
    case name
    case phone
    case password
    case passwordMatches(confirmFiled: UITextField)
    case age
    case invalidId
    case required(fieldKey: String) // ex: name is required, email is required and so..
}

final class ValidationManger: NSObject {

    private override init() {}
    
    static func validateId(textField: UITextField) throws -> String {
        guard textField.hasText else {
            textField.shake()
            throw ValidationErorr.invalidId
        }
        guard textField.text!.count <= 10 else {
            throw ValidationErorr.invalidId
        }
        return textField.text!
    }
    
    static func validateRequired(textField: UITextField, key: String) throws -> String {
        guard textField.hasText else {
            textField.shake()
            throw ValidationErorr.requiredField(key: key)
        }
        return textField.text!
    }
    
    static func validateUsername(username: UITextField) throws -> String {
        
        guard username.hasText, let name = username.text else {
             throw ValidationErorr.emptyUserName
        }
        
        guard username.text!.count >= 3 else {
            throw ValidationErorr.shortUserName
        }
        guard username.text!.count < 18 else {
            throw ValidationErorr.invalidUserName
        }

        return name
    }
    
    static func validatePhoneNumber(phonetxtf: UITextField, length: Int ) throws -> String {
       
        guard phonetxtf.hasText, let phone = phonetxtf.text, phone.isValidPhoneLength(length: length) else {
            throw ValidationErorr.invalidPhoneNum
        }
        return phone
    }
    
    static func validatePhoneNumberwithoutLength(phonetxtf: UITextField ) throws -> String {
      
        guard phonetxtf.hasText else {
            throw ValidationErorr.invalidPhoneNum
        }
        guard let phone = phonetxtf.text, phone.isValidPhoneLength else {
            throw ValidationErorr.phoneLength
        }
        return phone
    }
    static func validatePassword(password: UITextField) throws -> String {
       
        guard password.hasText else {
            password.shake()
            throw ValidationErorr.emptypassword
        }
        guard let pass = password.text, pass.count > 3 else {
            throw ValidationErorr.passwordCount
        }
        return pass
    }
    
    static func validateEmail(emailtext: UITextField) throws -> String {
      
        guard emailtext.hasText else {
            emailtext.shake()
            throw ValidationErorr.emailEmpty
        }
        guard let email = emailtext.text, email.isValidEmail else {
            emailtext.shake()
            throw ValidationErorr.invalidEmail
        }
        return email
    }
    
    static func validatePassword(password: UITextField, confirmpassword: UITextField) throws -> String {
       
        guard password.hasText, confirmpassword.hasText else {
            password.shake()
            throw ValidationErorr.emptypassword
        }
        guard let pass = password.text, let confirm = confirmpassword.text , pass == confirm  else {
            confirmpassword.shake()
            throw ValidationErorr.passwordMatch
        }
        guard pass.count > 3 else {
            password.shake()
            throw ValidationErorr.passwordCount
        }
        return pass
    }
    
    static func validateBirthDate(birthDateTextFiled: UITextField, greaterThan age: Int = 18) throws -> String {
      
        guard birthDateTextFiled.hasText else {
            birthDateTextFiled.shake()
            throw ValidationErorr.emptyText
        }
        guard let isvalidBirthdate = birthDateTextFiled.text, isvalidBirthdate.isBirthDateGreaterThan(age) else {
            birthDateTextFiled.shake()
            throw ValidationErorr.invalidAge
        }
        return isvalidBirthdate
    }
    
    static func showError(_ error: ValidationErorr) {
        NotifiyMessage.shared.toast(toastMessage:error.localizedDescription)
    }
}

enum ValidationErorr: Error, LocalizedError {
    
    case emptyUserName
    case shortUserName
    case longUserName
    case invalidUserName
    case invalidEmail
    case emailEmpty
    case passwordCount
    case passwordMatch
    case emptypassword
    case emptyText
    case invalidAge
    case phoneLength
    case invalidPhoneNum
    case requiredField(key: String)
    case invalidId

    var localizedDescription: String {
        switch self {
        
        case .emptyUserName:
            return "ادخل اسم مستخدم صالح"
        case .shortUserName:
            return "Name must contain more than three characters".localized
        case .longUserName:
            return "Name shoud not conain more than 18 characters".localized
        case .invalidUserName:
            return "Invalid name, name should not contain whitespaces, numbers or special characters".localized
        case .emailEmpty:
            return "البريد الالكتروني مطلوب"
        case .invalidEmail:
            return "Wrong Email format".localized
        case .emptypassword:
            return "Password is required!".localized
        case .passwordCount:
            return "Password is too short".localized
        case .passwordMatch:
            return "Password not matches".localized
        case .invalidPhoneNum:
            return "Check phone format".localized
        case .emptyText:
            return "Empty field, check inputs!".localized
        case .invalidAge:
            return "Age is under 18".localized
        case .phoneLength:
            return "Check Phone length or format".localized
        case .requiredField(let key):
            return "حقل مطلوب" + key.localized
        case .invalidId:
            return "رقم الهوية يحب ان لا يزيد عن ١٠ ارقام".localized
        }
    }
}
