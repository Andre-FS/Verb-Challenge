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
    @IBOutlet weak var offlineIndicator: OfflineIndicator!
    
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    private let layoutUpdater = HomeLayoutUpdater()
    weak private var navigationDelegate: CoordinatorNavigationDelegate?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: - Init
    
    init?(coder: NSCoder, viewModel: HomeViewModel, navigationDelegate: CoordinatorNavigationDelegate) {
        
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
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
        setupLayoutUpdater()
        
    }
    
    private func setupLayoutUpdater() {
        
        self.layoutUpdater.setupWith(collectionView: self.collectionView,
                                     activityIndicator: self.activityIndicator,
                                     offlineIndicator: self.offlineIndicator)
        
    }
    
    private func setupCollectionView() {
        
        self.collectionView.register(cellClass: PhotoCell.self)
        self.collectionView.indicatorStyle = .white
        
        let cellWidth = floor((self.view.frame.width - ((ItemsPerRow - 1) * CollectionInteritemSpacing)) / ItemsPerRow)
        self.collectionViewFlowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        self.collectionViewFlowLayout.minimumInteritemSpacing = CollectionInteritemSpacing
        self.collectionViewFlowLayout.minimumLineSpacing = CollectionLineSpacing
        
        setupPullToRefresh()
        setupInitialAnimation()
        
    }
    
    private func setupPullToRefresh() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "ActivityIndicatorColor")
        self.collectionView.refreshControl = refreshControl
        self.collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
        
    }
    
    private func setupInitialAnimation() {
        
        self.collectionView.rx.willDisplayCell
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.layoutUpdater.applyDisplayAnimationIfNeededTo(cell: $0.cell, at: $0.at)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    private func retryFromOfflineMode() {
        
        self.layoutUpdater.updateViewVisibility(for: .loading)
        self.layoutUpdater.updateOfflineIndicator(for: .loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewModel.triggerPhotoUpdate()
        }
        
    }
    
    
    // MARK: - Bindings
    
    private func setupBindings() {
        
        setupDataBinding()
        setupStatusBinding()
        setupCollectionViewTapBindings()
        setupOfflineIndicatorBindings()
        
    }
    
    private func setupDataBinding() {
        
        self.viewModel.homeData
            .bind(to: self.collectionView.rx
                .items(cellIdentifier: String(describing: PhotoCell.self), cellType: PhotoCell.self)) { _, element, cell in
                    
                    cell.setupWithContent(element)
                    cell.delegate = self
                    
        }
        .disposed(by: disposeBag)
        
    }
    
    private func setupStatusBinding() {
        
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
    
    private func setupCollectionViewTapBindings() {
        
        self.collectionView.rx.itemSelected
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                self?.navigateToPhoto(with: indexPath)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    private func setupOfflineIndicatorBindings() {
        
        self.offlineIndicator.actionButton.rx.tap
            .subscribe { [weak self] _ in
                self?.retryFromOfflineMode()
        }.disposed(by: self.disposeBag)
        
    }
    
    
    // MARK: - UI Updates
    
    private func updateLayout(for state: HomeDataState) {
        
        self.layoutUpdater.updateViewVisibility(for: state)
        self.layoutUpdater.updateOfflineIndicator(for: state)
        
    }
    
    
    // MARK: - Navigation Redirection
    
    private func navigateToPhoto(with indexPath: IndexPath) {
        self.navigationDelegate?.navigateToPhotoDetail(with: self.viewModel.rawPhotoData[indexPath.row], from: self)
    }
    
    private func showShareSheet(with indexPath: IndexPath) {
        self.navigationDelegate?.share(photo: self.viewModel.rawPhotoData[indexPath.row], from: self)
    }
    
}

extension HomeViewController: PhotoCellActionDelegate {
    
    // MARK: - PhotoCellActionDelegate
    
    func didTap(on cell: PhotoCell) {
        
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        
        self.navigateToPhoto(with: indexPath)
        
    }
    
    func didLongPress(on cell: PhotoCell) {
        
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        
        self.showShareSheet(with: indexPath)
        
    }
    
}
