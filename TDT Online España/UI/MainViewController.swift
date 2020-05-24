//
//  MainViewController.swift
//  TDT Online España
//
//  Created by Álvaro López Carrillo on 14/01/2020.
//  Copyright © 2020 Iberian Apps. All rights reserved.
//

import UIKit
import Kingfisher
import AVKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionViewChannels: UICollectionView!
    @IBOutlet weak var lblEmptyList: UILabel!
    
    var allChannels = [Channel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadChannels()
        if !UserDefaults.standard.bool(forKey: "TERMS_ACCEPTED") {
            showTerms()
        }
    }
    
    func showTerms(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TermsViewController") as! TermsViewController
           self.present(vc, animated: true, completion: nil)
        }
    }
    

    func downloadChannels(){
        ApiCalls.loadChannels { (channels, statusCode) in
            if statusCode != nil{
                switch statusCode! {
                case 200:
                    self.allChannels = channels
                    self.lblEmptyList.isHidden = !channels.isEmpty
                    self.collectionViewChannels.reloadData()
                default:
                    self.lblEmptyList.text = "Error al conectar con la fuente de datos"
                    self.lblEmptyList.isHidden = false
                }
            }
        }
    }
    
    
    func playVideo(source: String){
        guard let url = URL(string: source) else {
            return
        }
        
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
        }
        
    }
    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allChannels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelsCollectionViewCell", for: indexPath) as! ChannelCollectionViewCell

        cell.logo.kf.setImage(with: URL(string: allChannels[indexPath.row].logo!))
        cell.name.text = allChannels[indexPath.row].name!

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Press on item
        playVideo(source: allChannels[indexPath.row].url!)
    }
}
