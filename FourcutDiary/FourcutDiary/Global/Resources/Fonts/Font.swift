//
//  UIFont+.swift
//  FourcutDiary
//
//  Created by 강윤서 on 9/10/24.
//

import UIKit

enum Font {
	enum SUIT: String {
		case Bold
		case Medium
		case Regular
		case SemiBold
	}
	
	static let heading01: UIFont = { .suit(.Bold, size: 22) }()
	static let heading02: UIFont = { .suit(.SemiBold, size: 14) }()
	
	static let title01: UIFont = { .suit(.Bold, size: 18) }()
	static let title02: UIFont = { .suit(.SemiBold, size: 18) }()
	static let title03: UIFont = { .suit(.SemiBold, size: 16) }()
	static let title04: UIFont = { .suit(.Medium, size: 14) }()
	
	static let body01: UIFont = { .suit(.Bold, size: 14) }()
	static let body02: UIFont = { .suit(.Medium, size: 14) }()
	static let body03: UIFont = { .suit(.Regular, size: 14) }()
	static let body04: UIFont = { .suit(.Regular, size: 12) }()
	static let body05: UIFont = { .suit(.Regular, size: 10) }()
	
	static let label01: UIFont = { .suit(.Regular, size: 12) }()
	static let label02: UIFont = { .suit(.Bold, size: 11) }()
	static let label03: UIFont = { .suit(.Regular, size: 11) }()
}
