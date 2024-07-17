import HashMap "mo:base/HashMap";
import InternetIdentity "mo:base/InternetIdentity";

// Define a user record type to store user information
type User = {
  username: Text;
  password: Text;
  email: Text;
};

// Define an error type for user operations
type UserError = {
  #AuthenticationFailed;
  #UserNotFound;
  #UserAlreadyExists;
};

// Create a HashMap to store users
var userDatabase = HashMap.HashMap<Text, User>();

// Create operation - Add a new user to the system
public func addUser(username: Text, password: Text, email: Text) : async Result<(), UserError> {
  // Authenticate the user with Internet Identity
  let authenticated = await InternetIdentity.authenticate();
  if (authenticated) {
    if (userDatabase.containsKey(username)) {
      return #err(#UserAlreadyExists);
    } else {
      let newUser = {username, password, email};
      userDatabase.put(username, newUser);
      return #ok(());
    }
  } else {
    return #err(#AuthenticationFailed);
  }
}

// Read operation - Retrieve user information based on username
public func getUser(username: Text) : async Result<?User, UserError> {
  // Authenticate the user with Internet Identity
  let authenticated = await InternetIdentity.authenticate();
  if (authenticated) {
    return #ok(userDatabase.get(username));
  } else {
    return #err(#AuthenticationFailed);
  }
}

// Update operation - Update user information
public func updateUser(username: Text, newEmail: Text) : async Result<(), UserError> {
  // Authenticate the user with Internet Identity
  let authenticated = await InternetIdentity.authenticate();
  if (authenticated) {
    if (userDatabase.containsKey(username)) {
      let updatedUser = {username; password = userDatabase.get(username).password; email = newEmail};
      userDatabase.put(username, updatedUser);
      return #ok(());
    } else {
      return #err(#UserNotFound);
    }
  } else {
    return #err(#AuthenticationFailed);
  }
}

// Delete operation - Remove a user from the system
public func deleteUser(username: Text) : async Result<(), UserError> {
  // Authenticate the user with Internet Identity
  let authenticated = await InternetIdentity.authenticate();
  if (authenticated) {
    if (userDatabase.containsKey(username)) {
      userDatabase.remove(username);
      return #ok(());
    } else {
      return #err(#UserNotFound);
    }
  } else {
    return #err(#AuthenticationFailed);
  }
}
