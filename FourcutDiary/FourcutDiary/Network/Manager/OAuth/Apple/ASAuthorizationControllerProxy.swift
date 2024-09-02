//
//  ASAuthorizationControllerProxy.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/20/24.
//

import AuthenticationServices
import Combine

class ASAuthorizationControllerCombineDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
	var presentationWindow: UIWindow = UIWindow()
	
	lazy var didComplete = PassthroughSubject<ASAuthorization, Never>()
		
	// MARK: ASAuthorizationControllerDelegate
	func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
		didComplete.send(authorization)
		didComplete.send(completion: .finished)
	}

	func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
		didComplete.send(completion: .finished)
	}

	// MARK: ASAuthorizationControllerPresentationContextProviding
	func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
		return presentationWindow
	}
	
	deinit {
		self.didComplete.send(completion: .finished)
	}
}

