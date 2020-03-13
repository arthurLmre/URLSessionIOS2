//
//  SerieCharacterTableViewCell.swift
//  URLSession
//
//  Created by lpiem on 13/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import UIKit

class SerieCharacterTableViewCell: UITableViewCell {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func configure(title: String, date: Date, imageURL: URL) {
        textLabel?.text = title
        detailTextLabel?.text = SerieCharacterTableViewCell.dateFormatter.string(from: date)
        
        imageView?.image(from: imageURL)
    }
    
}
