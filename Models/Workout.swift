import Foundation

struct Workout: Identifiable, Codable {
    let id: String
    let trainerId: String
    var title: String
    var description: String
    var difficulty: WorkoutDifficulty
    var duration: Int // in minutes
    var targetMuscleGroups: [String]
    var equipment: [String]
    var videoURL: String
    var thumbnailURL: String
    var createdAt: Date
    var updatedAt: Date
    
    enum WorkoutDifficulty: String, Codable {
        case beginner
        case intermediate
        case advanced
    }
} 