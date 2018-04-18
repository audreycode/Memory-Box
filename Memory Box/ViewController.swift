//
//  ViewController.swift
//  Memory Box
//
//  Created by Audrey Basinger on 1/15/18.
//  Copyright © 2018 Audrey Basinger. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memories = [Memory]()
    var deleteMode: Bool = false {
        didSet {
            if deleteMode {
                title = "Deleting"
                 navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
            } else {
                title = "Memory Box"
                navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMemory))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Memory Box"
        self.collectionView?.backgroundColor = UIColor(hue: 500.0, saturation: 0.0, brightness: 0.85, alpha: 1)
           let notificationCenter = NotificationCenter.default
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMemory))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMemory))
        if let image = UIImage(named: "image") {
            if let data = UIImagePNGRepresentation(image) {
                let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
                try? data.write(to: filename)
                print(filename)
            }
        }
        save()
    }
    
    @objc func deleteMemory() {
        title = "Deleting"
      deleteMode = true
    }
    
    @objc func done() {
        title = "Memory Box"
        deleteMode = false
    }
    
   @objc func addNewMemory() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self

        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        let memory = Memory(name: "", date: "", image: image, details: "")
        memories.append(memory)
        collectionView?.reloadData()
        dismiss(animated: true)
        save()
    }
    
   @objc func save() {
    if let image = UIImage(named: "image") {
        if let data = UIImagePNGRepresentation(image) {
            let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
            try? data.write(to: filename)
                print(filename)
        }
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MemoryCell
            
            let memory = memories[indexPath.item]
            
            cell.name.text = memory.name
            cell.date.text = memory.date
            cell.imageView.image = memory.image
            
            cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            cell.imageView.layer.borderWidth = 2
            cell.imageView.layer.cornerRadius = 3
            cell.layer.cornerRadius = 7
            
            return cell
        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if deleteMode {
            let ac = UIAlertController(title: "Are you sure you want to delete this memory?", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: "Delete", style: .default) { [unowned self, ac] _ in
                self.memories.remove(at: indexPath.item)
                self.collectionView?.deleteItems(at: [indexPath])
            })
            present(ac, animated: true)
        } else {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.currentMemory = memories[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
        }
    }
      
}

