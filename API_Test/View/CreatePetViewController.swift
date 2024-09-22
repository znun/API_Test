//
//  CreatePetViewController.swift
//  MVVM
//
//  Created by Mahmudul Hasan on 19/9/24.
//
import UIKit

class CreatePetViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    
    private var viewModel = PetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
       
        guard let name = nameTF.text, !name.isEmpty,
              let status = statusTF.text, !status.isEmpty else {
            print("Name and status are required")
            return
        }
        
   
        viewModel.createPet(name: name, status: status) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdPet):
                    print("Pet created with ID: \(createdPet.id ?? 0)")
                    
                
                    if let petId = createdPet.id {
                        self.viewModel.fetchPet(by: petId) { fetchResult in
                            DispatchQueue.main.async {
                                switch fetchResult {
                                case .success(let fetchedPet):
                                    print("Fetched pet details: \(fetchedPet.name), status: \(fetchedPet.status)")
                                    self.navigateToGetPetScreen()
                                case .failure(let error):
                                    print("Failed to fetch pet: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("Failed to create pet: \(error.localizedDescription)")
                }
            }
        }
    }
    
  
    func navigateToGetPetScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let getPetVC = storyboard.instantiateViewController(withIdentifier: "GetPetViewController") as! GetPetViewController
      //  DispatchQueue.main.async {
            self.navigationController?.pushViewController(getPetVC, animated: true)
      //  }
    }
}
