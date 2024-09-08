//
//  AuthService.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/3/24.
//

import Combine

protocol AuthService {
	func authorize() -> AnyPublisher<String, Error>
}
