import UIKit

class ViewController: UIViewController {
    var metalView: MetalView!

    override func viewDidLoad() {
        super.viewDidLoad()
        metalView = MetalView(frame: view.bounds)
        view.addSubview(metalView)
    }
}
