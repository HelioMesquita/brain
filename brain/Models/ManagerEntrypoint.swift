import Foundation

class ManagerEntrypoint {
  private let baseURL: String
  var page = 1
  private let queryParam = "?page="

  init(baseURL: String) {
    self.baseURL = baseURL
  }

  func getCurrentURL() -> String {
    return baseURL + insertQueryParams()
  }

  func incrementPage() {
    page += 1
  }

  private func insertQueryParams() -> String {
    return queryParam + String(page)
  }
}
