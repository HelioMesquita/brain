import Quick
import Nimble

@testable import brain

class MainPresenterTest: QuickSpec {

  class DummyMainViewController: MainPresentable {
    var loaded = false
    var paginated = false
    var preparetedToShowNextPage = false
    var hasError = false

    func onLoad(courses: Courses) { loaded = true }
    func onPaginate(courses: Courses) { paginated = true }
    func prepareToLoadNextPage() { preparetedToShowNextPage = true }
    func onError() { hasError = true }
  }

  override func spec() {
    super.spec()

    let interactor = Interactor<Courses>(url: "www.google.com.br")
    let managerEntrypoint = ManagerEntrypoint(baseURL: "www.google.com.br/test")
    var dummyViewController: DummyMainViewController!

    describe("#handleInfinitScroll") {
      beforeEach {
        dummyViewController = DummyMainViewController()
      }

      context("with next page") {
        context("row higher than 79% from total list") {
          it("returns true") {
            let subject = MainPresenter(interactor: interactor, delegate: dummyViewController)
            subject.handleInfinitScroll(actualRow: 8, totalRows: 10, hasNextPage: true, manager: managerEntrypoint)

            expect(dummyViewController.preparetedToShowNextPage).to(beTrue())
          }
        }
        context("row lower than 79% from total list") {
          it("returns false") {
            let subject = MainPresenter(interactor: interactor, delegate: dummyViewController)
            subject.handleInfinitScroll(actualRow: 7, totalRows: 10, hasNextPage: true, manager: managerEntrypoint)

            expect(dummyViewController.preparetedToShowNextPage).to(beFalse())
          }
        }
      }
      context("without next page") {
        it("returns false") {
          let subject = MainPresenter(interactor: interactor, delegate: dummyViewController)
          subject.handleInfinitScroll(actualRow: 7, totalRows: 10, hasNextPage: false, manager: managerEntrypoint)

          expect(dummyViewController.preparetedToShowNextPage).to(beFalse())
        }
      }
    }
  }
}

