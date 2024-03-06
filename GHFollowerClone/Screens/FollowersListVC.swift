//
//  FollowersListVC.swift
//  GHFollowerClone
//
//  Created by DucLong on 25/02/2024.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    var listFollowers: [Follower] = []
    var page = 0
    var hasMoreValue = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    
    func getFollowers(page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(page: page, username: username) {[weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                self.listFollowers.append(contentsOf: followers)
                
                if(self.listFollowers.isEmpty){
                    DispatchQueue.main.async {
                        self.showEmptyView(message: GFError.emptyList.rawValue, view: self.view)
                    }
                }
                
                self.updateData(list: listFollowers)
            case .failure(let error):
                self.presentGFAlertMainThread(title: "Error Call API", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower ) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(list: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureSearchController(){
        let searchController                        = UISearchController()
        searchController.searchResultsUpdater       = self
        searchController.searchBar.delegate         = self
        searchController.searchBar.placeholder      = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController             = searchController
        
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY                 = scrollView.contentOffset.y
        let contentHeight           = scrollView.contentSize.height
        let height                  = scrollView.frame.size.height
        
        if(offsetY < contentHeight - height) {
            if(page >= 1) {
                hasMoreValue = false
                return
            } else {
                page += 1
            }
            getFollowers(page: page)
        }
    }
}

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        let filterredFollowers = listFollowers.filter {
            $0.name.lowercased().contains(filter.lowercased())
        }
        if(filterredFollowers.isEmpty) {
            DispatchQueue.main.async {
                self.showEmptyView(message: GFError.emptyList.rawValue, view: self.view)
            }
        }
        updateData(list: filterredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel Tapped")
        updateData(list: listFollowers)
    }
}
