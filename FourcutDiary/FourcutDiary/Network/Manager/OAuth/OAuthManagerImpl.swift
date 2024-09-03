//
//  OAuthManagerImpl.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/3/24.
//

import Combine

final class OAuthManagerImpl: OAuthManager {
	
	private let appleLoginManager: AppleLoginManager
//	private let kakaoLoginManager: KakaoLoginMan
	
	init(appleLoginManager: AppleLoginManager) {
		self.appleLoginManager = appleLoginManager
	}
	
	deinit {
		print("OAutManager deinit")
	}
	
	func login(type: LoginType) -> AnyPublisher<String, Error> {
		switch type {
		case .apple:
			return appleLoginManager.authorize().eraseToAnyPublisher()
		case .kakao:
			return appleLoginManager.authorize().eraseToAnyPublisher()
		}
	}
}
