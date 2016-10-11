//
//  ViewController2.swift
//  demoCollectionView
//
//  Created by Anh Lê Việt on 10/11/16.
//  Copyright © 2016 Anh Lê Việt. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
       
  let image = (UserDefaults.standard.object(forKey: "img") )!
        img.contentMode = .scaleAspectFit
        img.image =  UIImage(data:image as! Data)
        // Do any additional  setup after loading the view.
        
  let backs  = UIBarButtonItem(title: "Back", style: .plain, target: self,action: #selector(ViewController2.back))
      navigationItem.leftBarButtonItems = [backs]   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back () {
        self.dismiss(animated: true, completion: nil);    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
