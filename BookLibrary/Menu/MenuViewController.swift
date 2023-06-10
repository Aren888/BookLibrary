//
//  MenuViewController.swift
//  BookLibrary
//
//  Created by Aren Musayelyan on 10.06.23.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    lazy var blurredView: UIView = {
        let containerView = UIView()
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
        customBlurEffectView.frame = self.view.bounds
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmedView.frame = self.view.bounds
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    func setupView() {
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
        dismissButton.layer.cornerRadius = 20
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
