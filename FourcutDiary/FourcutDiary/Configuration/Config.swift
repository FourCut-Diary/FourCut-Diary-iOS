//
//  Config.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/5/24.
//

import Foundation

enum Config {
	
	enum Keys {
		enum Plist {
			static let kakaoAppKey = "KAKAO_APP_KEY"
		}
	}
	
	private static let infoDictionay: [String: Any] = {
		guard let dict = Bundle.main.infoDictionary else {
			fatalError("🚨plist cannot found🚨")
		}
		return dict
	}()
}

extension Config {
	static let kakaoAppKey: String = {
		guard let key = Config.infoDictionay[Config.Keys.Plist.kakaoAppKey] as? String else {
			fatalError("\(Config.Keys.Plist.kakaoAppKey) is not set in plist for this configuration")
		}
		return key
	}()
}
