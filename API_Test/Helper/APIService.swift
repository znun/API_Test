//
//  APIService.swift
//  API_Test
//
//  Created by Mahmudul Hasan on 22/9/24.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func createPet(name: String, status: String, completion: @escaping (Result<PetModel, Error>) -> Void) {
           guard let url = URL(string: "https://petstore.swagger.io/v2/pet") else {
               completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

          
           let petData: [String: Any] = [
               "name": name,
               "status": status
           ]

           do {
               let jsonData = try JSONSerialization.data(withJSONObject: petData, options: [])
               request.httpBody = jsonData
           } catch {
               completion(.failure(error))
               return
           }

           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                   return
               }
  
              do {
                    let createdPet = try JSONDecoder().decode(PetModel.self, from: data)
                    completion(.success(createdPet))
                  
              }
               catch {
                   completion(.failure(error))
               }
           }.resume()
       }
    
    func fetchPet(by id: Int, completion: @escaping (Result<PetModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://petstore.swagger.io/v2/pet/\(id)") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let pet = try JSONDecoder().decode(PetModel.self, from: data)
                completion(.success(pet))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func deletePet(by id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let url = URL(string: "https://petstore.swagger.io/v2/pet/\(id)") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(NSError(domain: "Delete failed", code: 0, userInfo: nil)))
                    return
                }
                
                completion(.success(()))
            }.resume()
        }
}
