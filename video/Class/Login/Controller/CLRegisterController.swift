//
//  CLRegisterController.swift
//  video
//
//  Created by cleven on 2018/8/24.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class CLRegisterController: CLRootViewController {
    
    // 头像二进制
    private var avatarImage:UIImage?

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
        containerView.backgroundColor = UIColor.clear
        return containerView
    }()
    
    private lazy var avatarButton:UIButton = {
       let avatarButton = UIButton()
        avatarButton.setImage(#imageLiteral(resourceName: "avatar_empty"), for: .normal)
        avatarButton.addTarget(self, action: #selector(self.clickAvaratButton(sender:)), for: .touchUpInside)
        avatarButton.layer.cornerRadius  = 40
        avatarButton.layer.masksToBounds = true
        return avatarButton
    }()
    
    private lazy var manButton:UIButton = {
        let manButton = UIButton()
        manButton.setImage(#imageLiteral(resourceName: "gender_select_normal"), for: .normal)
        manButton.setTitle("男", for: .normal)
        manButton.setImage(#imageLiteral(resourceName: "gender_select"), for: .selected)
        manButton.setTitle("男", for: .selected)
        manButton.setTitleColor(UIColor.white, for: .normal)
        manButton.setTitleColor(UIColor.white, for: .selected)
        manButton.imagePostion(postion: .left, spacing: 5)
        manButton.isSelected = true
        manButton.addTarget(self, action: #selector(self.clickManButton(sender:)), for: .touchUpInside)
        return manButton
    }()
    
    private lazy var womanButton:UIButton = {
        let womanButton = UIButton()
        womanButton.setImage(#imageLiteral(resourceName: "gender_select_normal"), for: .normal)
        womanButton.setTitle("女", for: .normal)
        womanButton.setImage(#imageLiteral(resourceName: "gender_select"), for: .selected)
        womanButton.setTitle("女", for: .selected)
        womanButton.setTitleColor(UIColor.white, for: .normal)
        womanButton.setTitleColor(UIColor.white, for: .selected)
        womanButton.imagePostion(postion: .left, spacing: 5)
        womanButton.addTarget(self, action: #selector(self.clickWomanButton(sender:)), for: .touchUpInside)
        return womanButton
    }()
    

    private lazy var nameTextField:UITextField = {
       let nameTextField = UITextField()
        nameTextField.placeholder = "请输入昵称"
        nameTextField.tag = 100
        nameTextField.textColor = UIColor.white
        nameTextField.tintColor = UIColor.white
        nameTextField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        nameTextField.font = UIFont.systemFont(ofSize: ScreenInfo.kLoginFontSize)
        return nameTextField
    }()
    
    private lazy var passwordTextField:UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.tag = 101
        passwordTextField.textColor = UIColor.white
        passwordTextField.tintColor = UIColor.white
        passwordTextField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        passwordTextField.font = UIFont.systemFont(ofSize: ScreenInfo.kLoginFontSize)
        return passwordTextField
    }()
    
    private lazy var phoneTextField:UITextField = {
        let phoneTextField = UITextField()
        phoneTextField.placeholder = "请输入手机号"
        phoneTextField.tag = 102
        phoneTextField.textColor = UIColor.white
        phoneTextField.tintColor = UIColor.white
        phoneTextField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        phoneTextField.font = UIFont.systemFont(ofSize: ScreenInfo.kLoginFontSize)
        phoneTextField.keyboardType = .numberPad
        return phoneTextField
    }()
    
    private lazy var smsCodeTextField:UITextField = {
        let smsCodeTextField = UITextField()
        smsCodeTextField.placeholder = "请输入验证码"
        smsCodeTextField.tag = 103
        smsCodeTextField.textColor = UIColor.white
        smsCodeTextField.tintColor = UIColor.white
        smsCodeTextField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        smsCodeTextField.font = UIFont.systemFont(ofSize: ScreenInfo.kLoginFontSize)
        smsCodeTextField.keyboardType = .numberPad
        return smsCodeTextField
    }()
    
    private lazy var verifyButton:CLButton = {
       let verifyButton = CLButton(count: 60, frame:.zero, color: nil)
        verifyButton.animaType = .CLBtnTypeScale
        verifyButton.layer.cornerRadius = 5
        verifyButton.layer.masksToBounds = true
        verifyButton.clickButtonCallbakc = { [weak self] in
            self?.clickVerifyButton()
        }
        return verifyButton
    }()
    
    
    private lazy var registerButton:UIButton = {
        let registerButton = UIButton()
        registerButton.layer.cornerRadius = 8
        registerButton.layer.masksToBounds = true
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: ScreenInfo.kLoginFontSize)
        registerButton.setTitle("注册", for: .normal)
        registerButton.addTarget(self, action: #selector(self.clickRegisterButton(sender:)), for: .touchUpInside)
        return registerButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册用户"
        
        setupUI()
        addObservers()
    }


    private func setupUI(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyBoard))
        view.addGestureRecognizer(tap)
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView = UIView()
        bgImageView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(avatarButton)
        avatarButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(ScreenInfo.navigationHeight + ScreenInfo.kMargin_20)
            make.width.height.equalTo(80)
        }
        
        containerView.addSubview(manButton)
        manButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(containerView.snp.centerX).offset(-80)
            make.top.equalTo(avatarButton.snp.bottom).offset(ScreenInfo.Kmargin_15 * 2)
        }
        containerView.addSubview(womanButton)
        womanButton.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView.snp.centerX).offset(80)
            make.centerY.equalTo(manButton)
        }
        createaTextField(textField: nameTextField, iconName: "login_account")
        containerView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView).offset(ScreenInfo.Kmargin_15)
            make.top.equalTo(manButton.snp.bottom).offset(ScreenInfo.kMargin_20)
            make.trailing.equalTo(containerView).offset(-ScreenInfo.Kmargin_15)
            make.height.equalTo(ScreenInfo.kTextFieldH)
        }
        
        createaTextField(textField: passwordTextField, iconName: "login_password")
        containerView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameTextField)
            make.top.equalTo(nameTextField.snp.bottom).offset(ScreenInfo.Kmargin_15)
        }
        
        createaTextField(textField: phoneTextField, iconName: "login_phone")
        containerView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(ScreenInfo.Kmargin_15)
        }
        
        createaTextField(textField: smsCodeTextField, iconName: "login_verify")
        containerView.addSubview(smsCodeTextField)
        smsCodeTextField.snp.makeConstraints { (make) in
            make.leading.height.equalTo(nameTextField)
            make.top.equalTo(phoneTextField.snp.bottom).offset(ScreenInfo.Kmargin_15)
            make.trailing.equalTo(containerView).offset(-100)
        }
        
        containerView.addSubview(verifyButton)
        verifyButton.snp.makeConstraints { (make) in
            make.leading.equalTo(smsCodeTextField.snp.trailing).offset(ScreenInfo.Kmargin_10)
            make.height.centerY.equalTo(smsCodeTextField)
            make.trailing.equalTo(containerView).offset(-ScreenInfo.Kmargin_15)
        }
        
        containerView.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenInfo.kMaxW)
            make.height.equalTo(ScreenInfo.kTextFieldH)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        
    }
    
    private func createaTextField(textField:UITextField,iconName:String){
        
        textField.leftViewMode = .always
        let accountImageV = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenInfo.kTFLeftW, height: ScreenInfo.kTFLeftH))
        accountImageV.contentMode = .left
        accountImageV.image = UIImage(named: iconName)
        textField.leftView = accountImageV
        let accountLine = UIView()
        accountLine.backgroundColor = UIColor.white
        textField.addSubview(accountLine)
        accountLine.snp.makeConstraints { (make) in
            make.leading.equalTo(textField)
            make.trailing.equalTo(-2)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    @objc private func clickAvaratButton(sender:UIButton) {
        hideKeyBoard()
        
    }
    
    @objc private func clickManButton(sender:UIButton) {
        womanButton.isSelected = false
        sender.isSelected = true
    }
    
    @objc private func clickWomanButton(sender:UIButton) {
        sender.isSelected = true
        manButton.isSelected = false
    }
    
    private func clickVerifyButton() {
        hideKeyBoard()
        
        let phonoNumber = phoneTextField.text?.trimmingCharacters(in: .whitespaces)
        if (phonoNumber?.isEmpty)! {
            HUD.showErrorMessage(message: "手机号不能为空")
            return
        }else if (phonoNumber?.count ?? 0) != 11 {
            HUD.showErrorMessage(message: "手机号错误")
            return
        }else{
            if CLTools.shareTool.validateContactNumber(mobileNum: phonoNumber!) {
                HYBNetworking.getVerifyCode(mobile:phonoNumber!, success: { (response) in
                    HUD.showSuccesshTips(message: "验证码发送成功")
                }) { (error) in
                    HUD.showErrorMessage(message: "验证码发送失败")
                    self.verifyButton.resetCountDown()
                }                
            }else{
                HUD.showErrorMessage(message: "手机号错误")
            }
        }
        
    }
    
    @objc private func clickRegisterButton(sender:UIButton) {
        hideKeyBoard()
        
        guard let registerModel = createRegisterData() else {return}
        HUD.showLoadingHudView(message: "正在注册用户...")
        
//        if let avatarImage = self.avatarImage {
//            HYBNetworking.uploadFile(avatarImage: avatarImage, success: { (file_name) in
//                registerModel.avatar_url = file_name as? String
//                self.registerUser(registerModel: registerModel)
//            }, failure: { (error) in
//                HUD.hideHud()
//                HUD.showErrorMessage(message: "头像上传失败")
//            })
//        }else{
//        }
        self.registerUser(registerModel: registerModel)
    }
    
    private func registerUser(registerModel:CLUSerRegisterModel){

        HYBNetworking.postRegisterUserData(registerModel: registerModel, success: { (response) in
            HUD.hideHud()
            HUD.showSuccesshTips(message: "注册成功")
            self.clickBackButton()
        }) { (error) in
            HUD.hideHud()
            guard let errorDict = error as? [String:String] else {return}
            if let error_msg = errorDict["error"]  {
                HUD.showErrorMessage(message: error_msg)
            }
        }
    }
    
    private func createRegisterData() -> CLUSerRegisterModel?{
        var registerModel = CLUSerRegisterModel()
        registerModel.avatar_url = ""
        if manButton.isSelected {
            registerModel.gender = 1
        }
        if womanButton.isSelected {
            registerModel.gender = 0
        }
        
        let name = nameTextField.text?.trimmingCharacters(in: .whitespaces)
        if (name?.isEmpty)! {
            HUD.showErrorMessage(message: "昵称不能为空")
            return nil
        }else{
            registerModel.name = name
        }
        
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        if (password?.isEmpty)! {
            HUD.showErrorMessage(message: "密码不能为空")
            return nil
        }else if (password?.count ?? 0) < 5 {
            HUD.showErrorMessage(message: "密码不能少于6位")
            return nil
        }else{
            registerModel.pwd = password
        }
        
        let phoneNumber = phoneTextField.text?.trimmingCharacters(in: .whitespaces)
        if (phoneNumber?.isEmpty)! {
            HUD.showErrorMessage(message: "手机号不能为空")
            return nil
        }else if (phoneNumber?.count ?? 0) != 11 {
            HUD.showErrorMessage(message: "手机号错误")
            return nil
        }else{
            if CLTools.shareTool.validateContactNumber(mobileNum: phoneNumber!) {
                registerModel.mobile = phoneNumber
            }else{
                HUD.showErrorMessage(message: "手机号错误")
            }
        }
        
        let smsCode = smsCodeTextField.text?.trimmingCharacters(in: .whitespaces)
        if (smsCode?.isEmpty)! {
            HUD.showErrorMessage(message: "验证码不能为空")
            return nil
        }else if (smsCode?.count ?? 0) != 4 {
            HUD.showErrorMessage(message: "验证码错误")
            return nil
        }else{
            registerModel.sms_code = smsCode
        }
        
        // 获取手机唯一标示
        registerModel.identifier = UIDevice.current.identifierForVendor?.uuidString
        
        return registerModel
    }
    
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }

    
    //MARK:监听键盘
    private func addObservers(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(noti:Notification){
        
        //        let rect:CGRect = (noti.userInfo!["UIKeyboardFrameEndUserInfoKey"]! as? CGRect)!
        
        var view:UIView?
        for subView in containerView.subviews {
            if subView.isKind(of: UITextField.self) && ((subView as? UITextField)?.isEditing)! {
                view = subView
            }
        }
        
        let duration = (noti.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as? Double) ?? 0.25
        
        //键盘遮挡才需上移
        UIView.animate(withDuration: duration) {
            if let postion = view?.tag {
                self.containerView.transform = CGAffineTransform.init(translationX: 0, y: -(CGFloat(postion) - 99) * ScreenInfo.kMargin_20)
            }
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
        
        
    }
    


}

extension CLRegisterController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type: String = (info[UIImagePickerControllerMediaType] as! String)
        
        //当选择类型是图片
        if type == "public.image" {
            //修正图片的位置
            guard let image = (info[UIImagePickerControllerOriginalImage] as? UIImage) else {return}
            
            var size:CGSize = .zero
            size = CGSize(width: ScreenInfo.Width * UIScreen.main.scale, height: (ScreenInfo.Width / 3 * 4) * UIScreen.main.scale)
            guard let scaledImage = image.resizedImage(with: .scaleAspectFill, bounds: size, interpolationQuality: .high) else {return}
            let cropFrame = CGRect(x: (scaledImage.size.width - size.width) / 2, y: (scaledImage.size.height - size.height)/2, width: size.width, height: size.height)
            
            guard let croppedImage = scaledImage.croppedImage(cropFrame) else{return}
            
            
            // 压缩照片
            let imageData = CLImageUtil.resetImgSize(sourceImage: croppedImage, maxImageLenght: 100, maxSizeKB: 100)
            
            self.avatarButton.setImage(UIImage(data: imageData), for: .normal)
            
//            let tempPath = NSTemporaryDirectory()
//            let avatarPath = tempPath + "avatar.png"
//            try? imageData.write(to: URL(fileURLWithPath: avatarPath))
            
            self.avatarImage = UIImage(data: imageData)
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

