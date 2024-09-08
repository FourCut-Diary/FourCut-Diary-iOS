//
//  AppleLoginManager.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import AuthenticationServices
import Combine

final class AppleLoginManager: AuthService {
	
	private var cancelBag = Set<AnyCancellable>()
	private var authorizationControllerDelegate: ASAuthorizationControllerCombineDelegate?
	
	func authorize() -> AnyPublisher<String, Error> {
		return self.login().eraseToAnyPublisher()
	}
	
	private func login() -> Future<String, Error> {
		return Future<String, Error> { [self] promise in
			self.handleAuthorizationAppleIDButtonPress()
				.sink { error in
					print("\(error)")
				} receiveValue: { authorization in
					guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
						  let authCode = credential.authorizationCode
					else { return }
					let authCodeString = String(data: authCode, encoding: .utf8)!
					promise(.success(authCodeString))
				}
				.store(in: &self.cancelBag)
		}
	}
	
	/// clinck apple login button(create controller to request)
	private func handleAuthorizationAppleIDButtonPress() -> AnyPublisher<ASAuthorization, Error> {
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
