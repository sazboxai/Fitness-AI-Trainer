import Foundation

struct TrainerProfile: Identifiable, Codable {
    let id: String
    var username: String
    var fullName: String
    var yearsOfExperience: Int
    var specialties: [String]
    var bio: String
    var profileImageURL: String?
    var certifications: [String]
    var rating: Double
    var numberOfReviews: Int
    
    init(id: String, username: String, fullName: String) {
        self.id = id
        self.username = username
        self.fullName = fullName
        self.yearsOfExperience = 0
        self.specialties = []
        self.bio = ""
        self.profileImageURL = nil
        self.certifications = []
        self.rating = 0.0
        self.numberOfReviews = 0
    }
} 