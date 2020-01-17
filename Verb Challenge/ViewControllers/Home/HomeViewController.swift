//
//  HomeViewController.swift
//  Verb Challenge
//
//  Created on 17/01/2020.
//  Copyright © 2020 André Silva. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let ItemsPerRow: CGFloat = 3
private let CollectionInteritemSpacing: CGFloat = 1
private let CollectionLineSpacing: CGFloat = 1

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
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
        
        self.viewModel.triggerPhotoUpdate()
        
    }
    
    
    // MARK: - Internal
    
    @objc
    func refreshControlDidPull() {
        self.viewModel.triggerPhotoUpdate()
    }

    
    // MARK: - Private
    
    private func setupUI() {
        
        self.title = NSLocalizedString("Home.Title", comment: "")
        
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        
        self.collectionView.register(cellClass: PhotoCell.self)
        
        let cellWidth = floor((self.view.frame.width - ((ItemsPerRow - 1) * CollectionInteritemSpacing)) / ItemsPerRow)
        self.collectionViewFlowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        self.collectionViewFlowLayout.minimumInteritemSpacing = CollectionInteritemSpacing
        self.collectionViewFlowLayout.minimumLineSpacing = CollectionLineSpacing
        
        setupPullToRefresh()
        
    }
    
    private func setupPullToRefresh() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "ActivityIndicatorColor")
        self.collectionView.refreshControl = refreshControl
        self.collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
        
    }
    
    private func setupBindings() {
        
        setupDataBinding()
        setupStatusBinding()
        setupCollectionViewTapBindings()
        
    }
    
    private func setupStatusBinding() {
        
        self.viewModel.homeData
            .bind(to: self.collectionView.rx
                .items(cellIdentifier: String(describing: PhotoCell.self),
                       cellType: PhotoCell.self)) { _, element, cell in
                        cell.setupWithContent(element)
        }
        .disposed(by: disposeBag)
        
        
    }
    
    private func setupDataBinding() {
        
        self.viewModel.dataStatus
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                
                guard let self = self else {
                    return
                }
                
                self.updateLayout(for: status)
                
            })
            .disposed(by: self.disposeBag)
        
    }
    
    private func updateLayout(for status: HomeDataState) {
        
        UIView.animate(withDuration: 0.3) {
            
            switch status {
            case .success:
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1
                self.collectionView.refreshControl?.endRefreshing()
                
            case .loading:
                if self.collectionView.refreshControl?.isRefreshing != true {
                    self.activityIndicator.startAnimating()
                    self.collectionView.alpha = 0
                }
                
            case .error:
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 0
                self.collectionView.refreshControl?.endRefreshing()
            }
            
        }
        
    }
    
    private func setupCollectionViewTapBindings() {
        
        Observable.zip(self.collectionView.rx.itemSelected,
                       self.collectionView.rx.modelSelected(PhotoCellViewModel.self))
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, model) in
                self?.redirectToPhotoDetail(with: model)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    private func redirectToPhotoDetail(with model: PhotoCellViewModel) {
        
        guard let viewController = PhotoDetailViewController.instantiateFromStoryboard(creator: {
            return PhotoDetailViewController(coder: $0, viewModel: PhotoDetailViewModel(photoModel: model))
        }) else {
            return
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
