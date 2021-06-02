import UIKit
// Make fine grained interface that are client specific

/*
 This principle solves FAT interface problems of Object Oriented Programming
 A interface is called FAT when it has too many methods which contains more information than we really want.
 Lets understand Fat Interface in Protocols with an example, we have a GestureProtocol with the method didTap: which a View would be using it to handle the Gesture
 */

protocol Gesture {
    func didTap()
}

class ProfileImageView: Gesture {
    internal func didTap() {
        
    }
}

/*
 After sometime as usual the requirement came to handle more gesture like didDoubleTap: and didLongPress: so our GestureProtocol becomes
 */

protocol GestureAfter {
    func didTap()
    func didDoubleTap()
    func didLongTap()
}

class ProfileImageViewAfter: GestureAfter {
    
    internal func didTap() {
        
    }
    
    internal func didDoubleTap() {
        
    }
    
    internal func didLongTap() {
        
    }
}

/*
 Again as usual not all the Views in our app requires all the gestures some View would require only didTap: gesture in that case our UserDetailView class which would need only didTap: gesture would look like
 */

class USerDetailView: GestureAfter {
    internal func didTap() {
        
    }
    
    internal func didDoubleTap() {
        
    }
    
    internal func didLongTap() {
        
    }
}

/*
 We can solve the problem using little protocols instead of a big ones, the below code snippet shows segregation of Gesture protocols into small ones
 */

protocol TapGesture {
    func didTap()
}

protocol DoubleTapGesture {
    func didDoubleTap()
}

protocol LongTapGesture {
    func didLongTap()
}

class ProfileImageViewSolid: TapGesture, DoubleTapGesture, LongTapGesture {
    internal func didTap() {
        
    }
    
    internal func didDoubleTap() {
        
    }
    
    internal func didLongTap() {
        
    }
}

class UserDetailViewSolid: TapGesture {
    internal func didTap() {
        
    }
}

/*
 Other way we can solve this problem in swift 3.0 is using @objc key before the protocol declarations and protocol methods, which in turn gives us a options to declare a protocol method as optional, who ever wants can implement, the below code snippet shows the same.
 */

@objc protocol GestureObjC {
    @objc func didTap()
    @objc func didDoubleTap()
    @objc func didLongTap()
}

/*
 Now lets dig into Fat Interface in Classes with an example, we have view in our app which displays the user profile photo, the two classes User and UserProfileImageView classes looks like shown below.
 */

class User {
    var first : String
    var last: String
    var profileImageURL: String
    
    init(inFirst: String, inLast: String, inProfileImageURL: String) {
        first = inFirst
        last = inLast
        profileImageURL = inProfileImageURL
    }
}

class UserProfileImageView {
    func loadProfileFor(user: User) {
        
    }
}

/*
 Observing closely the above snippet, the UserProfileImageView’s loadProfileFor(user:User) function requires only the profileImageURL details, but unfortunately we are injecting too many informations in it, we can solve this problem using UserProfileViewDetails protocol which just has the information required by UserProfileImageView’s loadProfileFor(user:User), the below code will explain you detail.
 */

protocol USerProfileViewDetails {
    var profileImageURL: String { get }
}

class UserSolid: USerProfileViewDetails {
    var first : String
    var last: String
    internal var profileImageURL: String
    
    init(inFirst: String, inLast: String, inProfileImageURL: String) {
        first = inFirst
        last = inLast
        profileImageURL = inProfileImageURL
    }
}

class UserProfileImageViewSolid {
    func loadProfileFor(user: USerProfileViewDetails) {
        
    }
}

/*
 Now the UserProfileImageView’s loadProfileFor(user:UserProfileViewDetails) which is the client has only the profileImageURL information with it to display the User Profile Image, which agrees with the Interface Segregation Principle.
 */
