//
//  ViewController.swift
//  COATextView
//
//  Created by coyote on 18/02/16.
//  Copyright © 2016 coyote. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBInspectable var attachButtonHolderHeight:CGFloat = 40.0
    @IBInspectable var anonymeViewHeight:CGFloat = 44.0
    @IBInspectable var attachButtonLeftMargin:CGFloat = 10.0
    @IBInspectable var inbetweenAttachButtonMargin:CGFloat = 10.0
    @IBInspectable var imageTextViewOffset:CGFloat = 10.0
    @IBInspectable var objectTextFieldFlaceholder:String = "Le titre de votre question"
    @IBInspectable var contentTextPlaceHolder:String = "Ecrivez ici ..."
    @IBInspectable var objectTextFieldFontSize:CGFloat = 15.0
    @IBInspectable var objectTextFieldFontName:String = "Helvetica"
    @IBInspectable var contentTextViewFontSize:CGFloat = 15.0
    @IBInspectable var contentTextViewFontName:String = "Helvetica"
    @IBInspectable var anonymeTexLabelPlaceHolder:String = "Votre post sera publié en anonyme"
    @IBInspectable var anonymeTextLabelFontName:String = "Helvetica"
    @IBInspectable var anonymeTextLabelFontSize:CGFloat = 13
    @IBInspectable var anonymeButtonImage:UIImage!
    @IBInspectable var attachButtonImage:UIImage!
    @IBInspectable var removeAnonymeButtonImage:UIImage!
    @IBInspectable var removeImaeButtonImage:UIImage!
    @IBInspectable var anonymeTextColor:UIColor = UIColor.blackColor()
    @IBInspectable var anonymeBgColor:UIColor = UIColor.grayColor()
    @IBInspectable var contentTextColor:UIColor = UIColor.blackColor()
    @IBInspectable var titleTextColor:UIColor = UIColor.blackColor()
    var anonymHolderView: UIView!
    var anonymeButton: UIButton!
    var headerHeightConstraint: NSLayoutConstraint!
    var anonymeHeaderView: UIView!
    var anonymeTextLabel: UILabel!
    var removeAnonymeButton: UIButton!
    var objectTextField: UITextField!
    var attachButtonBottomConstraint: NSLayoutConstraint!
    var contentScrollView: UIScrollView!
    var attachButton: UIButton!
    
    var scrollViewChild : UIView!
    var textView: PlaceholderTextView!
    var attachedImageView: UIImageView!
    var attachImageViewHolder: UIView!
    var keyBoardHeight: CGFloat = 0.0
    
    var baby = false
    var anonyme = false
    var attachHolderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(setupAnonymeHeader())
        view.addSubview(setupAttachView())
        view.addSubview(setupScrollView())
        
        setupConstraints()
    }
    func setupConstraints(){
        
        //AnonymeHeaderView leading, trailing, top and height
        NSLayoutConstraint(item: anonymeHeaderView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: anonymeHeaderView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: anonymeHeaderView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
        headerHeightConstraint = NSLayoutConstraint(item: anonymeHeaderView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: anonymeViewHeight)
        headerHeightConstraint.active = true
        
        //AnonymeHeaderView childs
        //ObjecttextField leading, trailing, buttom and height
        NSLayoutConstraint(item: objectTextField, attribute: .Leading, relatedBy: .Equal, toItem: anonymeHeaderView, attribute: .Leading, multiplier: 1.0, constant: attachButtonLeftMargin).active = true
        NSLayoutConstraint(item: objectTextField, attribute: .Trailing, relatedBy: .Equal, toItem: anonymeHeaderView, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: objectTextField, attribute: .Bottom, relatedBy: .Equal, toItem: anonymeHeaderView, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: objectTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: anonymeViewHeight).active = true
        //AnonymHolderView leading, trailing,top,height
        NSLayoutConstraint(item: anonymHolderView, attribute: .Leading, relatedBy: .Equal, toItem: anonymeHeaderView, attribute: .Leading, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: anonymHolderView, attribute: .Trailing, relatedBy: .Equal, toItem: anonymeHeaderView, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: anonymHolderView, attribute: .Top, relatedBy: .Equal, toItem: anonymeHeaderView, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: anonymHolderView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: anonymeViewHeight).active = true
        
        //AnonymeHolderView child
        //AnononymeTextLabel leading,center
        NSLayoutConstraint(item: anonymeTextLabel, attribute: .Leading, relatedBy: .Equal, toItem: anonymHolderView, attribute: .Leading, multiplier: 1.0, constant: attachButtonLeftMargin).active = true
        NSLayoutConstraint(item: anonymeTextLabel, attribute: .CenterY, relatedBy: .Equal, toItem: anonymHolderView, attribute: .CenterY, multiplier: 1.0, constant: 0.0).active = true
        //RemoveAnonymeButton trailing,top,buttom and width
        NSLayoutConstraint(item: removeAnonymeButton, attribute: .Trailing, relatedBy: .Equal, toItem: anonymHolderView, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: removeAnonymeButton, attribute: .Top, relatedBy: .Equal, toItem: anonymHolderView, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: removeAnonymeButton, attribute: .Bottom, relatedBy: .Equal, toItem: anonymHolderView, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: removeAnonymeButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: anonymeViewHeight).active = true
        
        
        
        //---------------------
        //AttachHolder constraints leading, trailing,bottom, top and height
        attachButtonBottomConstraint = NSLayoutConstraint(item: bottomLayoutGuide, attribute: .Top, relatedBy: .Equal, toItem: attachHolderView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        attachButtonBottomConstraint.active = true
        NSLayoutConstraint(item: attachHolderView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: attachHolderView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: attachHolderView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: attachButtonHolderHeight).active = true
        
        //AttachButtom subconstraints
        //AttachBottom leading, trailing, top, buttom et width
        NSLayoutConstraint(item: attachButton, attribute: .Leading, relatedBy: .Equal, toItem: attachHolderView, attribute: .Leading, multiplier: 1.0, constant: attachButtonLeftMargin).active = true
        NSLayoutConstraint(item: attachButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: attachButtonHolderHeight).active = true
        NSLayoutConstraint(item: attachButton, attribute: .Top, relatedBy: .Equal, toItem: attachHolderView, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: attachButton, attribute: .Bottom, relatedBy: .Equal, toItem: attachHolderView, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
        //AnonymeButton leading,trailng,top,Bottom et Width
        NSLayoutConstraint(item: anonymeButton, attribute: .Leading, relatedBy: .Equal, toItem: attachButton, attribute: .Trailing, multiplier: 1.0, constant: inbetweenAttachButtonMargin).active = true
        NSLayoutConstraint(item: anonymeButton, attribute: .Top, relatedBy: .Equal, toItem: attachHolderView, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: anonymeButton, attribute: .Bottom, relatedBy: .Equal, toItem: attachHolderView, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: anonymeButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: attachButtonHolderHeight).active = true
        
        
        
        //---------------------
        //ScrollView leading,trailing,top,bottom
        NSLayoutConstraint(item: contentScrollView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: contentScrollView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: contentScrollView, attribute: .Top, relatedBy: .Equal, toItem: anonymeHeaderView, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: contentScrollView, attribute: .Bottom, relatedBy: .Equal, toItem: attachHolderView, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
        self.updateViewConstraints()
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    func setupScrollChild()->UIView{
        //Init scrollViewChild
        let screenSize = UIScreen.mainScreen().bounds.size
        scrollViewChild = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 30))
        //Init compose textView
        textView = PlaceholderTextView(frame: CGRect(x: 10, y: 0, width: scrollViewChild.frame.width - 20, height: scrollViewChild.frame.height))
        textView.font = UIFont(name: contentTextViewFontName, size: contentTextViewFontSize)
        textView.placeholder = contentTextPlaceHolder
        textView.textColor = contentTextColor
        textView.tintColor = contentTextColor
        textView.editable = true
        //Add textView to scrollViewChild
        scrollViewChild.addSubview(textView)
        //Add placeholderLabel
        textView.delegate = self
        scrollViewChild.frame.size.height = textView.frame.height
        scrollViewChild.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("textViewShouldBecomeFirstResponder:"))
        scrollViewChild.addGestureRecognizer(tapGesture)
        contentScrollView.userInteractionEnabled = true
        contentScrollView.addGestureRecognizer(tapGesture)
        return scrollViewChild
    }
    func setupAttachView()->UIView{
        //Setup attachHolderView
        attachHolderView = UIView()
        attachHolderView.translatesAutoresizingMaskIntoConstraints = false
        anonymeButton = UIButton()
        anonymeButton.translatesAutoresizingMaskIntoConstraints = false
        if let anonymImage = anonymeButtonImage{
            anonymeButton.setImage(anonymImage, forState: .Normal)
        }
        
        anonymeButton.setTitle("", forState: .Normal)
        anonymeButton.addTarget(self, action: Selector("publishAnonyme:"), forControlEvents: .TouchUpInside)
        attachButton = UIButton()
        attachButton.translatesAutoresizingMaskIntoConstraints = false
        attachButton.setTitle("", forState: .Normal)
        if let attachImage = attachButtonImage{
            attachButton.setImage(attachImage, forState: .Normal)
        }
        
        attachButton.addTarget(self, action: Selector("attachAnImage:"), forControlEvents: .TouchUpInside)
        //Add subViews
        attachHolderView.addSubview(attachButton)
        attachHolderView.addSubview(anonymeButton)
        
        return attachHolderView
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        adjustContentScrollViewContentInset()
    }
    func adjustContentScrollViewContentInset()
    {
        var contentInset = self.contentScrollView.contentInset
        contentInset.bottom = 0.0
        contentInset.top = 0.0
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
    }
    
    func setupScrollView()->UIScrollView{
        contentScrollView = UIScrollView()
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.addSubview(setupScrollChild())
        return contentScrollView
    }
    func setupAnonymeHeader()->UIView{
        anonymeHeaderView = UIView()
        anonymeHeaderView.translatesAutoresizingMaskIntoConstraints = false
        objectTextField = UITextField()
        objectTextField.translatesAutoresizingMaskIntoConstraints = false
        objectTextField.font = UIFont.systemFontOfSize(15)
        
        objectTextField.placeholder = objectTextFieldFlaceholder
        objectTextField.attributedPlaceholder = NSAttributedString(string:objectTextField.placeholder!, attributes: [NSForegroundColorAttributeName: titleTextColor])
        objectTextField.textColor = titleTextColor
        objectTextField.tintColor = titleTextColor
        anonymeHeaderView.addSubview(setupAnonymeHolder())
        anonymeHeaderView.addSubview(objectTextField)
        return anonymeHeaderView
    }
    func setupAnonymeHolder()->UIView{
        anonymHolderView = UIView()
        anonymHolderView.backgroundColor = anonymeBgColor
        anonymHolderView.translatesAutoresizingMaskIntoConstraints = false
        removeAnonymeButton = UIButton()
        removeAnonymeButton.translatesAutoresizingMaskIntoConstraints = false
        if let removeImage = removeAnonymeButtonImage{
            removeAnonymeButton.setImage(removeImage, forState: .Normal)
        }
        removeAnonymeButton.setTitle("", forState: .Normal)
        removeAnonymeButton.addTarget(self, action: Selector("removeAnonyme:"), forControlEvents: .TouchUpInside)
        anonymeTextLabel = UILabel()
        anonymeTextLabel.font = UIFont(name: anonymeTextLabelFontName, size: anonymeTextLabelFontSize)
        
        anonymeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        anonymeTextLabel.text = anonymeTexLabelPlaceHolder
        anonymeTextLabel.textColor = anonymeTextColor
        anonymeTextLabel.tintColor = anonymeTextColor
        anonymeTextLabel.sizeToFit()
        anonymHolderView.addSubview(anonymeTextLabel)
        anonymHolderView.addSubview(removeAnonymeButton)
        return anonymHolderView
    }
    func publishAnonyme(sender: UIButton) {
        sender.enabled = false
        headerHeightConstraint.constant = 88.0
        anonyme = true
        UIView.animateWithDuration(0.5, animations: {
            self.anonymHolderView.alpha = 1.0
            self.view.layoutIfNeeded()
        })
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        if(headerHeightConstraint != nil){
            var headerHeight:CGFloat = 44.0
            anonymHolderView.alpha = 0.0
            if(anonyme){
                anonymHolderView.alpha = 1.0
                headerHeight = 88.0
            }
            headerHeightConstraint.constant = headerHeight
            self.view.layoutIfNeeded()
        }
    }
    
    func removeAnonyme(sender: AnyObject) {
        headerHeightConstraint.constant = 44.0
        anonyme = false
        anonymeButton.enabled = true
        UIView.animateWithDuration(0.5, animations: {
            self.anonymHolderView.alpha = 0.0
            self.view.layoutIfNeeded()
        })
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
    func removeImageView(sender:UIButton){
        attachImageViewHolder.removeFromSuperview()
        attachedImageView = nil
        scrollViewChild.frame.size.height = textView.frame.height
        contentScrollView.contentSize.height = scrollViewChild.frame.size.height
    }
    func attachAnImage(sender:UIButton){
        var imageName = "baby"
        if(baby){
            imageName = "baby1"
        }
        baby = !baby
        let imageToAttach = UIImage(named: imageName)
        let ratio = (imageToAttach?.size.width)! / scrollViewChild.frame.width
        let height = (imageToAttach?.size.height)! / ratio
        scrollViewChild.frame.size.height = height + textView.frame.height + imageTextViewOffset
        if attachImageViewHolder == nil {
            //attach holder is nil so we should unitialize it
            attachImageViewHolder = UIView(frame: CGRect(x: 0, y: textView.frame.height + imageTextViewOffset, width: scrollViewChild.frame.width, height: height))
            //AttachedImageView take all attachHolder Frame
            attachedImageView = UIImageView(frame: attachImageViewHolder.frame)
            attachedImageView.frame.origin = CGPoint(x: 0, y: 0)
            attachedImageView.image = imageToAttach
            attachedImageView.contentMode = .ScaleAspectFit
            //Add the attachedImageView as child to attachImageView holder
            attachImageViewHolder.addSubview(attachedImageView)
            //Add remove Image Button
            let removeImageButton = UIButton(frame: CGRect(x: attachedImageView.frame.width - 40, y: 0, width: 40, height: 40))
            if let removeImaeButtonImg = removeImaeButtonImage{
                removeImageButton.setImage(removeImaeButtonImg, forState: .Normal)
            }
            
            removeImageButton.addTarget(self, action: Selector("removeImageView:"), forControlEvents: .TouchUpInside)
            attachImageViewHolder.addSubview(removeImageButton)
            scrollViewChild.addSubview(attachImageViewHolder)
            attachedImageView.userInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: Selector("textViewShouldBecomeFirstResponder:"))
            attachedImageView.addGestureRecognizer(tapGesture)
        }else{
            attachImageViewHolder.frame.size.height = height
            attachedImageView.frame.size.height = height
            attachedImageView.image = imageToAttach
        }
        contentScrollView.contentSize.height = scrollViewChild.frame.size.height
    }
    func showHiddenTextView(){
        let scrollBottom = UIScreen.mainScreen().bounds.size.height - textView.frame.height - contentScrollView.frame.origin.y
        let hiddenRegion = attachHolderView.frame.height + keyBoardHeight
        if(scrollBottom < hiddenRegion){
            let offset = hiddenRegion - scrollBottom
            contentScrollView.contentOffset.y = offset
        }
    }
}

extension ViewController : UITextViewDelegate{
    func textViewDidChange(textView: UITextView) {
        let heightTextView = textView.contentSize.height
        var attachedImageViewHeight: CGFloat = 0.0
        if attachImageViewHolder != nil{
            attachedImageViewHeight = attachImageViewHolder.frame.height + imageTextViewOffset
        }
        scrollViewChild.frame.size.height = attachedImageViewHeight + heightTextView
        contentScrollView.contentSize.height = scrollViewChild.frame.size.height
        textView.frame.size.height = heightTextView
        if attachImageViewHolder != nil {
            attachImageViewHolder.frame.origin.y = heightTextView + imageTextViewOffset
        }
        showHiddenTextView()
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