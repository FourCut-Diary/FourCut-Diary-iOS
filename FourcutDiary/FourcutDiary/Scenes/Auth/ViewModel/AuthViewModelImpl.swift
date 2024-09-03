//
//  ViewModelImpl.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import Combine
import AuthenticationServices

final class AuthViewModelImpl: AuthViewModel {
	
	private let authManager: OAuthManager
	private var cancelBag = Set<AnyCancellable>()
	
	init(authManager: OAuthManager) {
		self.authManager = authManager
	}
	
	func transform(input: Input) -> Output {
		let appleLogin = input.appleLoginButtonTap
			.map{ LoginType.apple }
		let kakaoLogin = input.kakaoLoginButtonTap
			.map { LoginType.kakao }
		
		let loginSuccess = appleLogin
			.merge(with: kakaoLogin)
			.flatMap { loginType -> AnyPublisher<String, Never> in
				self.authManager.login(type: loginType)
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
