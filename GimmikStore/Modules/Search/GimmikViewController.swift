//
//  GimmikViewController.swift
//  GimmikStore
//
//  Created by Dinushanka Nayomal on 10/3/18.
//  Copyright © 2018 Viyana. All rights reserved.
//

import UIKit

class GimmikViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gimmikCollectionView: UICollectionView!
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    
    var delegate: GimmikCollectionViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keypath = keyPath, keypath == Observers.contentOffset, let gimmikCollectionView = object as? UICollectionView {
            searchBarTopConstraint.constant = -1 * gimmikCollectionView.contentOffset.y
        }
    }
    
    func setup() -> Void {
        title = Config.appTitle
        searchBar.barTintColor = Colors.appHeaderColor
        gimmikCollectionView.register(UINib(nibName: CustomUIConstants.gimmikCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CustomUIConstants.gimmikCell)
        delegate = GimmikCollectionViewDelegate(viewController: self)
        gimmikCollectionView.dataSource = delegate.dataSource
        gimmikCollectionView.delegate = delegate
        addGimmikCollectionViewObserver()
        searchBar.delegate = delegate
        navigationController?.navigationBar.prefersLargeTitles = true
         navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBarTopConstraint.constant = 0.0
        searchBar.placeholder = Config.searchPlaceholder
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData(notification:)), name: NSNotification.Name(rawValue: Events.DataFetched), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard(notification:)), name: NSNotification.Name(rawValue: Events.HideKeyBoard), object: nil)
        self.hideKeyboardWhenTappedAround()

    }
    
    @objc func hideKeyboard(notification: NSNotification) {
        print("rec")
        self.hideKeyboardWhenTappedAround()
    }

    func reloadCollection() -> Void {
        gimmikCollectionView.reloadData()
    }
    
    func addGimmikCollectionViewObserver() -> Void {
        gimmikCollectionView.addObserver(self, forKeyPath: Observers.contentOffset, options: [.new, .old], context: nil)
    }
    
    @objc func reloadData(notification: NSNotification){
        reloadCollection()
    }
    
}
