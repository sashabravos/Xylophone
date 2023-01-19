//
//  ViewController.swift
//  Xylophone
//
//  Created by Александра Кострова on 17.01.2023.
//

import  AVFoundation
import UIKit


class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    private let color: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemIndigo, .systemBlue, .systemPurple, .systemPink]
    private let buttonNames = ["C", "D", "E", "F", "G", "A", "B", "high C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        let mainStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis  = NSLayoutConstraint.Axis.vertical
            stackView.distribution  = UIStackView.Distribution.fillEqually
            stackView.alignment = UIStackView.Alignment.fill
            stackView.spacing   = 8.0
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        
        var changeButtonWidth = 0.0
        
        for i in 0...buttonNames.count - 1 {

            let view = UIView()
            mainStackView.addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
            
            let button = UIButton()
            button.setTitle(buttonNames[i], for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            button.backgroundColor = color[i]
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: changeButtonWidth).isActive = true

            changeButtonWidth += 15
            
            button.addTarget(self, action: #selector(keyPressed), for: .touchUpInside)
        }

        
    }
        
        @objc func keyPressed(_ sender: UIButton){
            playSound(soundName: sender.currentTitle!)
            animateButton(nameOfButton: sender)
        }
        
        private func animateButton(nameOfButton: UIButton) {
            nameOfButton.alpha = 0.5
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: { nameOfButton.alpha = 1.0 })

        }
        
        private func playSound(soundName: String) {
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
    }

