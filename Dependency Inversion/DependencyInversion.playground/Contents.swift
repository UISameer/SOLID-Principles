import UIKit

// High level modules should not depend on low level modules both should depend on Abstractions
/*
 Lets Consider the class ConversationDataContoller which we used in Single Responsibility Principle
 */
class ConversationDataController {

    let dataBase: CoreDataController
    
    init(inDatabse: CoreDataController) {
        dataBase = inDatabse
    }

    public func getAllConversations() {
        let conversations = [Any]()
        dataBase.saveToDatabase(conversations: conversations)
    }
}

class CoreDataController {
    public func saveToDatabase(conversations: [Any]) {
        // Saves the recent downloaded conversation to Database (CoreData/SQL)
    }
}

/*
 here the CoreDataController is a low level module, its easy to reuse in other projects, the problem is with high level module ConversationDataController, its tightly coupled with CoreDataController.
we cannot use the ConversationDataContoller into another app easily because it is tightly coupled with CoreDataController or in other words it has a dependecy in low level module CoreDataController.
 We can solve this dependency using a Database Protocol. In this way ConversationDataController can use abstract protocol without caring for type of database used, lets see how the ConversationDataController will look after applying this.
 */

protocol Database {
    func saveToDatabase(conversations: [Any])
}

class ConversationDataControllerSolid {

    let dataBase: Database
    
    init(inDatabse: Database) {
        dataBase = inDatabse
    }

    public func getAllConversations() {
        let conversations = [Any]()
        dataBase.saveToDatabase(conversations: conversations)
    }
}

class CoreDataControllerSolid: Database {
    public func saveToDatabase(conversations: [Any]) {
        // Saves the recent downloaded conversation to Database (CoreData/SQL)
    }
}

/*
 Now you can reuse the ConversationDataController without any hazzle or hectic into another App which uses File Sytem Archiving for database, just by including the FileSystemArchiving class as shown below.
 */

class FileSystemArchiving: Database {
    func saveToDatabase(conversations: [Any]) {
        
    }
}
