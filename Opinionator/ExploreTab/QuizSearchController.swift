//
//  QuizSearchController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/10/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "quizCell"

class QuizSearchController: UICollectionViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        configureUI()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureUI() {
        collectionView.backgroundColor = .white
        navigationItem.title = "Search For Quizzes"
        
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Enter the name of a quiz"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

extension QuizSearchController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuizCell
        return cell
    }
    
}

extension QuizSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension QuizSearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        //fetch/filter quizzes here, should I fetch all users then filter or just fetch the ones related?  nont sure
    }
}
