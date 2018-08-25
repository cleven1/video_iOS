//
//  CLVideoViewController.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class CLVideoViewController: CLRootViewController {
    
    private var tableView:UITableView?
    private var categoryType:videoCategoryType
    private var player:ZFPlayerController?
    private var controlView:ZFPlayerControlView = ZFPlayerControlView()
    
    private var dataArray:[CLVideoListModel]?{
        didSet{
            var videoUrls:[URL] = [URL]()
            for model in dataArray! {
                guard let url = URL(string: model.videoUrl ?? "") else {continue}
                videoUrls.append(url)
            }
            player?.assetURLs = videoUrls
        }
    }

    init(categoryType: videoCategoryType) {
        self.categoryType = categoryType
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPlayer()
        
    }

    private func setupUI(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenInfo.Width, height: ScreenInfo.Height - ScreenInfo.tabBarHeight - ScreenInfo.navigationHeight), style: .plain)
        tableView?.register(CLVideoCell.self, forCellReuseIdentifier: "videoCell")
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 0
        tableView?.estimatedSectionHeaderHeight = 0
        tableView?.estimatedSectionFooterHeight = 0
        tableView?.normalEmptyView()
        tableView?.addEmptyViewCallback(callback: { [weak self] in
            self?.getVideoData(ispullup: false)
        })
        tableView?.addHeaderCallback { [weak self] in
            self?.getVideoData(ispullup: false)
        }
        tableView?.addFooterCallback { [weak self] in
            self?.getVideoData(ispullup: true)
        }
        view.addSubview(tableView!)
        
        getVideoData(ispullup: false)
    }
    
    private func setupPlayer(){
        
        let plarerManager = ZFAVPlayerManager()
        player = ZFPlayerController(scrollView: tableView!, playerManager: plarerManager, containerViewTag: 100)
        player?.shouldAutoPlay = false
        player?.controlView = controlView
        player?.playerDisapperaPercent = 0.8
        player?.playerApperaPercent = 0.0
        
        player?.orientationWillChange = { [weak self] (player,isFullScreen) in
            self?.setNeedsStatusBarAppearanceUpdate()
            UIViewController.attemptRotationToDeviceOrientation()
            self?.tableView?.scrollsToTop = !isFullScreen
        }
        
        player?.playerDidToEnd = { [weak self] asset in
            self?.controlView.resetControlView()
            self?.player?.stopCurrentPlayingCell()
        }
        
        /// 以下设置滑出屏幕后不停止播放
        player?.stopWhileNotVisible = false
        let margin:CGFloat = 20
        let w = ScreenInfo.Width/2
        let h = w * 9 / 16
        let x = ScreenInfo.Width - w - margin
        let y = ScreenInfo.Height - h - margin
        player?.smallFloatView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    private func getVideoData(ispullup:Bool){
        
        var id:String?
        if ispullup == true {
            id = dataArray?.last?.id
        }else{
            id = dataArray?.first?.id
        }
        
        HYBNetworking.getVideoData(id: id, ispullup: ispullup, category: categoryType.rawValue, success: { (response) in
            guard let dataArray = response as? [CLVideoListModel] else {self.tableView?.successReload(isRefresh: false);return}
            if self.dataArray == nil {
                self.dataArray = dataArray
            }else if (self.dataArray?.count ?? 0) > 0 && ispullup == false {
                self.dataArray = dataArray + self.dataArray!
            }else{
                self.dataArray! += dataArray
            }
            self.tableView?.successReload()
        }) { (error) in
            self.tableView?.failedReload()
        }
    }
    
    private func playTheVideoAtIndexPath(indexPath:IndexPath,scrollToTop:Bool) {
        player?.playTheIndexPath(indexPath, scrollToTop: scrollToTop)
        
        let model = dataArray![indexPath.row]
        
        controlView.showTitle(model.title, coverURLString: model.imageUrl, fullScreenMode: model.imageW > model.imageH ? .landscape : .portrait)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.stopCurrentPlayingCell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

extension CLVideoViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? CLVideoCell
        cell?.setVideoListData(model: dataArray![indexPath.row])
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
        
    }
    
}

