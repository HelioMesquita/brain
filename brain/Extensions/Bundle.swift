import Foundation

extension Bundle {
  func getApiEntrypoint() -> String {
    return self.object(forInfoDictionaryKey: "Entrypoint") as! String
  }
}
