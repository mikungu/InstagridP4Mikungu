//
//  CentralViewLayout.swift
//  InstagridP4Mikungu
//
//  Created by Mikungu Giresse on 10/07/22.
//

import UIKit

class CentralViewLayout: UIView {


    @IBOutlet private var addTopLeftButton : UIButton!
    @IBOutlet private var addTopRightButton : UIButton!
    @IBOutlet private var addBottomLeftButton : UIButton!
    @IBOutlet private var addBottomRightButton : UIButton!
    
    

    enum Style {
        case wideTop, wideBottom, fourSquare
    }
    
    var style : Style = .wideTop {
        didSet {
            setStyle(style)
        }
    }
    
    private func setStyle (_ style: Style) {
        switch style {
        case .wideTop :
            addTopRightButton.isHidden = true
            addBottomRightButton.isHidden = false
        case .wideBottom:
            addTopRightButton.isHidden = false
            addBottomRightButton.isHidden = true
        case .fourSquare:
            addTopRightButton.isHidden = false
            addBottomRightButton.isHidden = false
            
        }
        
    }
    
}
