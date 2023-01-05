import UIKit

final class AppApperance {
    static func setupNavigationBarApperance() {
        
        // MARK: - NavigationBar
        
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            // background와 shadow를 테마에 적절한 Color로 reset해줌
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = UIColor.clear
            
            // 바 텍스트 색상
            appearance.titleTextAttributes = [.foregroundColor: UIColor.systemPurple]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemPurple]
            UINavigationBar.appearance().tintColor = .systemPurple
            // 바 색상
            appearance.backgroundColor = .none
            
            // 적용
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        }
    }
    
    static func setupTabBarApperance() {
        
        // MARK: - UITabBar
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().backgroundColor = .gray
    }
}
