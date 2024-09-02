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
	
	override init() {
		super.init()
	}
	
	/// clinck apple login button(create controller to request)
	func handleAuthorizationAppleIDButtonPress() -> AnyPublisher<ASAuthorization, Never> {
		let appleIDProvider = ASAuthorizationAppleIDProvider()
		let request = appleIDProvider.createRequest()
		request.requestedScopes = [.fullName, .email]
		
		let authorizationController = ASAuthorizationController(authorizationRequests: [request])
		let combineDelegate = ASAuthorizationControllerCombineDelegate()
		authorizationController.delegate = combineDelegate
		authorizationController.presentationContextProvider = combineDelegate
		authorizationController.performRequests()
		
		return combineDelegate.didComplete
			.eraseToAnyPublisher()
	}
}
