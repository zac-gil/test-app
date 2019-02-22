//
//  ViewController.swift
//  test-app
//
//  Created by Zac on 16/02/2019.
//  Copyright © 2019 zac-gil. All rights reserved.
//

import UIKit
import SnapKit

class TestMainViewController: UIViewController {

    fileprivate var titleLabel: UILabel!
    fileprivate var descriptionLabel: UILabel!
    
    fileprivate let dataProvider = ToDoProvider()
    
    var todo: ToDos? {
        didSet {
            self.todoWasUpdated()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataProvider.getToDos { (todo, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            self.todo = todo
        }
    }

}

extension TestMainViewController {
    fileprivate func setupView() {
        self.titleLabel = UILabel(frame: .zero)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.equalToSuperview().inset(70)
            make.height.greaterThanOrEqualTo(30)
        }
        self.titleLabel.backgroundColor = .magenta
        self.titleLabel.textAlignment = .center
        
        self.descriptionLabel = UILabel(frame: .zero)
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(100)
            make.height.greaterThanOrEqualTo(30)
        }
        self.descriptionLabel.backgroundColor = .orange
        self.descriptionLabel.textAlignment = .center
    }
    
    fileprivate func todoWasUpdated() {
        guard let todo = self.todo else {
            return
        }
        
        self.titleLabel.text = todo.title
        self.descriptionLabel.text = todo.description
    }
}

