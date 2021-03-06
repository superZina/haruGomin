//
//  detailGominViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import SnapKit

class detailGominViewController: UIViewController {
    
    enum commentState {
        case expanded
        case collapsed
    }
    
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UIView!
    var commentVC : commentViewController!  = commentViewController()
    var visualEffectView:UIVisualEffectView!
    var postId:Int = 0
    var commentHeight:CGFloat = 600
    var commentHandleArea:CGFloat = 100
    var distance:CGFloat = 0
    var height:CGFloat = 0
    var commentVisible = false
    var nextState:commentState {
        return commentVisible ? .collapsed : .expanded
    }
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var tag: UIButton!
    @IBOutlet weak var gominTextView: UITextView!
    @IBOutlet weak var profileImg: UIImageView!
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var underline: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var accuseBtn: UIButton!
    
    override func viewDidLoad() {
        
        //MARK: navigation bar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        self.tag.layer.cornerRadius = 8
        self.tag.setTitleColor(ColorPalette.hagoRed, for: .normal)
        tag.isEnabled = false
        self.tag.layer.borderWidth = 1
        self.tag.layer.borderColor = ColorPalette.hagoRed.cgColor
        
        self.gominTextView.backgroundColor = .none
        self.gominTextView.textColor = .white
        self.gominTextView.isUserInteractionEnabled = true
        self.gominTextView.isScrollEnabled = true
        self.gominTextView.contentSize = CGSize(width: self.gominTextView.frame.width, height: self.gominTextView.frame.height + 300)
        
        
        self.commentTextField.isEnabled = false;
        self.commentTextView.backgroundColor = ColorPalette.darkBackground
        self.commentView.layer.cornerRadius = 8
        self.commentView.layer.borderColor = ColorPalette.borderGray.cgColor
        self.commentView.layer.borderWidth = 1
        self.commentTextField.textColor = .white
        self.commentView.backgroundColor = ColorPalette.darkBackground
        self.profileImg.layer.cornerRadius = 12
        
//        setupCommend()
        self.line.backgroundColor = ColorPalette.borderGray
        self.underline.backgroundColor = ColorPalette.borderGray
        self.commentTextView.layer.zPosition = 1
        self.underline.layer.zPosition = 1
        self.commentView.layer.zPosition = 1
        
        self.commentTextField.isEnabled = true
        self.view.isUserInteractionEnabled = true
        self.commentTextField.attributedPlaceholder = NSAttributedString(string: "   댓글을 입력해 주세요",            attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
        self.commentTextField.addLeftPadding(imgName: "")
        
        let accuseBarButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(accuseGomin))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = accuseBarButton
        // MARK: font
        self.username.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
        self.tag.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Medium", size: 15)
        self.createTime.font = UIFont(name: "Montserrat-Regular", size: 16)
        self.commentCount.font = UIFont(name: "Montserrat-Regular", size: 16)
        self.gominTextView.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
        
        self.commentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToCommentVC)))
        self.commentTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToCommentVC)))
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailGominDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: 0)
        
        self.commentBtn.isEnabled  = false
    }
    
    
    @objc func accuseGomin() {
        let alert = UIAlertController(title: "신고하기", message: "신중히 생각하셨나요?", preferredStyle: .alert)
        let accuseAction = UIAlertAction(title: "신고하기", style: .destructive) { (action) in
            let okAlert = UIAlertController(title: "신고완료", message: "신고가 완료되었어요!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            okAlert.addAction(ok)
            self.present(okAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(accuseAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        print("selected")
    }
    
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func moveToCommentVC() {
        let commentVC = commentViewController()
        commentVC.postId = self.postId
        self.present(commentVC, animated: true, completion: nil)
    }
    

    
    //MARK: gomin content Settings
    func setGominContent(gomin: gomin) {
        let createdAt:String = gomin.createdDate!
        let createTime:String = createdAt.components(separatedBy: "T")[1]
        let time:[String] = createTime.components(separatedBy: ":")
        self.createTime.text = time[0] + ":" + time[1]
        self.tag.setTitle(gomin.tagName, for: .normal)
        self.gominTextView.text = gomin.content
        self.navigationController?.navigationBar.topItem?.title = gomin.title
        self.profileImg.image = UIImage(named: gomin.userProfileImage!)
        self.username.text = gomin.userNickname
        
        self.commentCount.text = String(gomin.commentNum!)
        let urlString = gomin.userProfileImage
        if let enc_url = urlString?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: enc_url)
            self.profileImg.kf.setImage(with: url)
            self.profileImg.contentMode = .scaleAspectFit
        }
    }
}
    //MARK: commentVC Settings
//    func setupCommend(){
//        switch(UIScreen.main.nativeBounds.height) {
//        case 1334: //se2 , 8
//            commentHandleArea = 500
//            commentHeight = 500
//            distance = 270
//            break
//        case 2688: //promax
//            commentHandleArea = 250
//            commentHeight = 800
//            distance = -200
//            break
//        case 2436: //pro , 12 mini
//            commentHandleArea = 400
//            commentHeight = 600
//            distance = 100
//            break
//        case 1792: //1
//            commentHandleArea = 300
//            commentHeight = 750
//            distance = -100
//            break
//        case 2208: //8+
//            commentHandleArea = 300
//            commentHeight = 650
//            distance = 0
//            break
//        case 2532: //12 pro , 12
//            commentHandleArea = 400
//            commentHeight = 600
//            distance = 100
//            break
//        case 2778: //12 pro max
//            commentHandleArea = 400
//            commentHeight = 650
//            distance = 100
//            break
//        default:
//            break
//        }
//        visualEffectView = UIVisualEffectView()
//        visualEffectView.frame = self.view.frame
//        self.view.addSubview(visualEffectView)
//
//        commentVC.postId = self.postId
//
//        self.addChild(commentVC)
//        self.view.addSubview(commentVC.view)
//        commentVC.view.snp.makeConstraints { (make) in
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.top.equalTo(self.view.frame.height - commentHandleArea)
//            make.height.equalTo(self.view.frame.height)
//        }
//
//
//
//        print("commentVC Height : ",self.view.frame.height - commentHandleArea)
//
//
////        commentVC.view.clipsToBounds = true
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCommentTap(recognizer:)))
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCommentPan(recognizer:)))
//
//        commentVC.handleArea.addGestureRecognizer(tapGestureRecognizer)
//        commentVC.handleArea.addGestureRecognizer(panGestureRecognizer)
//
//    }
//    @objc func handleCommentTap(recognizer: UITapGestureRecognizer) {
//        switch  recognizer.state {
//        case .ended:
//            //continueTranse
//            animationTransitionIfNeeded(state: nextState, duration: 0.9)
//        default:
//            break
//        }
//    }
//
//    @objc func handleCommentPan(recognizer: UIPanGestureRecognizer){
//        switch recognizer.state {
//        case .began:
//            startInteractiveTransition(state: nextState, duration: 0.9)
//        case .changed:
//            let translation = recognizer.translation(in: self.commentVC.handleArea)
//            var fractionComplete = translation.y / commentHeight
//            fractionComplete = commentVisible ? fractionComplete : -fractionComplete
//            updateInteractiveTransition(fractionCompleted: fractionComplete)
//        case .ended:
//            continueInteractiveTransition()
//        default:
//            break
//        }
//
//    }
    
//    func animationTransitionIfNeeded(state: commentState, duration: TimeInterval) {
//        if runningAnimations.isEmpty {
//            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [self] in
//                switch state {
//                case .expanded:
//                    self.commentVC.view.frame.origin.y = self.view.frame.height - self.commentHeight
//                    self.view.sendSubviewToBack(self.gominTextView)
//                case .collapsed:
//                    self.commentVC.view.frame.origin.y = self.view.frame.height - self.commentHandleArea + distance
//                    print("y : ",self.commentVC.view.frame.origin.y)
//                    self.view.bringSubviewToFront(self.gominTextView)
//                }
//            }
//
//            frameAnimator.addCompletion { _ in
//                self.commentVisible = !self.commentVisible
//                self.runningAnimations.removeAll()
//            }
//
//            frameAnimator.startAnimation()
//            runningAnimations.append(frameAnimator)
//
//
//            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
//                switch state {
//                case .expanded:
//                    self.commentVC.view.layer.cornerRadius = 12
//                case .collapsed:
//                    self.commentVC.view.layer.cornerRadius = 0
//                }
//            }
//
//            cornerRadiusAnimator.startAnimation()
//            runningAnimations.append(cornerRadiusAnimator)
//
//            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.visualEffectView.effect = nil
//                case .collapsed:
//                    self.visualEffectView.effect = nil
//                }
//            }
//
//            blurAnimator.startAnimation()
//            runningAnimations.append(blurAnimator)
//
//        }
//    }
    
//    func startInteractiveTransition(state: commentState , duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            //run ani
//            animationTransitionIfNeeded(state: state, duration: duration)
//        }
//        for animator in runningAnimations {
//            animator.pauseAnimation()
//            animationProgressWhenInterrupted = animator.fractionComplete
//        }
//    }
//    func updateInteractiveTransition(fractionCompleted:CGFloat) {
//        for animator in runningAnimations {
//            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
//        }
//    }
//    func continueInteractiveTransition(){
//        for animator in runningAnimations {
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//        }
//    }


