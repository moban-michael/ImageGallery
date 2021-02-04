//
//  ImageListViewController.swift
//  ImageGallery
//
//  Created by Moban Michael on 31/01/2021.
//

import Foundation
import RxSwift
import KRLCollectionViewGridLayout

class ImageListViewController: UICollectionViewController {
        
    private let reuseIdentifier         = "ImageCell"
    fileprivate var images              = [Image]()
    fileprivate var filteredList        = [Image]()
    fileprivate var isFilterring        = false
    private let disposeBag              = DisposeBag()
    var imageListViewModal              = ImageListViewModel()
    private let imagesPerRow: CGFloat   = 3
    var selectedImage       : Image?
    var searchController    : UISearchController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        loadData()
    }
    
    //MARK: UI
    
    fileprivate func setUpUI(){
        
        title = "Images"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        addSearchBar()
        setUpCollectionView()
    }
    
    fileprivate func setUpCollectionView(){
        
        let flowLayout = KRLCollectionViewGridLayout.init()
        flowLayout.aspectRatio = 1
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.interitemSpacing = 10
        flowLayout.lineSpacing = 10
        flowLayout.numberOfItemsPerLine = 2
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
    }
    
    fileprivate func addSearchBar() {
        
        searchController = UISearchController(searchResultsController:  nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
    }
    
    //MARK: Loading Data
    
    func loadData(){
        imageListViewModal.offlineImageList.asObservable().subscribe { (event) in
            if let images = event.element{
                onMainQueue {
                    let uniqueImages = images.uniques
                    self.images = uniqueImages
                    self.collectionView.reloadData()
                }
            }
        }.disposed(by: self.disposeBag)
        imageListViewModal.fetchAllImageFromLocalDB()
    }
    
    func getDataFromServer(for searchText:String){
        imageListViewModal = ImageListViewModel()
        //self.showProgress()
        imageListViewModal.searchOnlineImageList.asObservable().subscribe { (event) in
            if let images = event.element{
                onMainQueue {
                    //self.hideProgress()
                    var uniqueImages = self.filteredList.uniques
                    uniqueImages.insert(contentsOf: images.uniques, at: 0)
                    self.filteredList = uniqueImages
                    self.collectionView.reloadData()
                }
            }
        }.disposed(by: self.disposeBag)
        imageListViewModal.searchOnlineFailed.asObservable().subscribe { (event) in
            if event.element != nil{
                onMainQueue {
                    //self.hideProgress()
                    self.isFilterring = false
                    self.filteredList = [Image]()
                    self.collectionView.reloadData()
                    self.view.showToast("Search Failed", width: 200)
                }
            }
        }.disposed(by: self.disposeBag)
        imageListViewModal.getImages(for: searchText)
    }
}

private typealias CollectionViewDataSource = ImageListViewController
extension CollectionViewDataSource  {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFilterring ? self.filteredList.count : self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ImageCell
        if let image = isFilterring ? (self.filteredList[indexPath.row].mainImage.image) : (self.images[indexPath.row].mainImage.image){
            cell.imageView.image = image
        }else{
            cell.imageView.image = UIImage(named:"PlaceHolder")
        }
        
        return cell
    }
}
    
private typealias CollectionViewDelegate = ImageListViewController
extension CollectionViewDelegate{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFilterring {
            self.selectedImage = self.filteredList[indexPath.row]
        }else{
            self.selectedImage = self.images[indexPath.row]
        }
        performSegue(withIdentifier: "Load Detail", sender: nil)
    }
}

private typealias prepareForSegue = ImageListViewController
extension prepareForSegue{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Load Detail") {
            if let detailViewController = segue.destination as? ImageDetailViewController {
                detailViewController.image = self.selectedImage
            }
        }
    }
}

private typealias SearchResultsDelegate = ImageListViewController
extension SearchResultsDelegate: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.getDataFromServer(for: text)
            self.isFilterring = true
            searchBar.resignFirstResponder()
        }else {
            self.isFilterring = false
            self.filteredList = [Image]()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
        self.isFilterring = false
        self.filteredList = [Image]()
        self.collectionView.reloadData()
    }
}
