import Quick
import Nimble

@testable import brain

class ItemsTest: QuickSpec {

  override func spec() {
    super.spec()

    let author = Author(name: "name", headline: "headline", description: "description", quote: "quote", imageUrl: URL(string: "url")!)


    describe("#authorsName") {
      context("when contains one author") {
        it("returns name") {
          let subject = Item(id: "id", title: "title", subtitle: "subtitle", description: "description", imageUrl: URL(string: "url")!, authorList: [author])

          expect(subject.authorsName()).to(equal("name"))
        }
      }
      context("when contains more than one author") {
        it("returns authors name concatenated") {
          let subject = Item(id: "id", title: "title", subtitle: "subtitle", description: "description", imageUrl: URL(string: "url")!, authorList: [author, author])

          expect(subject.authorsName()).to(equal("name, name"))
        }
      }
    }

    describe("#aboutAuthorLabel") {
      context("when contains one author") {
        it("returns sobre o professor") {
          let subject = Item(id: "id", title: "title", subtitle: "subtitle", description: "description", imageUrl: URL(string: "url")!, authorList: [author])

          expect(subject.aboutAuthorLabel()).to(equal("Sobre o professor"))
        }
      }
      context("when contains more than one author") {
        it("returns sobre os professores") {
          let subject = Item(id: "id", title: "title", subtitle: "subtitle", description: "description", imageUrl: URL(string: "url")!, authorList: [author, author])

          expect(subject.aboutAuthorLabel()).to(equal("Sobre os professores"))
        }
      }
    }
  }
}
