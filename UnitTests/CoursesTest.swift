import Quick
import Nimble

@testable import brain

class CoursesTest: QuickSpec {

  override func spec() {
    super.spec()

    let author = Author(name: "name", headline: "headline", description: "description", quote: "quote", imageUrl: URL(string: "url")!)
    let item = Item(id: "id", title: "title", subtitle: "subtitle", description: "description", imageUrl: URL(string: "url")!, authorList: [author])

    describe("#hasNextPage") {
      context("when returns from api 10 courses, this means that you have more courses to show") {
        it("returns true") {
          let subject = Courses(page: 1, count: 10, items: [item])

          expect(subject.hasNextPage()).to(beTrue())
        }
      }
      context("when returns from api less than 10 courses, this means that you have finished the courses") {
        it("returns false") {
          let subject = Courses(page: 1, count: 9, items: [item])

          expect(subject.hasNextPage()).to(beFalse())
        }
      }
    }

    describe("#update") {
      var subject: Courses!

      context("when receives new data from api") {

        beforeEach {
          subject = Courses(page: 1, count: 10, items: [item])
        }

        context("update page number") {
          it("returns 3") {
            let courses = Courses(page: 3, count: 5, items: [item])
            subject.update(courses: courses)

            expect(subject.page).to(equal(3))
          }
        }
        context("increment courses") {
          it("returns 4 courses") {
            let courses = Courses(page: 3, count: 5, items: [item, item, item])
            subject.update(courses: courses)

            expect(subject.items.count).to(equal(4))
          }
        }
        context("update count number") {
          it("returns 5 count") {
            let courses = Courses(page: 3, count: 5, items: [item, item, item])
            subject.update(courses: courses)

            expect(subject.count).to(equal(5))
          }
        }
      }
    }
  }
}
