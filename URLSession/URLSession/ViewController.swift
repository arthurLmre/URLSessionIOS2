//
//  ViewController.swift
//  URLSession
//
//  Created by lpiem on 13/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    private var seriesCharacter: [SeriesCharacter] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        fetchCharacters()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        
        tableView.registerReusableItem(SerieCharacterTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchCharacters() {
        let url = URL(string: "https://rickandmortyapi.com/api/character/")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                // TODO: handle Error
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                // TODO: Handle Error
                return
            }
            
            guard
                let data = data,
                let mimeType = httpResponse.mimeType,
                mimeType == "application/json" else {
                    // TODO: Handle Erro
                    return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .custom { (decoder) -> Date in
                    let dateString = try decoder.singleValueContainer().decode(String.self)
                    let date = ViewController.iso8601Formatter.date(from: dateString)!
                    
                    return date
                }
                let result = try jsonDecoder.decode(PaginatedElements<SeriesCharacter>.self, from: data)
                
                DispatchQueue.main.async {
                    self.seriesCharacter = result.decodedElements
                }
            }catch{
                //TODO: Handle error
            }
        }
        
        task.resume() //Si pas cette ligne la request ne sera jamais envoyé
    }
    
    // MARK: - TableView Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesCharacter.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableItem(SerieCharacterTableViewCell.self, at: indexPath)
        let serieCharacter = seriesCharacter[indexPath.row]
        cell.configure(title: serieCharacter.name, date: serieCharacter.creationDate, imageURL: serieCharacter.imageURL)
        return cell
    }

}

