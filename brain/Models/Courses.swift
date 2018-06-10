import Foundation

struct Courses: Decodable {
	var page: Int
	var count: Int
	var items = [Item]()

  func hasNextPage() -> Bool {
    return count == 10
  }

  mutating func update(courses: Courses) {
    self.page = courses.page
    self.count = courses.count
    self.items.append(contentsOf: courses.items)
  }
}
