//
//  DetailViewController.swift
//  Memory Box
//
//  Created by Audrey Basinger on 1/23/18.
//  Copyright © 2018 Audrey Basinger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentMemory: Memory?

    @IBOutlet weak var memoryName: UITextView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var memoryDate: UITextView!
    @IBOutlet weak var memoryDetails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMemory))
        
        detailImageView.image = currentMemory?.image
        
        memoryName.text = currentMemory?.name
        memoryDate.text = currentMemory?.date
    }
    
    
    @objc func deleteMemory() {
        // safely unwrap our webview
       // if let detailView = activeWebView {
           // if let index = stackView.arrangedSubviews.index(of: webView) {
                // we found the current webview in the stack view! Remove it from the stack view”
         //       DeatilViewController.removeArrangedSubview(currentMemory)
                
                // now remove it from the view hierarchy – this is important!
            //    detailView.removeFromSuperview()
    }
      
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

