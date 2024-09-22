//
//  PetViewModel.swift
//  MVVM
//
//  Created by Mahmudul Hasan on 18/9/24.
//

import Foundation

class PetViewModel {
    
    func createPet(name: String, status: String, completion: @escaping (Result<PetModel, Error>) -> Void) {
            APIService.shared.createPet(name: name, status: status, completion: completion)
        }

    func fetchPet(by id: Int, completion: @escaping (Result<PetModel, Error>) -> Void) {
           APIService.shared.fetchPet(by: id, completion: completion)
       }
    
    func deletePet(by id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
           APIService.shared.deletePet(by: id, completion: completion)
       }
    
}
