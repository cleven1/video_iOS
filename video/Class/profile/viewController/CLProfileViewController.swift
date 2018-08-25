//
//  ViewController.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class CLProfileViewController: CLRootViewController {

    private var tableView:UITableView?
    private var dataArray:[CLProfileModel] = [CLProfileModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        createData()
    }
    
    private func createData(){
        
        var model = CLProfileModel()
        model.title = "我看过的"
        model.iconName = "More_LotteryRecommend"
        model.cellType = .look
        dataArray.append(model)
        
        model.title = "我的收藏"
        model.iconName = "more_historyorder"
        model.cellType = .collect
        dataArray.append(model)
        
        tableView?.reloadData()
    }
    
    private func setupUI(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(CLProfileCell.self, forCellReuseIdentifier: "profileCell")
        tableView?.tableFooterView = UIView()
        let headerView = CLProfileHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenInfo.Width, height: 118))
        tableView?.tableHeaderView = headerView
        tableView?.rowHeight = 60
        view.addSubview(tableView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension CLProfileViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? CLProfileCell
        
        cell?.setProfileData(model: dataArray[indexPath.row])
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = dataArray[indexPath.row]
        
        let videoVC = CLProfileVideoController(profileType: model.cellType)
        
        navigationController?.pushViewController(videoVC, animated: true)
    }
    
}
