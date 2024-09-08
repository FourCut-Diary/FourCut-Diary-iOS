//
//  ASAuthorizationControllerCombineDelegate.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/20/24.
//

import AuthenticationServices
import Combine

final class ASAuthorizationControllerCombineDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
	
	var presentationWindow: UIWindow = UIWindow()
	var didComplete = PassthroughSubject<ASAuthorization, Error>()
		
	// MARK: ASAuthorizationControllerDelegate
	func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
		didComplete.send(authorization)
		didComplete.send(completion: .finished)
	}

	func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
		didComplete.send(completion: .failure(error))
	}

	// MARK: ASAuthorizationControllerPresentationContextProviding
	func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
		return presentationWindow
	}
	
	deinit {
		self.didComplete.send(completion: .finished)
	}
}

