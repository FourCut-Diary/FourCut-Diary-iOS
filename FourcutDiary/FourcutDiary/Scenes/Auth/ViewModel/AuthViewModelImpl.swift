//
//  ViewModelImpl.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import Combine
import AuthenticationServices

final class AuthViewModelImpl: AuthViewModel {
	
	private let appleLoginManager: AppleLoginManager
	private var cancelBag = Set<AnyCancellable>()
	
	init(appleLoginManager: AppleLoginManager) {
		self.appleLoginManager = appleLoginManager
	}
	
	func transform(input: Input) -> Output {
		let loginSuccess = input.appleLoginButtonTap
			.flatMap { () -> AnyPublisher<String, Never> in
				self.loginAPI()
					.catch { error in
						return Just("Error: \(error.localizedDescription)")
							.eraseToAnyPublisher()
					}
					.eraseToAnyPublisher()
			}
			.eraseToAnyPublisher()
		return Output(loginSuccess: loginSuccess)
	}
}

/// 추후 파일 분리
extension AuthViewModelImpl {
	private func loginAPI() -> Future<String, Error> {
		return Future<String, Error> { [self] promise in
			self.appleLoginManager.handleAuthorizationAppleIDButtonPress()
				.sink { error in
					print("\(error)")
				} receiveValue: { authorization in
					guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
						  let authCode = credential.authorizationCode
					else { return }
					let authCodeString = String(data: authCode, encoding: .utf8)!
					print(authCodeString)
					promise(.success(authCodeString))
				}
				.store(in: &self.cancelBag)
		}
	}
}
