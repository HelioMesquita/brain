import Quick
import Nimble

@testable import brain

class ManagerEntrypointTest: QuickSpec {

  override func spec() {
    super.spec()

    describe("#getCurrentURL") {
      context("get url with query params based in page params") {
        it("returns url with query params") {
          let subject = ManagerEntrypoint(baseURL: "www.google.com.br/test")

          expect(subject.getCurrentURL()).to(equal("www.google.com.br/test?page=1"))
        }
        it("returns url with query params") {
          let subject = ManagerEntrypoint(baseURL: "www.google.com.br/test")
          subject.incrementPage()

          expect(subject.getCurrentURL()).to(equal("www.google.com.br/test?page=2"))
        }
      }
    }
    describe("#incrementPage") {
      context("increment page to get next page url") {
        it("returns 2") {
          let subject = ManagerEntrypoint(baseURL: "www.google.com.br/test")
          subject.incrementPage()

          expect(subject.page).to(equal(2))
        }
      }
    }
  }
}
