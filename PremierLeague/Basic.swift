//
//  Basic.swift
//  PremierLeague
//
//  Created by QTS Coder on 8/1/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

extension UIImageView
{
    func loadImage(link: String)
    {
        let queue = DispatchQueue(label: "loadImage", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
        
        self.layer.cornerRadius = self.frame.height/2
        self.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.clipsToBounds = true
        
        queue.async {
            
            let url = URL(string: link)
            if link.contains(".svg")
            {
                //let anSVGImage:
            }
            else
            {
                do{
                    let data = try Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                } catch
                {
                    print("Cannot load Image")
                }
            }
            
        }
        
    }
}
