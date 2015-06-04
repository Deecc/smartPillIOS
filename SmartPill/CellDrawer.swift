//
//  CellDrawer.swift
//  Natal Urbano
//
//  Created by Dennis da Silva Nunes on 05/05/15.
//  Copyright (c) 2015 Phd Virtual. All rights reserved.
//

import UIKit

class CellDrawer: NSObject {
   
    func createWhiteContentInCell(cell: UITableViewCell){
        var whiteRoundedCornerView = UIView(frame: CGRectMake(10,4,cell.frame.width-20,64))
        whiteRoundedCornerView.backgroundColor = UIColor.whiteColor()
        whiteRoundedCornerView.layer.masksToBounds = false
        whiteRoundedCornerView.layer.cornerRadius = 3.0
        //whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, 1)
        //whiteRoundedCornerView.layer.shadowOpacity = 0.5
        whiteRoundedCornerView.tag = 1
        cell.contentView.addSubview(whiteRoundedCornerView)
        cell.contentView.sendSubviewToBack(whiteRoundedCornerView)
    }
    func createWhiteContentInCellWithFixSize(cell: UITableViewCell,size:CGFloat){
        var whiteRoundedCornerView = UIView(frame: CGRectMake(10,4,size-20,64))
        whiteRoundedCornerView.backgroundColor = UIColor.whiteColor()
        whiteRoundedCornerView.layer.masksToBounds = false
        whiteRoundedCornerView.layer.cornerRadius = 3.0
        //whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, 1)
        //whiteRoundedCornerView.layer.shadowOpacity = 0.5
        whiteRoundedCornerView.tag = 1
        cell.contentView.addSubview(whiteRoundedCornerView)
        cell.contentView.sendSubviewToBack(whiteRoundedCornerView)
    }
//    
//    func insertImageInCell(image:UIImage,cell:UITableViewCell){
//        let imageView = UIImageView(image: image)
//        imageView.frame = CGRectMake(15,15,40,40)
//        cell.contentView.addSubview(imageView)
//    }
    func insertDescriptionLabel(cell: UITableViewCell,text: String){
        
        var label = UILabel()
        label.frame = CGRectMake(65, 24, cell.frame.width/2, 25)
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: label.font.fontName, size: 17)
        label.text = text
        cell.contentView.addSubview(label)
    }
    func insertTimeLabel(cell: UITableViewCell,text: String){
        
        var label = UILabel()
        label.frame = CGRectMake(cell.frame.width-90, 16, 50, 25)
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: label.font.fontName, size: 17)
        label.text = text
        cell.contentView.addSubview(label)
    }
    func insertTimeLabelInVCenter(cell: UITableViewCell,text: String){
        
        var label = UILabel()
        label.frame = CGRectMake(cell.frame.width-90, 24, 50, 25)
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: label.font.fontName, size: 17)
        label.text = text
        cell.contentView.addSubview(label)
    }
    func insertQuantityLabel(cell: UITableViewCell,text: String){
        
        var label = UILabel()
        label.frame = CGRectMake(cell.frame.width-90, 36, 50, 25)
        label.textColor = UIColor.blueColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: label.font.fontName, size: 17)
        label.text = text
        cell.contentView.addSubview(label)
    }
    func insertQuantityLabelInVCenter(cell: UITableViewCell,text: String){
        
        var label = UILabel()
        label.frame = CGRectMake(cell.frame.width-90, 24, 50, 25)
        label.textColor = UIColor.blueColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: label.font.fontName, size: 17)
        label.text = text
        cell.contentView.addSubview(label)
    }

}
