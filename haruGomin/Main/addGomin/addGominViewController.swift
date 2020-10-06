//
//  addGominViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/22.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class addGominViewController: UIViewController, UICollectionViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var gominTitle: UITextField!
    @IBOutlet weak var gominTagCollection: UICollectionView!
    var keyboardHeight:CGFloat = 0
    @IBOutlet weak var gominContentTextView: UITextView!

    @IBOutlet weak var img: UIImageView!
    var btns:[UIButton] = []
    let picker = UIImagePickerController()
    
    var btnText:[String] = ["일상","가족","친구","연애","학교","직장","취업","진로","돈","건강","기혼","육아"]
    //MARK: bar Buttons
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func regist(_ sender: Any) {
        let content:String = self.gominContentTextView.text
        var tagName:String = ""
        for i in btns {
            if i.isSelected {
                tagName = i.title(for: .normal)!
            }
        }
        let Title:String = self.gominTitle.text!
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        let parameter:[String:Any] = [
            "content": content,
            "postId": -1,
            "postImage": "string",
            "tagName": tagName,
            "title": Title,
            "userId": userId
        ]
        registGominDataManager.shared.registGomin(self, parameter: parameter)
    }
    @IBOutlet weak var textViewAndbottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.topItem?.title = "고민글 작성"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        self.view.backgroundColor = ColorPalette.darkBackground
        self.registBtn.setTitleColor(ColorPalette.hagoRed, for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        addToolbar()
        picker.delegate = self
        
        
        let itemCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.gominTagCollection.register(itemCellNib, forCellWithReuseIdentifier: "gomin")
        self.gominTagCollection.delegate = self
        self.gominTagCollection.dataSource = self
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        gominTagCollection.collectionViewLayout = layout
        self.gominTagCollection.backgroundColor = ColorPalette.darkBackground
        self.gominTitle.delegate = self
        
        // 제목 디자인 수정
        self.gominTitle.addLeftPadding()
        self.gominTitle.attributedPlaceholder = NSAttributedString(string: "제목을 적어주세요",            attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.textGray , NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        self.gominTitle.textColor = ColorPalette.textGray
        self.gominTitle.font = .boldSystemFont(ofSize: 16)
        self.gominTitle.backgroundColor = ColorPalette.background
        
        gominTitle.keyboardAppearance = .dark
        
        
        
        self.gominContentTextView.backgroundColor = ColorPalette.background
        self.gominContentTextView.textColor = ColorPalette.textGray
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        gominTitle.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.keyboardHeight = keyboardHeight
        print("키보드 : \(keyboardHeight)")
        if self.view.bounds.height <= 667 {
            print("height : \(self.view.bounds.height)")
            self.textViewAndbottom.constant = keyboardHeight - 50
        }else{
            self.textViewAndbottom.constant = keyboardHeight - 80
        }
        print(keyboardHeight)
        print(self.textViewAndbottom.constant)
        
        
    }
    func addToolbar(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .black
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items =  [
            flexibleSpace,
            UIBarButtonItem( image: UIImage(named: "24"), style: .done, target: self, action: #selector(takePicture)),
            UIBarButtonItem(image: UIImage(named: "picture"), style: .done, target: self, action: #selector(addImage))]
        
        toolbar.sizeToFit()
        gominContentTextView.inputAccessoryView = toolbar
        
    }
    @objc func addImage(){
        self.openLibrary()
    }
    
    @objc func takePicture(){
        
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
}
extension addGominViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.btnText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gominTagCollection.dequeueReusableCell(withReuseIdentifier: "gomin", for: indexPath) as! CollectionViewCell
        if indexPath.row == 0 {
            gominTagCollection.layoutMargins.left = 20
        }
        cell.contentView.backgroundColor = .none
        cell.btn.layer.cornerRadius = 8
        cell.btn.layer.borderWidth = 1
        cell.btn.layer.borderColor = ColorPalette.borderGray.cgColor
        cell.btn.setTitle(btnText[indexPath.item], for: .normal)
        cell.btn.setTitleColor(ColorPalette.textGray, for: .normal)
        self.btns.append(cell.btn)
        cell.btn.tag = indexPath.item
        cell.btn.addTarget(self, action: #selector(isSelected(_:)), for: .touchUpInside)
        return cell
    }

    @objc func isSelected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.layer.borderColor = ColorPalette.hagoRed.cgColor
            sender.setTitleColor(ColorPalette.hagoRed, for: .normal)
            for i in btns {
                if i != sender && i.isSelected {
                    i.isSelected = !i.isSelected
                    i.layer.borderColor = ColorPalette.borderGray.cgColor
                    i.setTitleColor(.white, for: .normal)
                }
            }
        }else {
            sender.layer.borderColor = ColorPalette.borderGray.cgColor
            sender.setTitleColor(.white, for: .normal)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: -10)
    }
    
}

extension addGominViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let View:UIView = UIView(frame: CGRect(x: 0, y: 180, width: self.view.bounds.width, height: 100))
            let imgView:UIImageView = UIImageView(frame: CGRect(x:0, y: 0, width: 100, height: 100))
            imgView.image = selectedImage
            View.addSubview(imgView)
            View.backgroundColor = .white
            self.gominContentTextView.addSubview(View)
//            self.gominContentTextView.addSubview(imgView)
//            self.img.image = selectedImage
            self.textViewAndbottom.constant = self.textViewAndbottom.constant + 600
        }
        dismiss(animated: true, completion: nil)
    }
}
