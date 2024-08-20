//
//  ViewModelImpl.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import Combine

final class AuthViewModelImpl: AuthViewModel {
	
	private let appleLoginManager: AppleLoginManager
	private var cancelBag = Set<AnyCancellable>()
	
	func transform(input: Input) -> Output {
		// 비즈니스 로직
	}
}
