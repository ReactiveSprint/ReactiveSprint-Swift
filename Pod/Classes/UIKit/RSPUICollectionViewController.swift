//
//  RSPUICollectionViewController.swift
//  Pods
//
//  Created by Ahmad Baraka on 3/21/16.
//  Copyright © 2016 ReactiveSprint. All rights reserved.
//

import UIKit
import ReactiveCocoa

/// UICollectionViewController that implements ArrayViewControllerType.
public class RSPUICollectionViewController: UICollectionViewController, ArrayViewControllerType
{
    /// ViewModel which will be used as context for this "View."
    ///
    /// This property is expected to be set only once with a non-nil value.
    public var viewModel: ViewModelType! {
        didSet {
            precondition(oldValue == nil)
            bindViewModel(viewModel)
        }
    }
    
    @IBOutlet public var loadingView: LoadingViewType?
    
    public var arrayView: UICollectionView! {
        return collectionView
    }
    
    public var arrayViewModel: CocoaArrayViewModelType {
        return viewModel as! CocoaArrayViewModelType
    }
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        bindLoading(viewModel)
        bindCount(arrayViewModel)
    }
    
    public func bindViewModel(viewModel: ViewModelType)
    {
        _bindViewModel(viewModel, viewController: self)
    }
    
    public func bindActive(viewModel: ViewModelType)
    {
        _bindActive(viewModel, viewController: self)
    }
    
    public func bindTitle(viewModel: ViewModelType)
    {
        _bindTitle(viewModel, viewController: self)
    }
    
    public func bindLoading(viewModel: ViewModelType)
    {
        _bindLoading(viewModel, viewController: self)
    }
    
    public func presentLoading(loading: Bool)
    {
        if let loadingView = self.loadingView
        {
            loadingView.loading = loading
        }
    }
    
    public func bindErrors(viewModel: ViewModelType)
    {
        _bindErrors(viewModel, viewController: self)
    }
    
    public func presentError(error: ViewModelErrorType)
    {
        _presentError(error, viewController: self)
    }
    
    public func bindCount(arrayViewModel: CocoaArrayViewModelType)
    {
        _bindCount(arrayViewModel, viewController: self)
    }
    
    public func reloadData()
    {
        arrayView.reloadData()
    }
}

/// UICollectionViewController subclass where `arrayViewModel` supports fetching and refreshing.
public class RSPUIFetchedCollectionViewController: RSPUICollectionViewController, FetchedArrayViewControllerType
{
    @IBOutlet public var refreshView: LoadingViewType?
    
    @IBOutlet public var fetchingNextPageView: LoadingViewType?
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bindRefreshing(fetchedArrayViewModel)
        bindFetchingNextPage(fetchedArrayViewModel)
        
        if let refreshView = self.refreshView as? UIControl
        {
            refreshView.addTarget(fetchedArrayViewModel.refreshCocoaAction, action: CocoaAction.selector, forControlEvents: UIControlEvents.ValueChanged)
        }
        
        arrayView.rac_didScrollToHorizontalEnd().startWithNext { [unowned self] _ in
            self.fetchedArrayViewModel.fetchIfNeededCocoaAction.execute(nil)
        }
    }
    
    public func bindRefreshing(arrayViewModel: CocoaFetchedArrayViewModelType)
    {
        _bindRefreshing(arrayViewModel, viewController: self)
    }
    
    public func presentRefreshing(refreshing: Bool)
    {
        if let refreshView = self.refreshView
        {
            refreshView.loading = refreshing
        }
    }
    
    public func bindFetchingNextPage(arrayViewModel: CocoaFetchedArrayViewModelType)
    {
        _bindFetchingNextPage(arrayViewModel, viewController: self)
    }
    
    public func presentFetchingNextPage(fetchingNextPage: Bool)
    {
        if let fetchingNextPageView = self.fetchingNextPageView
        {
            fetchingNextPageView.loading = fetchingNextPage
        }
    }
}
