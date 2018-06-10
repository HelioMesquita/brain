import Foundation

protocol MainPresentable: class {
  func onLoad(courses: Courses)
  func onPaginate(courses: Courses)
  func prepareToLoadNextPage()
  func onError()
}

class MainPresenter {

  let interactor: Interactor<Courses>?
  weak var delegate: MainPresentable?
  private var percentageOfInfinitScroll = 0.8

  init(interactor: Interactor<Courses>, delegate: MainPresentable) {
    self.interactor = interactor
    self.delegate = delegate
  }

  func present() {
    interactor?.execute(onSuccess: { courses in
      self.delegate?.onLoad(courses: courses)
    }, onError: {
      self.delegate?.onError()
    })
  }

  func handleInfinitScroll(actualRow: Int, totalRows: Int, paginateCondition: Double = 0.8, hasNextPage: Bool, manager: ManagerEntrypoint) {
    if Double(actualRow) == Double(totalRows)*paginateCondition && hasNextPage {
      manager.incrementPage()
      loadNextPage(url: manager.getCurrentURL())
      self.delegate?.prepareToLoadNextPage()
    }
  }

  private func loadNextPage(url: String) {
    let interactor = Interactor<Courses>(url: url)
    interactor.execute(onSuccess: { courses in
      self.delegate?.onPaginate(courses: courses)
    }, onError: {
      self.delegate?.onError()
    })
  }
}
