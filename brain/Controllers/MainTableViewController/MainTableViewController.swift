import UIKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainPresentable {
  
  @IBOutlet weak var tableView: UITableView!

  var refresher: UIRefreshControl!
  var courses: Courses?
  var presenter: MainPresenter?
  lazy var managerEntrypoint = ManagerEntrypoint(baseURL: Bundle.main.getApiEntrypoint())

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .defaultBackground
    tableView.backgroundColor = .defaultBackground
    tableView.registerCell(MainTableViewCell.self)
    navigationItem.title = NSLocalizedString("allCourses", comment: "")
    setRefresher()
    load()
  }

  func setRefresher() {
    refresher = UIRefreshControl()
    tableView.addSubview(refresher)
    refresher.addTarget(self, action: #selector(load), for: .valueChanged)
  }

  @objc func load() {
    courses = nil
    managerEntrypoint.page = 1
    refresher.beginRefreshing()
    let interactor = Interactor<Courses>(url: managerEntrypoint.getCurrentURL())
    presenter = MainPresenter(interactor: interactor, delegate: self)
    presenter?.present()
  }

  func onLoad(courses: Courses) {
    refresher.endRefreshing()
    self.courses = courses
    tableView.reloadData()
  }

  func onError() {
    refresher.endRefreshing()
    tableView.tableFooterView = nil

    let alertController = UIAlertController(title: NSLocalizedString("conectionProblem", comment: ""), message: "", preferredStyle: UIAlertControllerStyle.alert)
    let alertAction = UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""), style: .default) { _ in self.load() }
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }

  func prepareToLoadNextPage() {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    tableView.tableFooterView = activityIndicator
    activityIndicator.startAnimating()
  }

  func onPaginate(courses: Courses) {
    self.courses?.update(courses: courses)
    tableView.reloadData()
    tableView.tableFooterView = nil
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let rows = courses?.items.count else { return 0 }
    return rows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
    cell.present(item: courses?.items[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "showDetail", sender: indexPath.row)
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let courses = courses else { return }
    presenter?.handleInfinitScroll(actualRow: indexPath.row, totalRows: courses.count, hasNextPage: courses.hasNextPage(), manager: managerEntrypoint)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let viewController = segue.destination as! DetailTableViewController
    let row = sender as! Int
    let item = courses?.items[row]
    viewController.item = item
    viewController.navigationItem.title = item?.title
  }
}
