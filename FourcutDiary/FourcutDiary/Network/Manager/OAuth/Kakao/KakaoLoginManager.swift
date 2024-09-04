//
//  KakaoLoginManager.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/27/24.
//

import Combine
import KakaoSDKUser
import KakaoSDKAuth

final class KakaoLoginManager: AuthService {
	func authorize() -> AnyPublisher<String, Error> {
		return login().eraseToAnyPublisher()
	}
	
	private var cancelBag = Set<AnyCancellable>()
	private var authorizationControllerDelegate: ASAuthorizationControllerCombineDelegate?
	
	func login() -> Future<String, Error> {
		if UserApi.isKakaoTalkLoginAvailable() {
			return self.loginKakaoWithApp()
		} else {
			return self.loginKakaoWithWeb()
		}
	}
	
	private func loginKakaoWithApp() -> Future<String, Error> {
		return Future<String, Error> { promise in
			UserApi.shared.loginWithKakaoTalk { oAuthToken, error in
				if let error = error {
					promise(.failure(error))
					return
				}
				guard let token = oAuthToken?.accessToken else {
					return
				}
				
				promise(.success(token))
			}
		}
	}
	
	private func loginKakaoWithWeb() -> Future<String, Error> {
		return Future<String, Error> { promise in
			UserApi.shared.loginWithKakaoAccount { OAuthToken, error in
				if let error = error {
					promise(.failure(error))
					return
				}
				
				guard let token = OAuthToken?.accessToken else {
					return
				}
				
				promise(.success(token))
			}
		}
	}
}
