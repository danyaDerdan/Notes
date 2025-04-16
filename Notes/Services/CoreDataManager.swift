import CoreData

protocol CoreDataManagerProtocol {
    func fetchData() -> [ToDo]
    func saveData(title: String, body: String, date: String, isDone: Bool)
    func deleteToDo(title: String)
}

final class CoreDataManager: CoreDataManagerProtocol {
    private lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    private func entityForName(_ entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context) ?? NSEntityDescription()
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
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
    
    func saveData(title: String, body: String, date: String, isDone: Bool) {
        let managedObject = ToDo(entity: entityForName("ToDo"), insertInto: context)
        managedObject.title = title
        managedObject.body = body
        managedObject.date = date
        managedObject.isDone = isDone
        saveContext()
    }
    
    func fetchData() -> [ToDo] {
        var array = [ToDo]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        do {
            let results = try context.fetch(fetchRequest) as? [ToDo]
            array = results ?? []
        } catch {
            print("Error")
        }
        return array
    }
    
    func deleteToDo(title: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        do {
            let results = try context.fetch(fetchRequest) as? [ToDo]
            for result in results ?? [] {
                if result.title == title {
                    context.delete(result)
                    saveContext()
                    break
                }
            }
        } catch {
            print("Error")
        }
    }
}
