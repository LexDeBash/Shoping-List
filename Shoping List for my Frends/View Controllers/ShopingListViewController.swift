//
//  ShopingListViewController.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/5/20.
//

import UIKit
import Firebase

class ShopingListViewController: UITableViewController {
    var user: AppUser!
    var ref: DatabaseReference!
    var shopList: [ShopingList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = AppUser(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(user.uid).child("shopList")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) {[weak self] snapshot in
            var _shopList: [ShopingList] = []
            for item in snapshot.children {
                let shop = ShopingList(snapshot: item as! DataSnapshot)
                _shopList.append(shop)
            }
            self?.shopList = _shopList
            self?.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
//        cell.backgroundColor = .clear
        let listTitle = shopList[indexPath.row].title
        cell.textLabel?.text = listTitle
        
        
        return cell
    }

    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
          try  Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewList(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Новый список", message: "Добавьте список", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }

            let list = ShopingList(title: textField.text!, uid: (self?.user.uid)!)
            let listRef = self?.ref.child(list.title.lowercased())
            listRef?.setValue(list.convertedDictionary())
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
