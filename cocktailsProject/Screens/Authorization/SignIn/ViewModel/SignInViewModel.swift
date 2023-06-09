//
//  SignInViewModel.swift
//  cocktailsProject
//
//  Created by Eldar on 24/2/23.
//

final class SignInViewModel {
    private var authManager: AuthManager
    
    init () { self.authManager = AuthManager.shared }
    
    public var showAlert: ((
        String,
        String,
        (() -> Void)?
    ) -> Void)?
    public var goToMainPage: (() -> Void)?
    
    public func getSMSCode(phoneNumber: String?) {
        guard
            let phoneNumber = phoneNumber, !phoneNumber.isEmpty,
            Int(phoneNumber) != nil
        else {
            showAlert?(
                "Error!",
                "The field for phone number must be filled and contain only digits!",
                nil
            )
            return
        }
        
        authManager.tryToSendSMSCode(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success(): ()
            case .failure(let error):
                self?.showAlert?(
                    "Error",
                    error.localizedDescription,
                    nil
                )
            }
        }
    }
    
    public func verifyCodeAndTryToSignIn(smsCode: String?) {
        guard
            let smsCode = smsCode, !smsCode.isEmpty
        else {
            showAlert?(
                "Error!",
                "The sms-code field must be filled!",
                nil
            )
            return
        }
        
        authManager.tryToSignIn(smsCode: smsCode) { [weak self] result in
            switch result {
            case .success():
                self?.showAlert?(
                    "Success",
                    "Succesfully signed up with phone number. Getting you to the main page.",
                    self?.goToMainPage
                )

            case .failure(let error):
                self?.showAlert?(
                    "Error",
                    error.localizedDescription,
                    nil
                )
            }
        }
    }
}
