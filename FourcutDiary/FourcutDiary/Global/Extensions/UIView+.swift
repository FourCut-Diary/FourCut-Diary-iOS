//
//  UIView+.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/3/24.
//

import UIKit

extension UIView {
	
	/// UIView 여러 개 인자로 받아서 한 번에 addView
	func addSubviews(_ views: UIView...) {
		views.forEach{ self.addSubview($0) }
	}
}
