//
//  AuthViewModel.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import Foundation
import Combine

protocol AuthViewModel: ViewModel where Input == AuthViewModelInput, Output == AuthViewModelOutput {}

struct AuthViewModelInput {
	let appleLoginButtonTap: PassthroughSubject<Void, Never>
	let kakaoLoginButtonTap: PassthroughSubject<Void, Never>
}

struct AuthViewModelOutput {
	let loginSuccess: AnyPublisher<String, Never>
}
