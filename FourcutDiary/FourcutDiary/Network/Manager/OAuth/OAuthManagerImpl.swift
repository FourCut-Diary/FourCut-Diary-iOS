//
//  OAuthManagerImpl.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/3/24.
//

import Combine

final class OAuthManagerImpl: OAuthManager {
	
	private let appleLoginManager: AuthService
	private let kakaoLoginManager: AuthService
	
	init(appleLoginManager: AuthService, kakaoLoginManager: AuthService) {
		self.appleLoginManager = appleLoginManager
		self.kakaoLoginManager = kakaoLoginManager
	}
	
	deinit {
		print("OAutManager deinit")
	}
	
	func login(type: LoginType) -> AnyPublisher<String, Error> {
		switch type {
		case .apple:
			return appleLoginManager.authorize().eraseToAnyPublisher()
		case .kakao:
			return kakaoLoginManager.authorize().eraseToAnyPublisher()
		}
	}
}
