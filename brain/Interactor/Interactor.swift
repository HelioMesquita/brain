import Alamofire

class Interactor<S> where S: Decodable {
  var url: String
  typealias Model = S

  init(url: String) {
    self.url = url
  }

  func execute(onSuccess: @escaping (Model) -> Void, onError: @escaping () -> Void) {
    Alamofire.request(url).responseJSON { (dataResponse) in
      if let data = dataResponse.data, dataResponse.result.isSuccess {
        do {
          let model = try JSONDecoder().decode(Model.self, from: data)
          onSuccess(model)
        } catch {
          onError()
        }
      }  else {
        onError()
      }
    }
  }
}
