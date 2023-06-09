//
//  DatabaseManager.swift
//  cocktailsProject
//
//  Created by Eldar on 26/2/23.
//

import FirebaseCore
import FirebaseFirestore

public struct DatabaseCollection {
    static let cocktails = "Cocktails"
}

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init () { }
    
    private let db = Firestore.firestore()
    
    public func add(
        to collection: String,
        with data: [String:Any],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection(collection).addDocument(data: data) { error in
            guard error == nil else {
                completion( .failure(error!) )
                return
            }
            completion(.success(()))
        }
    }
}
