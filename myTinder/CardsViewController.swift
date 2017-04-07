//
//  CardsViewController.swift
//  myTinder
//
//  Created by Nanxin Jin on 4/6/17.
//  Copyright © 2017 jinn. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var profileView: UIImageView!
    var touched: CGPoint!
    var cardInitialCenter: CGPoint!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
            let translation = sender.translation(in: view)
            touched = sender.location(in: view)
        
        if(sender.state == .began){
            cardInitialCenter = profileView.center
        }else if(sender.state == .changed){
            if(touched.y < profileView.frame.height/2){
                profileView.center = CGPoint(x: cardInitialCenter.x + translation.x,y: cardInitialCenter.y)
                profileView.transform = CGAffineTransform(rotationAngle: CGFloat(Double(translation.x) * M_PI/540))
            }else{
                profileView.center = CGPoint(x: cardInitialCenter.x + translation.x,y: cardInitialCenter.y)
                profileView.transform = CGAffineTransform(rotationAngle: CGFloat(-1.0 * Double(translation.x) * M_PI/540))
            }
            
            if(translation.x > 50 || translation.x < -50){
                UIView.animate(withDuration: 0.4, animations: {
                    self.profileView.alpha = 0
                })
            }
        }else if(sender.state == .ended){
            profileView.center = CGPoint(x: cardInitialCenter.x, y: cardInitialCenter.y)
            profileView.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
        }
        
        
        
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        
        performSegue(withIdentifier: "segueToProfile", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("1")
        let destinationViewController = segue.destination as! ProfileViewController
        destinationViewController.image = profileView.image
    }
    
}

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


