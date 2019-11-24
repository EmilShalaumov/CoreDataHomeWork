//
//  ViewController.swift
//  CoreDataHomeWork
//
//  Created by Эмиль Шалаумов on 24.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let reuseId = "UITableViewCellreuseId"
    let interactor: InteractorInput
    var images: [ImageViewModel] = []
    
    let stack = CoreDataStack.shared
    
    init(interactor: InteractorInput) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Метод не реализован")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "All images"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Table view
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchfromDb()
    }
    
    func fetchfromDb() {
        stack.persistentContainer.performBackgroundTask { context in
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageModel")
            do {
                let result = try context.fetch(request)
                print(result.count)
                if result.count == 0 {
                    self.search(by: "Horse")
                }
                for data in result as! [NSManagedObject] {
                    //print(data.value(forKey: "desc") as! String)
                    self.images.append(ImageViewModel(description: data.value(forKey: "desc") as! String, image: data.value(forKey: "image") as! UIImage))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                
                print("Failed")
            }
        }
    }
    
    private func search(by searchString: String) {
        interactor.loadImageList(by: searchString) { [weak self] models in
            self?.loadImages(with: models)
        }
    }
    
    private func loadImages(with models: [ImageModel]) {
        
        let group = DispatchGroup()
        for model in models {
                
            group.enter()
            self.interactor.loadImage(at: model.path) { image in
                guard let image = image else {
                    group.leave()
                    return
                }
                
                self.stack.persistentContainer.performBackgroundTask { context in
                    let imageModel = MOImageModel(context: context)
                    imageModel.desc = model.description
                    imageModel.image = image
                    
                    try! context.save()
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.fetchfromDb()
        }
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let model = images[indexPath.row]
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageVC = ImageViewController(image: images[indexPath.row].image)
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}

