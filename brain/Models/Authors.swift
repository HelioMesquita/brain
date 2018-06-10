import Foundation

struct Author: Decodable {
	let name: String
	let headline: String?
	let description: String?
	let quote: String?
	let imageUrl: URL?
}
