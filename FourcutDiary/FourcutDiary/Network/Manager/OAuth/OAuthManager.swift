//
//  OAuthManager.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/3/24.
//

import Combine

protocol OAuthManager {
	func login(type: LoginType) -> AnyPublisher<String, Error>
}
