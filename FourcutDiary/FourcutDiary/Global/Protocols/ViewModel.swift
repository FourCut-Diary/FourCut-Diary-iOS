//
//  ViewModel.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import Foundation

protocol ViewModel where Self: AnyObject {
	associatedtype Input
	associatedtype Output
	
	func transform(input: Input) -> Output
}
