import Foundation

struct Item: Decodable {

  let id: String?
	let title: String?
	let subtitle: String?
	let description: String?
	let imageUrl: URL?
	var authorList = [Author]()

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case subtitle = "subtitle"
    case description = "description"
    case imageUrl = "imageUrl"
    case authorList = "authors"
  }

  func authorsName() -> String? {
    return authorList.compactMap({ (element) -> String in
      element.name
    }).joined(separator: ", ")
  }

  func aboutAuthorLabel() -> String {
    if authorList.count > 1 {
      return NSLocalizedString("aboutAuthors", comment: "")
    } else {
      return NSLocalizedString("aboutAuthor", comment: "")
    }
  }
}
