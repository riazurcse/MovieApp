//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Riajur Rahman on 23/2/21.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typeLabel: UILabel!
    
    let margin: CGFloat = 14
    let noOfCellsInRow: Int = 2
    var pageNumber: Int = 1
    
    let movieViewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName:"MovieCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.typeLabelTapped(_:)))
        
        typeLabel.isUserInteractionEnabled = true
        typeLabel.addGestureRecognizer(tapGesture)
        updateTypeLabel()
        
        searchBar?.returnKeyType = .search
        searchBar?.enablesReturnKeyAutomatically = false
        searchBar?.backgroundColor = self.view.backgroundColor
        searchBar?.delegate = self
        searchBar?.placeholder = "Search movie, series, episode"
    }
    
    func callAPI() {
        movieViewModel.searchMovie(searchKey: movieViewModel.searchText!,
                          type: movieViewModel.searchType,
                          pageNumber: pageNumber,
                        completion: {
            self.collectionView.reloadData()
        })
    }
    
    @objc func typeLabelTapped(_ sender: UITapGestureRecognizer) {
        showSearchTypeOption()
    }
    
    @IBAction func expandButtonTapped(_ sender: UIButton) {
        showSearchTypeOption()
    }
    
    func showSearchTypeOption() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for type in SearchType.allCases {
            actionSheet.addAction(UIAlertAction(title: type.rawValue.capitalized, style: .default) {
                _ in
                self.movieViewModel.setSearchType(type: type)
                self.updateTypeLabel()
            })
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func updateTypeLabel() {
        typeLabel.text = movieViewModel.searchType.rawValue.capitalized
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if movieViewModel.searchedMovies().count > 0 {
            self.collectionView.backgroundView = nil
        } else {
            self.collectionView.backgroundView = Placeholder(text: "No search result found", image: UIImage(named: "ic_placeholder"))
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.searchedMovies().count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
        cell.configure(with: movieViewModel.searchedMovies()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imdbId = movieViewModel.searchedMovies()[indexPath.item].imdbID
        if let id = imdbId {
            MovieDetailsViewModel().movieDetails(imdbId: id) { movieDetails in
                if movieDetails != nil {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let movieDetailVController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
                    movieDetailVController.movieDetailsViewModel = movieDetails
                    self.navigationController?.pushViewController(movieDetailVController, animated: true)
                } else {
                    CommonUtils.showPrompt("Opps...", message: Constant.GENERIC_MESSAGE , buttons: ["OK"], delegate: nil) { _ in }
                }
            }
        }
    }
}

extension MovieViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if (collectionView.contentOffset.y + collectionView.frame.size.height) >= collectionView.contentSize.height {
            if movieViewModel.searchedMovies().count < movieViewModel.gettotalResults() {
                self.pageNumber += 1
                callAPI()
            }
        }
    }
}

extension MovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieViewModel.setSearchText(text: searchBar.text?.trimmingCharacters(in: .whitespaces))
        if searchBar.text!.count > 0 {
            movieViewModel.reset()
            pageNumber = 1
            self.callAPI()
        } else {
            searchBar.text = nil
        }
        searchBar.resignFirstResponder()
    }
}
