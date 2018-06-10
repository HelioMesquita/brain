import Foundation

class ManagerEntrypoint {

  private let baseURL: String
  private let queryParam = "?page="
  var page = 1

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
