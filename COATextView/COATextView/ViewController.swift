//
//  ViewController.swift
//  COATextView
//
//  Created by coyote on 18/02/16.
//  Copyright © 2016 coyote. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var anonymeButton: UIButton!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var attachButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var attachButton: UIButton!
    var placeholderLabel : UILabel!
    var scrollViewChild : UIView!
    var textView: UITextView!
    var attachedImageView: UIImageView!
    var keyBoardHeight: CGFloat = 0.0
    let imageTextViewOffset:CGFloat = 10.0
    var header: COATextViewHeader!
    let embedHeaderSegue = "embedHeaderSegue"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        attachButton.layer.borderColor = UIColor(netHex : 0x6FA6FF).CGColor
        anonymeButton.layer.borderColor = UIColor(netHex : 0x6FA6FF).CGColor
        //Init scrollViewChild
        scrollViewChild = UIView(frame: CGRect(x: 0, y: 0, width: contentScrollView.frame.width, height: 30))
        //Init compose textView
        textView = UITextView(frame: CGRect(x: 10, y: 0, width: scrollViewChild.frame.width - 20, height: scrollViewChild.frame.height))
        textView.font = UIFont.systemFontOfSize(16)
        textView.text = "Ecrivez ici ..."
        textView.sizeToFit()
        textView.text = ""
        textView.frame.size.width = scrollViewChild.frame.width - 20
        textView.editable = true
        //Add textView to scrollViewChild
        scrollViewChild.addSubview(textView)
        // Add scrollViewChild to scrollView
        contentScrollView.addSubview(scrollViewChild)
        //Add placeholderLabel
        placeholderLabel = UILabel()
        placeholderLabel.text = "Ecrivez ici ..."
        placeholderLabel.font = textView.font
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPointMake(5, textView.font!.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.hidden = !textView.text.isEmpty
        textView.delegate = self
        scrollViewChild.frame.size.height = textView.frame.height
        scrollViewChild.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("textViewShouldBecomeFirstResponder:"))
        scrollViewChild.addGestureRecognizer(tapGesture)
        contentScrollView.userInteractionEnabled = true
        contentScrollView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func publishAnonyme(sender: UIButton) {
        headerHeightConstraint.constant = 88.0
        header.anonymCellHidden = false
        header.tableView.reloadData()
        UIView.animateWithDuration(0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func keyboardWillShow(notification: NSNotification){
        var info = notification.userInfo!
        let keyboardSize: CGSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        attachButtonBottomConstraint.constant = keyboardSize.height
        keyBoardHeight =  keyboardSize.height
        UIView.animateWithDuration(0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    func keyboardWillHide(notification: NSNotification){
        
        attachButtonBottomConstraint.constant = 0
        keyBoardHeight = 0.0
        UIView.animateWithDuration(0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    func textViewShouldBecomeFirstResponder(sender:UITapGestureRecognizer){
        textView.becomeFirstResponder()
    }
    @IBAction func attachAnImage(sender:UIButton){
        if attachedImageView == nil {
            let imageToAttach = UIImage(named: "baby")
            let ratio = (imageToAttach?.size.width)! / scrollViewChild.frame.width
            let height = (imageToAttach?.size.height)! / ratio
            scrollViewChild.frame.size.height = height + textView.frame.height + imageTextViewOffset
            attachedImageView = UIImageView(frame: CGRect(x: 0, y: textView.frame.height + imageTextViewOffset, width: scrollViewChild.frame.width, height: height))
            attachedImageView.image = imageToAttach
            attachedImageView.contentMode = .ScaleAspectFit
            scrollViewChild.addSubview(attachedImageView)
            attachedImageView.userInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: Selector("textViewShouldBecomeFirstResponder:"))
            attachedImageView.addGestureRecognizer(tapGesture)
        }else{
            attachedImageView.removeFromSuperview()
            attachedImageView = nil
            scrollViewChild.frame.size.height = textView.frame.height
        }
        contentScrollView.contentSize.height = scrollViewChild.frame.size.height
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == embedHeaderSegue){
            header = segue.destinationViewController as! COATextViewHeader
            header.delegate = self
        }
    }
}

extension ViewController : UITextViewDelegate{
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = !textView.text.isEmpty
        let heightTextView = textView.contentSize.height
        var attachedImageViewHeight: CGFloat = 0.0
        if attachedImageView != nil{
            attachedImageViewHeight = attachedImageView.frame.height + imageTextViewOffset
        }
        scrollViewChild.frame.size.height = attachedImageViewHeight + heightTextView
        contentScrollView.contentSize.height = scrollViewChild.frame.size.height
        textView.frame.size.height = heightTextView
        if attachedImageView != nil {
            attachedImageView.frame.origin.y = heightTextView + imageTextViewOffset
        }
        let scrollBottom = UIScreen.mainScreen().bounds.size.height - textView.frame.height - contentScrollView.frame.origin.y
        let hiddenRegion = attachButton.frame.height + keyBoardHeight
        if(scrollBottom < hiddenRegion){
            let offset = hiddenRegion - scrollBottom
            contentScrollView.contentOffset.y = offset
        }
    }
}

extension ViewController: COATextViewHeaderProtocol{
    func anonymeCellHidden(value:Bool){
        if(value){
            headerHeightConstraint.constant = 44.0
        }else{
            headerHeightConstraint.constant = 88.0
        }
        UIView.animateWithDuration(0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
}


//Color net extension
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}