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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Memory Box"
        self.collectionView?.backgroundColor = UIColor(hue: 0.100, saturation: 0.5, brightness: 0.85, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMemory))
             let notificationCenter = NotificationCenter.default
        let defaults = UserDefaults.standard
        
        if let savedMemories = defaults.object(forKey: "memories") as? Data {
            memories = NSKeyedUnarchiver.unarchiveObject(with: savedMemories) as! [Memory]
            notificationCenter.addObserver(self, selector: #selector(saveMemory), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        }
    }
    
    @objc func saveMemory() {
        //
    }
    
   @objc func addNewMemory() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let thisImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
   //     let imageName = UUID().uuidString
     //   let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
     //   if let jpegData = UIImageJPEGRepresentation(image, 80) {
     //       try? jpegData.write(to: imagePath)
      //      print(jpegData)
      //  }
        let memory = Memory(name: "Unknown", date: "Unknown", image: thisImage)
        memories.append(memory)
        collectionView?.reloadData()
        dismiss(animated: true)
        save()
    }
    
    func save() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: memories)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "memories")
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
        // let path = getDocumentsDirectory().appendingPathComponent(thisImage)
        // cell.imageView.image = UIImage(contentsOfFile: path.path)
            cell.imageView.image = memory.image
            
            cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            cell.imageView.layer.borderWidth = 2
            cell.imageView.layer.cornerRadius = 3
            cell.layer.cornerRadius = 7
            
            return cell
        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.currentMemory = memories[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
      
}

