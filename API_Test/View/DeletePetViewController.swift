//
//  DeletePetViewController.swift
//  API_Test
//
//  Created by Mahmudul Hasan on 22/9/24.
//

import UIKit

class DeletePetViewController: UIViewController {
    
    @IBOutlet weak var petIdTextField: UITextField!
    
    private var viewModel = PetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let petIdText = petIdTextField.text, let petId = Int(petIdText), !petIdText.isEmpty else {
            print("Please enter a valid Pet ID")
            return
        }
        
        viewModel.deletePet(by: petId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Pet deleted successfully")
                case .failure(let error):
                    print("Failed to delete pet: \(error.localizedDescription)")
                }
            }
        }
    }
}
