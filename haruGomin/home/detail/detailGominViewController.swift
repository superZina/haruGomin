//
//  detailGominViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class detailGominViewController: UIViewController {
    
    enum commentState {
        case expanded
        case collapsed
    }
    
    @IBOutlet weak var commentTextView: UIView!
    var commentVC : commentViewController!
    var visualEffectView:UIVisualEffectView!
    
    let commentHeight:CGFloat = 600
    let commentHandleArea:CGFloat = 400
    
    var commentVisible = false
    var nextState:commentState {
        return commentVisible ? .collapsed : .expanded
    }
    @IBOutlet weak var tag: UIButton!
    
    @IBOutlet weak var gominTextView: UITextView!
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var underline: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = ColorPalette.background
        self.tag.layer.cornerRadius = 8
        self.tag.setTitleColor(ColorPalette.hagoRed, for: .normal)
        tag.isEnabled = false
        self.tag.layer.borderWidth = 1
        self.tag.layer.borderColor = ColorPalette.hagoRed.cgColor
        self.gominTextView.backgroundColor = .none
        self.gominTextView.textColor = .white
        self.commentTextView.backgroundColor = ColorPalette.darkBackground
        self.commentTextField.layer.cornerRadius = 8
        self.commentTextField.layer.borderColor = ColorPalette.borderGray.cgColor
        self.commentTextField.layer.borderWidth = 1
        self.commentTextField.textColor = ColorPalette.borderGray
        
        setupCommend()
        self.line.backgroundColor = ColorPalette.borderGray
        self.underline.backgroundColor = ColorPalette.borderGray
        self.commentTextView.layer.zPosition = 1
        self.underline.layer.zPosition = 1
        self.commentTextField.isEnabled = true
        self.view.isUserInteractionEnabled = true
        self.commentTextField.attributedPlaceholder = NSAttributedString(string: "   댓글을 입력해 주세요",            attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
        
    }
    
    func setupCommend(){
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        commentVC = commentViewController(nibName: "commentViewController", bundle: nil)
        self.addChild(commentVC)
        self.view.addSubview(commentVC.view)
        
        commentVC.view.frame = CGRect(x: 0, y: self.view.frame.height - commentHandleArea, width: self.view.bounds.width, height: commentHeight)
        commentVC.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCommentTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCommentPan(recognizer:)))
        
        commentVC.handleArea.addGestureRecognizer(tapGestureRecognizer)
        commentVC.handleArea.addGestureRecognizer(panGestureRecognizer)
        
    }
    @objc func handleCommentTap(recognizer: UITapGestureRecognizer) {
        switch  recognizer.state {
        case .ended:
            //continueTranse
            animationTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc func handleCommentPan(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.commentVC.handleArea)
            var fractionComplete = translation.y / commentHeight
            fractionComplete = commentVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animationTransitionIfNeeded(state: commentState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.commentVC.view.frame.origin.y = self.view.frame.height - self.commentHeight
                case .collapsed:
                    self.commentVC.view.frame.origin.y = self.view.frame.height - self.commentHandleArea + 200
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.commentVisible = !self.commentVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.commentVC.view.layer.cornerRadius = 12
                case .collapsed:
                    self.commentVC.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = nil
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state: commentState , duration:TimeInterval) {
        if runningAnimations.isEmpty {
            //run ani
            animationTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    func continueInteractiveTransition(){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
