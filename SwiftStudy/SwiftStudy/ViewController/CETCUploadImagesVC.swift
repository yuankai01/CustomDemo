//
//  CETCUploadImagesVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/12/4.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit

class CETCUploadImagesVC: CETCSwiftBaseVC,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var uploadImgBtn: UIButton!
    @IBOutlet weak var loadedImgView: UIImageView!
    
    var photoArray = [] as Array
    
    ///相机，相册
    var cameraPicker: UIImagePickerController!
    var photoPicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
     2017-12-04 10:22:18.207460+0800 CETCPartyBuilding[5861:301093]
     ⭐⭐⭐⭐⭐
     ⭐请求URL:http://101.230.200.46:8285/dangjian/v1/user/modifyUserImage
     ⭐⭐⭐⭐⭐
     2017-12-04 10:22:18.207860+0800 CETCPartyBuilding[5861:301093]
     🍎🍎🍎请求DICT🍎🍎
     {
     imageFile = /9j/4AAQSkZJRgABAQAASABIAAD/
     
     [self upLoadFileWithData:UIImageJPEGRepresentation(self.headerView.imgHead.image,0.1)];
     }
     
     - (void)upLoadFileWithData:(NSData *)data
     {
     NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
     [dic setObject:[CETCServer sharedInstance].currentUser.userId forKey:@"userId"];
     [dic setObject:[CETCServer sharedInstance].currentUser.userSessionKey forKey:@"userSessionId"];
     [dic setObject:[data base64EncodedString] forKey:@"imageFile"];
     [dic setObject:@"1" forKey:@"type"];
     
     */
    
    //选择图片上传
    @IBAction func uploadImage(_ sender: Any) {
//        initCameraPicker()
                initPhotoPicker()
    }
    
    func uploadImage(image:UIImage) -> Void {
        
        let userId = UserModel.shareUser.userId
        let sessionId = UserModel.shareUser.userSessionKey
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        
        var requestDic = Dictionary<String, Any>()
        
        requestDic["userId"] = userId
        requestDic["userSessionId"]  = sessionId

        requestDic["imageFile"] = imageData?.base64EncodedString()
        requestDic["type"]  = "1"
        
//        requestDic = ["userId" : userId!,"userSessionId" : sessionId!,"imageFile" : imageData?.base64EncodedString() as Any,"type" : "1"]
        
        let url = API_BASE_URL + "/user/modifyUserImage"
        CETCSwiftNetWork.init().post(url: url, params: requestDic, success: { (response) in
            self.loadedImgView.image = image
//            CETCAlertView.showMessage("上传成功")
        }) { (fail) in
//            CETCAlertView.showMessage("上传失败")
        }
    }
    
    /*
     - (void)showImagePickerActionSheet
     {
     UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
     
     if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
     {
     //支持相机
     UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍摄图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     [self showPickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
     }];
     [action setValue:CETC_MAIN_COLOR forKey:@"titleTextColor"];
     [actionSheet addAction:action];
     }
     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
     {
     //支持相片库
     UIAlertAction *action = [UIAlertAction actionWithTitle:@"选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     [self showPickerWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
     }];
     [action setValue:CETC_MAIN_COLOR forKey:@"titleTextColor"];
     [actionSheet addAction:action];
     }
     
     //取消
     UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     
     }];
     [action setValue:CETC_MAIN_COLOR forKey:@"titleTextColor"];
     
     [actionSheet addAction:action];
     [self presentViewController:actionSheet animated:YES completion:nil];
     
     }
     */
    
    //MARK: - Method
    func initCameraPicker(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.sourceType = .camera     //模拟器不支持摄像
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView.init(title: "提示", message:"开启摄像头失败"
                , delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            print("开启摄像头失败")
        }
    }
    
    func initPhotoPicker(){
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            photoPicker = UIImagePickerController()
            //设置代理
            photoPicker.delegate = self
            //指定图片控制器类型
            photoPicker.sourceType = .photoLibrary
            //弹出控制器，显示界面
            self.present(photoPicker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    //选好图片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        //获得照片
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        //上传单张图片
        if image != nil {
            uploadImage(image: image!)
        }
        
        if photoArray.count < 6 {
            photoArray.insert(image!, at: 0)
        }else {
            //最多上传6张
        }
    }
}
