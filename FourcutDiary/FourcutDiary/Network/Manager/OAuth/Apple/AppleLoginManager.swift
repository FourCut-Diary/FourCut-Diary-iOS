//
//  AppleLoginManager.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import AuthenticationServices
import Combine

final class AppleLoginManager: NSObject {
	
	private var cancelBag = Set<AnyCancellable>()
	private var authorizationControllerDelegate: ASAuthorizationControllerCombineDelegate?
	
	override init() {
		super.init()
	}
	
	/// clinck apple login button(create controller to request)
	func handleAuthorizationAppleIDButtonPress() -> AnyPublisher<ASAuthorization, Error> {
		let appleIDProvider = ASAuthorizationAppleIDProvider()
		let request = appleIDProvider.createRequest()
		request.requestedScopes = [.fullName, .email]
		
		let authorizationController = ASAuthorizationController(authorizationRequests: [request])
		let delegate = ASAuthorizationControllerCombineDelegate()
		
		self.authorizationControllerDelegate = delegate
		authorizationController.delegate = authorizationControllerDelegate
		authorizationController.presentationContextProvider = authorizationControllerDelegate
		authorizationController.performRequests()
		
		return delegate.didComplete
			.eraseToAnyPublisher()
	}
}
