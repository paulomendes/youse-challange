import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class AppModuleTests: QuickSpec {
    override func spec() {
        it("should build correctly") {
            let fauxListModule = FauxListModule()
            let module = AppModule(window: UIWindow(frame: CGRect.zero),
                                   listModule: fauxListModule)
            let router = module.build()
            expect(router).to(beAKindOf(AppRouter.self))
        }
    }
}
