//
//  ViewController.swift
//  CowsBulls
//
//  Created by Abraham Abreu on 17/03/22.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    var answer = ""
    var guesses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }

    @IBAction func submitGuess(_ sender: NSButton) {
        
        let guessString = guess.stringValue
        guard Set(guessString).count == 4 else { return }
        guard guessString.count == 4 else { return }
        
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
        guesses.insert(guessString, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        let resultString = result(for: guessString)
        
        if resultString.contains("4b") {
            let alert = NSAlert()
            alert.messageText = "You win"
            alert.informativeText = "Congratulations! \(evaluateWin()) Click OK to play again."
            alert.runModal()
            startNewGame()
        }
    }
    
    func evaluateWin() -> String {
        var typeOfWinner = ""
        if guesses.count < 10 {
            typeOfWinner = "God Player"
        } else if guesses.count > 10 && guesses.count < 20 {
            typeOfWinner = "Champion Player"
        } else {
            typeOfWinner = "Average Player"
        }
        return typeOfWinner
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0
        
        let guessLetters = Array(guess)
        let answerLetters = Array(answer)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                cows += 1
            }
        }
        
        return "\(bulls)b\(cows)c"
    }
    
    func startNewGame() {
        guess.stringValue = ""
        guesses.removeAll()
        answer = ""
        var numbers = Array(0...9)
        numbers.shuffle()
        for _ in 0..<4 {
            answer.append(String(numbers.removeLast()))
        }
        tableView.reloadData()
    }
}

// MARK: - Table view delegate and datasource.

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        guesses.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier:  tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        if tableColumn?.title == "Guess" {
            vw.textField?.stringValue = guesses[row]
        } else {
            vw.textField?.stringValue = result(for: guesses[row])
        }
        return vw
    }
}
