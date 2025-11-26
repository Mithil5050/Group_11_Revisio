//
//  DataStore.swift
//  Group_11_Revisio
//
//  Created by SDC-USER on 26/11/25.
//

import Foundation

struct DataStore {

    static let subjectTopics: [String: [Topic]] = [

        "Calculus": [
            Topic(name: "Partial Derivatives", lastAccessed: "2h ago", iconSystemName: "pencil.and.outline"),
            Topic(name: "Limits", lastAccessed: "7h ago", iconSystemName: "pencil.and.outline"),
            Topic(name: "Applications of derivatives", lastAccessed: "Yesterday", iconSystemName: "chart.line.uptrend.xyaxis"),
            Topic(name: "Indefinite integral", lastAccessed: "Thursday", iconSystemName: "square.root"),
            Topic(name: "Area under functions", lastAccessed: "Monday", iconSystemName: "square.fill.and.line.vertical.square")
        ],

        "Big Data": [
            Topic(name: "Hadoop Fundamentals", lastAccessed: "1h ago", iconSystemName: "server.rack"),
            Topic(name: "NoSQL Databases", lastAccessed: "3d ago", iconSystemName: "cylinder.split.2x2")
        ]
        
    ]
}
