//
// Created by Mikhail Mulyar on 20/12/2019.
//

import Foundation
import UIKit


class AppNavigationController: UINavigationController {

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Interface orientation's
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.viewControllers.last?.supportedInterfaceOrientations ??
               UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.viewControllers.last?.preferredInterfaceOrientationForPresentation ??
               UIInterfaceOrientation.portrait
    }
    override var shouldAutorotate: Bool {
        return self.viewControllers.last?.shouldAutorotate ?? false
    }

    override var prefersStatusBarHidden: Bool {
        if let prefersHidden = self.presentedViewController?.prefersStatusBarHidden {
            return prefersHidden
        }
        if let prefersHidden = self.viewControllers.last?.prefersStatusBarHidden {
            return prefersHidden
        }
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = self.viewControllers.last?.preferredStatusBarStyle {
            return style
        }
        return .default
    }
}