//
//  ConcentrarionThemeChooserViewController.swift
//  Concentration
//
//  Created by Paula Boules on 9/11/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class ConcentrarionThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    var lastSeg : ConcentrationViewController?
    var slpitDetailViewController : ConcentrationViewController? {
        return (splitViewController?.viewControllers.last as? ConcentrationViewController)
    }
    @IBAction func changeTheme(_ sender: Any) {
        
        if let cvc = slpitDetailViewController  {
            if let theme = (sender as? UIButton)?.currentTitle {
                cvc.theme = themes[theme]!
            }
        } else if let cvc = lastSeg {
            if let theme = (sender as? UIButton)?.currentTitle {
                cvc.theme = themes[theme]!
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            print("regular phone")
            performSegue(withIdentifier: "Theme Chooser", sender: sender)
        }
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    func splitViewController (_ splitViewController : UISplitViewController, collapseSecondary secondaryViewController:  UIViewController, onto primaryViewController: UIViewController)->Bool{
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme  == nil {
                return false
                
            }
        }
        return true
    }
    // MARK: - Navigation
    let themes = [
        "Sports": ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","⛷","🎳","⛳️"],
        "Animals": ["🐶","🦆","🐹","🐸","🐘","🦍","🐓","🐩","🐦","🦋","🐙","🐏"],
        "Faces": ["😀","😌","😎","🤓","😠","😤","😭","😰","😱","😳","😜","😇"]
    ]
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier , identifier == "Theme Chooser"{
            if let theme = (sender as? UIButton)?.currentTitle , let cvc = segue.destination as? ConcentrationViewController {
                
                print("horray")
                cvc.theme = themes[theme]!
                lastSeg = cvc
            }
        }
        
    }
 
}
