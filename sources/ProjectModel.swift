import Foundation

protocol ProjectModel {
	var fileList: [String] { get }
}


struct Project: ProjectModel, Codable {
	var fileList: [String]
}