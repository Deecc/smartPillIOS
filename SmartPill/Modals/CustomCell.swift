//
//  CustomCell.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 04/06/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    func createWhiteContentInCell(){
        var whiteRoundedCornerView = UIView(frame: CGRectMake(10,4,self.frame.width-20,64))
        whiteRoundedCornerView.backgroundColor = UIColor.whiteColor()
        whiteRoundedCornerView.layer.masksToBounds = false
        whiteRoundedCornerView.layer.cornerRadius = 3.0
        whiteRoundedCornerView.tag = 1
        self.contentView.addSubview(whiteRoundedCornerView)
        self.contentView.sendSubviewToBack(whiteRoundedCornerView)
    }
    func createWhiteContentInCellWithFixSize(size:CGFloat){
        var whiteRoundedCornerView = UIView(frame: CGRectMake(10,4,size-20,64))
        whiteRoundedCornerView.backgroundColor = UIColor.whiteColor()
        whiteRoundedCornerView.layer.masksToBounds = false
        whiteRoundedCornerView.layer.cornerRadius = 3.0
        whiteRoundedCornerView.tag = 1
        self.contentView.addSubview(whiteRoundedCornerView)
        self.contentView.sendSubviewToBack(whiteRoundedCornerView)
    }
}
