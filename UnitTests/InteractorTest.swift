import Quick
import Nimble
import Mockingjay

@testable import brain

class InteractorTests: QuickSpec {

  struct Response: Decodable {
    var title: String
    var message: String
  }

  struct InvalidResponse: Decodable {
    var invalidField: String
  }

  override func spec() {
    super.spec()
    let responseJSON: [String : Any] = ["title": "title from json", "message": "message from json"]

    describe("interactor") {
      describe("#execute") {
        let url = "www.google.com.br"

        context("when successful request") {
          beforeEach {
            self.stub(http(.get, uri: url), json(responseJSON))
          }

          context("right parser") {
            it("returns parsed response") {
              let subject = Interactor<Response>(url: url)
              var response: Response?

              subject.execute(onSuccess: { (result) in
                response = result
              }, onError: {
                XCTFail()
              })

              expect(response).toEventuallyNot(beNil(), timeout: 5.5, pollInterval: 0.5)
            }
          }
          context("wrong parser") {
            it("returns true") {
              let subject = Interactor<InvalidResponse>(url: url)
              var onErrorCalled = false

              subject.execute(onSuccess: { (result) in
                XCTFail()
              }, onError: {
                onErrorCalled = true
              })

              expect(onErrorCalled).toEventually(beTrue(), timeout: 5.5, pollInterval: 0.5)
            }
          }
        }
      }
    }
  }
}
