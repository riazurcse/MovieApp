//
//  Placeholder.swift
//  MovieApp
//
//  Created by Riajur Rahman on 23/2/21.
//

import UIKit

class Placeholder: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    init(text:String, image:UIImage?) {
        super.init(frame: .zero)
        loadFromXib()
        self.imageView.image = image
        self.imageView.tintColor = .black
        self.imageView.layer.cornerRadius = self.imageView.layer.frame.height / 2
        self.imageView.layer.masksToBounds = true
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.5
        paragraphStyle.alignment = .center
        let myString = NSAttributedString(string: text, attributes: [.paragraphStyle: paragraphStyle])
        self.placeHolderLabel.attributedText = myString
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromXib()
    }
    
    func loadFromXib() {
        Bundle.main.loadNibNamed("Placeholder", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
