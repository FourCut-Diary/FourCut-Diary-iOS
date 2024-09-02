//
//  LoginType.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/3/24.
//

import Foundation

enum LoginType {
	case kakao
	case apple
	
	var raw: String {
		return "\(self)".uppercased()
	}
}
