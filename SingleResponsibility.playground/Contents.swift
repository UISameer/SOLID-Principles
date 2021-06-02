import UIKit

// Single Responsiblity Principle
// Each an every class you create/change should have only one responsibility

// Before
class Conversation {
}

class ConversationDataController {
    
    public func getAllConversations(callBack:(_ conversations: [Conversation]) -> Void) {
        let jsonData = requestDataFromAPI()
        let conversations = createConversations(from: jsonData!)
        saveToDatabase(conversations: conversations!)
        callBack(conversations!)
    }
    
    private func requestDataFromAPI() -> Data? {
        // Sends a api request to get conversation json data
        return nil
    }
    
    private func createConversations(from: Data) -> [Conversation]? {
        // Using json decoder decodes the json to an array of Conversation
        return nil
    }
    
    private func saveToDatabase(conversations: [Conversation]) {
        // Saves the recent downloaded conversation to Database (CoreData/SQL)
    }
}
/*
How many responsibility does this class have ?
Gets the conversation data form the API
Parse and create conversation objects from API response
Saves the conversation array to Core Data Database
 
 we can solve this problem moving the each responsibility down to different classes
 */

// After
class ConversationDataControllerSolid {

    let apiCore: NetAPICore
    let conversationFactory: ConversationFactory
    let coreDataController: CoreDataController
    
    init(api: NetAPICore, cFactory: ConversationFactory, cController: CoreDataController) {
        apiCore = api
        conversationFactory = cFactory
        coreDataController = cController
    }

    public func getAllConversations(callBack:(_ conversations: [Conversation]) -> Void) {
        let jsonData = apiCore.requestDataFromAPI()
        let conversations = conversationFactory.createConversations(from: jsonData!)
        coreDataController.saveToDatabase(conversations: conversations!)
        callBack(conversations!)
    }
}

class NetAPICore {
    public func requestDataFromAPI() -> Data? {
        // Sends a api request to get conversation json data
        return nil
    }
}

class ConversationFactory {
    public func createConversations(from: Data) -> [Conversation]? {
        // Using json decoder decodes the json to an array of Conversation
        return nil
    }
}

class CoreDataController {
    public func saveToDatabase(conversations: [Conversation]) {
        // Saves the recent downloaded conversation to Database (CoreData/SQL)
    }
}

/*
 As we can see now we have spitted the responsibility of the bigger task into 3 classes (NetAPICore, ConversationFactory, CoreDataController) which makes easy for us to deal with particular class rather than the giant ConversationDataController
 This principle helps you to keep your classes as clean as possible, and we have a advantage of testing each and every API separately, with previous implementation we would not be able to test `requestDataFromAPI()`, `parseAndCreateConversationsFrom(data:Any)`and `saveToDatabase(conversations:[Any])` because they were private functions inside ConversationDataController. Now it seems we can test each an every pieces (`NetAPICore`, `ConversationFactory`, `CoreDataController`) separately.
 */
