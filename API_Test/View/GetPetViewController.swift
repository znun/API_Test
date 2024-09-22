//
//  GetPetViewController.swift
//  MVVM
//
//  Created by Mahmudul Hasan on 19/9/24.
//

import UIKit

class GetPetViewController: UIViewController
{

    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var viewModel = PetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func getButtonPressed(_ sender: Any) {
        
        guard let petIdString = idTF.text, let petId = Int(petIdString) else {
            print("Invalid Pet ID")
            return
        }
        
        viewModel.fetchPet(by: petId) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let pet):
                    self.nameLabel.text = "Pet Name: \(pet.name)"
                    self.statusLabel.text = "Pet Status: \(pet.status)"
                    
                case .failure(let error):
                    print("Failed to fetch pet: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
