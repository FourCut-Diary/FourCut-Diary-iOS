//
//  ViewController.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import UIKit

import AuthenticationServices
import Combine
import SnapKit

final class AuthViewController: UIViewController {
	
	private let kakaoLoginButtonTap = PassthroughSubject<Void, Never>()
	private let appleLoginButtonTap = PassthroughSubject<Void, Never>()
	private let viewModel: any AuthViewModel
	private var cancelBag = Set<AnyCancellable>()
	
	private let appleLoginButton: UIButton = {
		let button = UIButton()
		button.setTitle("애플 로그인", for: .normal)
		button.backgroundColor = .black
		return button
	}()
	
	init(viewModel: some AuthViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		layout()
		bind()
		bindInput()
	}
}

extension AuthViewController {
	private func layout() {
		view.addSubview(appleLoginButton)
		
		appleLoginButton.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.directionalHorizontalEdges.equalToSuperview().inset(10)
		}
	}
}

extension AuthViewController {
	private func bind() {
		let input = AuthViewModelInput(
			appleLoginButtonTap: appleLoginButtonTap,
			kakaoLoginButtonTap: kakaoLoginButtonTap)
		let output = viewModel.transform(input: input)
		
		// output 관리
		output.loginSuccess
			.sink { error in
				print(error)
			}
			.store(in: &cancelBag)
	}
	
	private func bindInput() {
		appleLoginButton.tapPublisher
			.sink { [weak self] _ in
				self?.appleLoginButtonTap.send(())
				print("send")
			}
			.store(in: &cancelBag)
	}
}
