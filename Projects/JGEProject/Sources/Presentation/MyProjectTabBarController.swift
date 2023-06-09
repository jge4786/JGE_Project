import UIKit
import SnapKit
import Then

class MyProjectTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if let controllers = self.tabBarController?.viewControllers {
            controllers.forEach {
                $0.tabBarItem.image = nil
            }
        }
    }
}

extension MyProjectTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let nav = viewController as? UINavigationController,
              var nextView = nav.viewControllers.first as? TabBarItemRootViewController
        else { return }
        
        guard let selectedItem = tabBarController.tabBar.selectedItem,
              let firstIndex = tabBarController.tabBar.items?.firstIndex(of: selectedItem)
        else {
            nextView.tabId = .chat
            return
        }
        
        switch firstIndex {
        case 0:
            nextView.tabId = .chat
        case 1:
            nextView.tabId = .gpt
        case 2:
            nextView.tabId = .dalla
        default:
            nextView.tabId = .chat
        }
    }
}


