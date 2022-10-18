//
//  SceneDelegate.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var homeFlowCoordinator: HomeFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Set up dependencies before we start with any other things
        prepareDependency()
        
        // Get the window
        guard let winScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: winScene)
        
        // Instantiate root flow coordinator
        homeFlowCoordinator = HomeFlowCoordinator()
        
        // Wrap it's first page inside NavigationController and set it as a rootViewController
        let navigationController = UINavigationController()
        let homeViewController = homeFlowCoordinator!.viewController
        navigationController.viewControllers = [homeViewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func prepareDependency() {
        let di = DependencyInjector.shared
        
        // Error reporting is a key thing to keep an eye on the app health state 🩺😀
        di.register(ErrorReportingService() as ErrorReporting)
        
        // DataProviderFactory will set DataProviding to have LocalDataProvider for UITests and RemoteDataProvider for normal execution
        di.register(DataProviderFactory.dataProvider() as DataProviding)
        
        // CurrencyConverting will have CurrencyService that converts GBP to other curencies
        // This "top secret" key should be stored in some safe place and then should pe injected here as a variable, but this is out of scope for this excercise, so I do not want to spend my time on it ⏳😅
        di.register(CurrencyService(apikey: "hyzdpEaBITPtVw5ZNlRVv1x2vVA96TRU") as CurrencyConverting)
        
        // ProductsProviding will have ProductService, this is where we get the list of products
        di.register(ProductsService() as ProductsProviding)
    }
}

