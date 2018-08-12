//
//  ViewController.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit
import iProgressHUD

class MainController: UIViewController, MainDelegete, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!    
    @IBOutlet weak var searchBar: UIBarButtonItem!
    
    fileprivate let util: StackSearchUtil = StackSearchUtil()
    fileprivate var presenter: MainPresenter!
    fileprivate var filterVC: FilterController!
    fileprivate var filterView: UIView!
    fileprivate var loadingView: UIView!
    fileprivate var isFilterShow: Bool = false
    fileprivate var yDynamic: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // restrict the rotation
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all
        
        // Setup loading view
        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        loadingView.isHidden = true
        
        // Instantiate iProgressHUD and attach progress to main view
        let iprogress = iProgressHUD(style: .ballPulseSync)
        iprogress.isShowCaption = false
        iprogress.boxSize = 25
        iprogress.modalColor = UIColor(rgb: 0x007AFF)
        iprogress.alphaModal = 0.7
        iprogress.isShowBox = false
        iprogress.isShowModal = true
        iprogress.indicatorColor = .white
        iprogress.attachProgress(toViews: self.navigationController!.view, loadingView)
        
        
        // Instantiate iProgressHUD and attach progress to loading view
        let iprogressLoadingView = iProgressHUD(style: .ballPulseSync)
        iprogressLoadingView.isShowCaption = false
        iprogressLoadingView.boxSize = 100
        iprogressLoadingView.isShowBox = false
        iprogressLoadingView.isShowModal = false
        iprogressLoadingView.indicatorColor = UIColor(rgb: 0x007AFF)
        iprogressLoadingView.attachProgress(toViews: loadingView)
        
        // Set scrollview delegete.
        scrollView.addSubview(loadingView)
        scrollView.delegate = self
        
        // Init presenter and filter view controller.
        presenter = MainPresenter(delegete: self)
        filterVC = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterController
        filterVC.mainDelegete = presenter
        filterVC.loadViewIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterView = filterVC.view
        filterView.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        filterView.frame = CGRect(x: 0, y: -self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(filterView)
    }
    
    /** Filter button click action. */
    @IBAction func didClickedFilterBar(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            if !self.isFilterShow {
                self.searchBar.title = "Close"
                self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height + 55)
            } else {
                self.searchBar.title = "Search"
                self.filterView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.height  + 55))
            }
        }) { (_) in
            self.isFilterShow = !self.isFilterShow
        }
    }
    
    /** Show load more progress view. */
    func loadMore(show: Bool) {
        loadingView.isHidden = !show
        if show {
            scrollView.contentSize.height += 50
            loadingView.setY(y: (yDynamic + 8))
            loadingView.showProgress()
        } else {
            loadingView.dismissProgress()
        }
    }
    
    /** Delegete method show progress. */
    func showProgress(show: Bool) {
        if show {
            self.navigationController!.view.showProgress()
        } else {
            self.navigationController!.view.dismissProgress()
        }
    }
    
    /** Clear all view items with tag 1. */
    func clearItems(completion: @escaping() -> ()) {
        yDynamic = 8
        for subview in scrollView.subviews {
            if subview.tag == 1 {
                subview.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.title = "Search"
            self.filterView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        }) { (_) in
            self.isFilterShow = false
        }
        completion()
    }
    
    /** Add view items with tag 1. */
    func addItem(data: Item) {
        let itemVC = storyboard?.instantiateViewController(withIdentifier: "itemVC") as! ItemController
        itemVC.loadViewIfNeeded()
        
        let viewItem = itemVC.presenter.addData(data: data, frame: CGRect(x: 0, y: yDynamic, width: self.view.frame.width, height: 106))
        viewItem.tag = 1
        viewItem.accessibilityIdentifier = data.link
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink(_:)))
        viewItem.addGestureRecognizer(tapGesture)
        scrollView.addSubview(viewItem)
        yDynamic += 106
        scrollView.contentSize.height = yDynamic
    }
    
    @objc func openLink(_ gesture: UITapGestureRecognizer) {
        presenter.openBrowser(link: gesture.view!.accessibilityIdentifier!)
    }
    
    /** Show dialog popup info. */
    func showDialog(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) && (loadingView.isHidden) {
            presenter.requestNextPage()
        }
    }
}

