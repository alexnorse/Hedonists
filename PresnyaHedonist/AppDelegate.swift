//
//  AppDelegate.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        preloadData()
        return true
    }
    
    private func preloadData() {
        let defaults = UserDefaults.standard
        let context = persistentContainer.viewContext
        
        if defaults.bool(forKey: FirstLaunchCheck.PRELOAD_DATA) == false {
            let path = Bundle.main.path(forResource: "data", ofType: "json")
            guard path != nil else {
                print(Errors.databaseError)
                return
            }
            
            let url = URL(fileURLWithPath: path!)
            
            do {
                let data = try Data(contentsOf: url)
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : Any]]
                
                for data in jsonArray {
                    let place = Place(context: context)
                    place.category    = data["category"] as? String
                    place.name        = data["name"] as? String
                    place.address     = data["address"] as? String
                    place.lat         = data["lat"] as! Double
                    place.long        = data["long"] as! Double
                    place.descript    = data["descript"] as? String
                    place.phone       = data["phone"] as? String
                    place.workhours   = data["workhours"] as? String
                    place.image       = data["image"] as? String
                    place.url         = data["url"] as? String
                }
            } catch {
                print("AppDelegate Fetch Error")
            }
            
            self.saveContext()
            defaults.setValue(true, forKey: FirstLaunchCheck.PRELOAD_DATA)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PresnyaHedonist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

