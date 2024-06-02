//
//  RepositoriesListVC.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

class RepositoriesListVC: UIViewController, InitialPopupDelegate {
    
    // For Pagination
    var isDataLoading: Bool = false
    var pageNo: Int = 0
    var limit: Int = 10
    var offset: Int = 0
    var selectedFilterIndex = 0
    var didEndReached: Bool = false
    
    @IBOutlet weak var sortButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    private var errorMessageLabel: UILabel!
    let viewModel = RepoListViewModel()
    var imageTasks = [Int: ImageTask]()
    var initialPopUPView: InitialPopupView?
    var programmingLang: String = "Swift"
    var selectedIndex = 0
    
    @IBAction func openPopUpAction(_ sender: UIBarButtonItem) {
        initialPopUPView = UINib(nibName: "InitialPopupView", bundle: .main).instantiate(withOwner: nil, options: nil).first as? InitialPopupView ?? InitialPopupView()
        initialPopUPView?.frame = view.bounds
        view.addSubview(initialPopUPView!)
        initialPopUPView?.loadInitialPopUpView()
        initialPopUPView?.programmingTextField.becomeFirstResponder()
        initialPopUPView?.delegate = self
        initialPopUPView?.isHidden = false
    }
    
    @IBAction func sortButtonAction(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: String(describing: SortingViewController.self)) as? SortingViewController else { return }
        controller.modalPresentationStyle = .overCurrentContext
        controller.selectedSorting = sortedItem(_:index:)
        controller.indexSelected = selectedFilterIndex
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupErrorMessageLabel()
        setupUI()
    }
    
    fileprivate func setupUI() {
        self.mainCollectionView.isPagingEnabled = false
        initialPopUPView = UINib(nibName: "InitialPopupView", bundle: .main).instantiate(withOwner: nil, options: nil).first as? InitialPopupView ?? InitialPopupView()
        initialPopUPView?.frame = view.bounds
        view.addSubview(initialPopUPView!)
        initialPopUPView?.loadInitialPopUpView()
        initialPopUPView?.programmingTextField.becomeFirstResponder()
        initialPopUPView?.delegate = self
        initialPopUPView?.isHidden = false
    }
    
    private func setupErrorMessageLabel() {
        errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .red
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func showErrorMessage(_ message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
        mainCollectionView.isHidden = true
    }
    
    private func hideErrorMessage() {
        errorMessageLabel.isHidden = true
        mainCollectionView.isHidden = false
    }
    
    func requestApi(offset: Int, limit: Int, sortBy: Sorting = .stars, searchText: String = "Swift") {
        viewModel.searchRepos(withText: searchText, offset: offset, limit: limit, sortBy: sortBy) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    if self?.viewModel.githubRepoList.isEmpty == true {
                        self?.showErrorMessage("No repositories found for the search text: \(searchText)")
                    } else {
                        self?.hideErrorMessage()
                        self?.receivedApiResponse()
                    }
                case .failure(let error):
                    self?.showErrorMessage("An error occurred: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func receivedApiResponse() {
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    func sortedItem(_ sort: Sorting, index: Int) {
        selectedFilterIndex = index
        requestApi(offset: self.offset, limit: self.limit, sortBy: sort, searchText: programmingLang)
    }
    
    func doneButtonSelected(name: String) {
        initialPopUPView?.isHidden = true
        mainCollectionView.isHidden = false
        programmingLang = name
        requestApi(offset: self.offset, limit: self.limit, searchText: programmingLang)
    }
    
    func closeButtonTapped() {
        mainCollectionView.isHidden = false
    }
}

// MARK: UICollectionViewDataSource Methods and UICollectionViewDelegateMethods
extension RepositoriesListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.githubRepoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RepositoriesCVCell.self), for: indexPath) as? RepositoriesCVCell else { return UICollectionViewCell() }
        cell.cardView.backgroundColor = UIColor(named: "backgroundCell")
        cell.cardView.layer.cornerRadius = 12
        cell.updateCell(cellData: viewModel.githubRepoList[indexPath.item])
        cell.loadImage(url: viewModel.githubRepoList[indexPath.item].owner?.avatarUrl ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        pushToRepoDetailScreen(index: selectedIndex)
    }
    
    func pushToRepoDetailScreen(index: Int) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "RepoDetailViewController") as? RepoDetailViewController else { return }
        controller.repoName = viewModel.githubRepoList[index].name ?? ""
        controller.loginName = viewModel.githubRepoList[index].owner?.login ?? ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension RepositoriesListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 1.0, bottom: 10, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 180)
    }
}

extension RepositoriesListVC: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.mainCollectionView.contentOffset.y >= (self.mainCollectionView.contentSize.height - self.mainCollectionView.bounds.size.height) {
            if !isDataLoading {
                isDataLoading = true
                pageNo += 1
                requestApi(offset: self.pageNo, limit: self.limit, searchText: programmingLang)
            }
        }
    }
}
