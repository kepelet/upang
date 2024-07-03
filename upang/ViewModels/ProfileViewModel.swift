//
//  ProfileViewModel.swift
//  upang
//
//  Created by Alvin Miftah on 28/06/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profiles: [Profile] = []
    
    let dataService = ProfileController.shared
    
    @Published var name: String = "Upang"
    @Published var age: Int16 = 27
    @Published var email: String = "nufaisya97@gmail.com"
    
    init(){
        getAllProfile()
    }
    
    func getAllProfile() {
        profiles = dataService.read()
    }
    
    func createProfile() {
        dataService.create(name: name, email: email, age: age)
        getAllProfile()
    }
    
    func deleteProfile(profile: Profile) {
        dataService.delete(profile)
        getAllProfile()
    }
    
    func clearState() {
        name = ""
        age = 0
        email = ""
    }
}
