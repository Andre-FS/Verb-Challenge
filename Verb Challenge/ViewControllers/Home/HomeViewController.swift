//
//  HomeViewController.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    // MARK: - Properties
    
    let viewModel: HomeViewModel
    let disposeBag = DisposeBag()
    
    
    // MARK: - Init

    init?(coder: NSCoder, viewModel: HomeViewModel) {
        
        self.viewModel = viewModel
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("HomeViewController must be initialized with a viewModel.")
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        self.title = NSLocalizedString("Home.Title", comment: "")
    }
    
    private func setupBindings() {
        
        self.viewModel.dataStatus
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                
                switch $0 {
                case .success:
                    self?.statusLabel.text = "Success"
                case .loading:
                    self?.statusLabel.text = "Loading..."
                case .error:
                    self?.statusLabel.text = "Error"
                }
                
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.homeData
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { photos in
                
        })
        .disposed(by: self.disposeBag)
        
    }

    
    // MARK: - Actions
    
    @IBAction func updateButtonDidTap(_ sender: Any) {
        self.viewModel.triggerPhotoUpdate()
    }
    
}
