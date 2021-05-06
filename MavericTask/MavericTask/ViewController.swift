//
//  ViewController.swift
//  MavericTask
//
//  Created by Vinoth on 06/05/21.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    var models       = [SlideShowModel]()
    var filterArray  = [TvModel]()
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sv: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    var filterMode   = false {
        didSet {
            if filterMode == false {
                filterArray.removeAll()
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SectionHeaderView.self,forHeaderFooterViewReuseIdentifier:SectionHeaderView.reuseIdentifier)
        let m1 = TvModel.init(imageUrl: "1photo", title: "Text 1", id: 1)
        let m2 = TvModel.init(imageUrl: "2photo", title: "Text 2", id: 2)
        let m3 = TvModel.init(imageUrl: "3photo", title: "Text 3", id: 3)
        let m4 = TvModel.init(imageUrl: "1photo", title: "Text 4", id: 4)
        let m5 = TvModel.init(imageUrl: "2photo", title: "Text 5", id: 5)
        let model1 = SlideShowModel.init(imageUrl: "1photo", content: [m1,m2,m3,m4,m5], id: 101)
        models.append(model1)
        
        let m11 = TvModel.init(imageUrl: "1photo", title: "Text 11", id: 11)
        let m12 = TvModel.init(imageUrl: "2photo", title: "Text 12", id: 12)
        let m13 = TvModel.init(imageUrl: "3photo", title: "Text 13", id: 13)
        let m14 = TvModel.init(imageUrl: "1photo", title: "Text 14", id: 14)
        let m15 = TvModel.init(imageUrl: "2photo", title: "Text 15", id: 15)
        let model11 = SlideShowModel.init(imageUrl: "2photo", content: [m11,m12,m13,m14,m15], id: 102)
        models.append(model11)
        
        let m21 = TvModel.init(imageUrl: "1photo", title: "Text 21", id: 21)
        let m22 = TvModel.init(imageUrl: "2photo", title: "Text 22", id: 22)
        let m23 = TvModel.init(imageUrl: "3photo", title: "Text 23", id: 23)
        let m24 = TvModel.init(imageUrl: "2photo", title: "Text 24", id: 24)
        let m25 = TvModel.init(imageUrl: "1photo", title: "Text 25", id: 25)
        let model21 = SlideShowModel.init(imageUrl: "1photo", content: [m21,m22,m23,m24,m25], id: 103)
        models.append(model21)

        let m31 = TvModel.init(imageUrl: "3photo", title: "Text 31", id: 31)
        let m32 = TvModel.init(imageUrl: "2photo", title: "Text 32", id: 32)
        let m33 = TvModel.init(imageUrl: "1photo", title: "Text 33", id: 33)
        let m34 = TvModel.init(imageUrl: "3photo", title: "Text 34", id: 34)
        let m35 = TvModel.init(imageUrl: "2photo", title: "Text 35", id: 35)
        let model31 = SlideShowModel.init(imageUrl: "3photo", content: [m31,m32,m33,m34,m35], id: 104)
        models.append(model31)
        sv.delegate = self
        setupSlideScrollView(slides: models)
        sv.isPagingEnabled = true
        pageControll.currentPage    = 0
        pageControll.numberOfPages  = models.count
        pageControll.isUserInteractionEnabled = false
        sv.contentSize = CGSize(width: view.frame.width * CGFloat(models.count), height: 180)
    }
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterMode {
            return filterArray.count
        }
        return models[pageControll.currentPage].content?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        
        if filterMode {
            cell.model = filterArray[indexPath.row]
            return cell
        }

        if let m  =  models[pageControll.currentPage].content?[indexPath.row] {
            cell.model = m
        }
        
        if filterMode {
            cell.model = filterArray[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view  = SectionHeaderView.init(reuseIdentifier:SectionHeaderView.reuseIdentifier)
        view.searchBar.delegate   = self
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex            = round(scrollView.contentOffset.x/view.frame.width)
        pageControll.currentPage = Int(pageIndex)
        print(pageControll.currentPage)
        filterMode = false
        view.endEditing(true)
        tableView.reloadData()
    }
    
    func setupSlideScrollView(slides : [SlideShowModel]) {

        let scrollViewWidth:CGFloat  = self.view.frame.width - 10
        let scrollViewHeight:CGFloat = self.sv.frame.height

        for i in 0 ..< slides.count {
            let imgOne = UIImageView(frame: CGRect(x: scrollViewWidth * CGFloat(i) + CGFloat(i*3)   , y:0,width:view.frame.width - 10 , height:scrollViewHeight))
            imgOne.image = UIImage(named:slides[i].imageUrl ?? "")
            sv.addSubview(imgOne)
        }
    }

}

extension ViewController {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filterMode  = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filterMode  = false
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        let s = searchText.lowercased()
        let filteredModels = self.models[pageControll.currentPage].content?.filter({($0.title?.lowercased().contains(s) ) as! Bool } )
        filterArray  = filteredModels ?? []
        tableView.reloadData()
    }
}
