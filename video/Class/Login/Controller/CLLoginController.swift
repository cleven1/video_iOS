//
//  CLLoginController.swift
//  video
//
//  Created by cleven on 2018/8/24.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class CLLoginController: CLRootViewController {
    
    //MARK: 懒加载
    private lazy var bgImageView:UIImageView = {
       let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "login_bg03.jpg")
        let blureEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blureEffect)
        effectView.frame = view.bounds
        bgImageView.addSubview(effectView)
        return bgImageView
    }()
    private lazy var containerView:UIView = {
       let containerView = UIView()
        return containerView
    }()
    private lazy var logoBtn:UIButton = {
       let logoBtn = UIButton()
        logoBtn.isEnabled = false
        logoBtn.setImage(#imageLiteral(resourceName: "empty"), for: .normal)
        return logoBtn
    }()
    private lazy var accountTF:UITextField = {
        let accountTF = UITextField()
        let userD = UserDefaults.standard
        accountTF.text = userD.value(forKey: "userAccount") as? String
        return accountTF
    }()
    private lazy var passwordTF:UITextField = {
        let passwordTF = UITextField()
        
        return passwordTF
    }()
    private lazy var loginBtn:UIButton = {
       let loginBtn = UIButton()
        loginBtn.layer.cornerRadius = 8
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: ScreenInfo.kLoginFontSize)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.addTarget(self, action: #selector(self.loginAction(sender:)), for: .touchUpInside)
        return loginBtn
    }()
    private lazy var registBtn:UIButton = {
        let registBtn = UIButton()
        registBtn.contentHorizontalAlignment = .left
        registBtn.titleLabel?.font = UIFont.systemFont(ofSize: ScreenInfo.kOtherFontSize)
        registBtn.setTitle("注册", for: .normal)
        registBtn.addTarget(self, action: #selector(self.registAction(sender:)), for: .touchUpInside)
        
        return registBtn
    }()
    private lazy var resetPassWordBtn:UIButton = {
       let resetPassWordBtn = UIButton()
        resetPassWordBtn.contentHorizontalAlignment = .right
        resetPassWordBtn.titleLabel?.font = UIFont.systemFont(ofSize: ScreenInfo.kOtherFontSize)
        resetPassWordBtn.addTarget(self, action: #selector(self.resetPasswordAction(sender:)), for: .touchUpInside)
        resetPassWordBtn.setTitle("忘记密码?", for: .normal)
        
        return resetPassWordBtn
    }()
    
    private lazy var accountLine:UIView = {
       let accountLine = UIView()
       
        return accountLine
    }()
    
    private lazy var passwordLine:UIView = {
        let passwordLine = UIView()
        
        return passwordLine
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        
        setupUI()
    }
    
    private func setupUI(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        view.addGestureRecognizer(tap)
        
    
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        // 设置内容视图
        containerView.backgroundColor = UIColor.clear
        bgImageView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 设置logo
        containerView.addSubview(logoBtn)
        logoBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(ScreenInfo.navigationHeight)
        }
        
        // 设置密码输入
        createaTextField(textField: passwordTF, placeHolder: "密码", iconName: "login_password")
        containerView.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenInfo.kMaxW)
            make.height.equalTo(ScreenInfo.kTextFieldH)
            make.center.equalToSuperview()
        }
        
        passwordLine.backgroundColor = UIColor.white
        accountTF.addSubview(passwordLine)
        passwordLine.snp.makeConstraints { (make) in
            make.leading.equalTo(ScreenInfo.kTFLeftW)
            make.trailing.equalTo(-2)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        // 设置账号输入
        createaTextField(textField: accountTF, placeHolder: "请输入手机号", iconName: "login_account")
        containerView.addSubview(accountTF)
        accountTF.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenInfo.kMaxW)
            make.height.equalTo(ScreenInfo.kTextFieldH)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordTF.snp.top).offset(-ScreenInfo.kMargin_20)
        }
        
        accountLine = UIView()
        accountLine.backgroundColor = UIColor.white
        accountTF.addSubview(accountLine)
        accountLine.snp.makeConstraints { (make) in
            make.leading.equalTo(ScreenInfo.kTFLeftW)
            make.trailing.equalTo(-2)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        
        // 设置登录按钮
        containerView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenInfo.kMaxW)
            make.height.equalTo(ScreenInfo.kTextFieldH)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(ScreenInfo.kMargin_20)
        }
        
        // 注册按钮
        containerView.addSubview(registBtn)
        registBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(ScreenInfo.Kmargin_10)
            make.height.equalTo(ScreenInfo.kBtnH)
            make.width.equalTo(ScreenInfo.kMaxW/2.0)
        }
        
        //重置密码按钮
        containerView.addSubview(resetPassWordBtn)
        resetPassWordBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(ScreenInfo.Kmargin_10)
            make.height.equalTo(ScreenInfo.kBtnH)
            make.width.equalTo(ScreenInfo.kMaxW/2.0)
        }
    }
    
    private func createaTextField(textField:UITextField,placeHolder:String,iconName:String){
        
        textField.placeholder = placeHolder
        textField.tintColor = UIColor.white
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: ScreenInfo.kOtherFontSize)
        textField.leftViewMode = .always
        textField.delegate = self
        textField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        let accountImageV = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenInfo.kTFLeftW, height: ScreenInfo.kTFLeftH))
        accountImageV.contentMode = .left
        accountImageV.image = UIImage(named: iconName)
        textField.leftView = accountImageV
        
    }
    
    @objc private func tapAction() {
        hideKeyBoard()
    }
    
    @objc private func loginAction(sender:UIButton) {
        hideKeyBoard()
        
        guard let accountText = accountTF.text?.trimmingCharacters(in: .whitespaces) else {HUD.showErrorMessage(message: "请输入账号");return}
        
        guard let passwordText = passwordTF.text?.trimmingCharacters(in: .whitespaces) else {HUD.showErrorMessage(message: "请输入密码");return}
        if accountText.isEmpty {HUD.showErrorMessage(message: "请输入账号");return}
        if passwordText.isEmpty {HUD.showErrorMessage(message: "请输入密码");return}
        
        if CLTools.shareTool.validateContactNumber(mobileNum: accountText) {
            HUD.showLoadingHudView(message: "正在登陆...")
            HYBNetworking.postUserLogin(mobile: accountText, password: passwordText, success: { (response) in
                HUD.hideHud()
                let userD = UserDefaults.standard
                userD.set(accountText, forKey: "userAccount")
                userD.synchronize()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.backgroundColor = UIColor.cl_RGBColor(r: 0.0, g: 0, b: 0, a: 0.0)
                }, completion: { (_) in
                    let homeVC = CLHomeViewController()
                    UIApplication.shared.keyWindow?.rootViewController = homeVC
                })
                
                
        
            }) { (error) in
                HUD.hideHud()
                HUD.showErrorMessage(message: "登陆失败")
            }
        }else{
            HUD.showErrorMessage(message: "手机号错误")
        }
        
        
        
    }
    
    @objc private func registAction(sender:UIButton) {
        hideKeyBoard()
        let registerVC = CLRegisterController()
        
        navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    @objc private func resetPasswordAction(sender:UIButton) {
        hideKeyBoard()
        
    }
    
    private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    //MARK:监听键盘
    private func addObservers(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(noti:Notification){
        
//        let rect:CGRect = (noti.userInfo!["UIKeyboardFrameEndUserInfoKey"]! as? CGRect)!

        let duration = (noti.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as? Double) ?? 0.25
        
        UIView.animate(withDuration: duration) {
            self.containerView.transform = CGAffineTransform.init(translationX: 0, y: -ScreenInfo.kMargin_20 * 2)
        }
        
    }
    
    @objc private func keyboardWillHide(noti:Notification){
        
        let duration = (noti.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as? Double) ?? 0.25
        
        UIView.animate(withDuration: duration) {
            self.containerView.transform = CGAffineTransform.identity
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }


}

extension CLLoginController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyBoard()
        
        return true
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        hideKeyBoard()
    }
}
