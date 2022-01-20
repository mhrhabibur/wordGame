//
//  ViewController.swift
//  Word Game
//
//  Created by Walid Hossain on 18/1/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
        
        super.viewDidLoad()
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let words = try? String(contentsOf: startWordURL) {
                allWords = words.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
          allWords = ["silkWorm"]
        }
        
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func addWord() {
        
        let ac = UIAlertController(title: "Add Word", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true, completion: nil)

        
    }
    
    func submit(_ answer: String) {
        usedWords.insert(answer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
  @objc  func refreshGame() {
        startGame()
    }

}

