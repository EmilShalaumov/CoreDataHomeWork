//
//  SessionFactory.swift
//  CoreDataHomeWork
//
//  Created by Эмиль Шалаумов on 24.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation

class SessionFactory {
    func createDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
}
