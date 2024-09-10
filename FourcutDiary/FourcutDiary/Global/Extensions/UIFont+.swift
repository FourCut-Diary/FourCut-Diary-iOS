//
//  UIFont+.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/10/24.
//

import UIKit

extension UIFont {
	static func suit(_ type: Font.SUIT, size: CGFloat) -> UIFont {
		guard let font = UIFont(name: "SUIT-\(type.rawValue)", size: size) else {
			return UIFont()
		}
		return font
	}
}
