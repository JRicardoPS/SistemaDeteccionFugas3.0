import TrieMap "mo:base/TrieMap";
import Hash "mo:base/Hash";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Principal "mo:base/Principal";

actor class Backend() = this {

  type UserId = Text;
  type Email = Text;
  type Password = Text;
  type User = {
    id: UserId;
    name: Text;
    email: Email;
    hashedPassword: Blob;
  };

  var users : TrieMap<UserId, User> = TrieMap.empty();

  // Función para calcular el hash SHA256 de una cadena
  func hashSHA256(input: Text): Blob {
    let buf = Buffer.Buffer<Word8>(Text.length(input));
    for (c in Text.chars(input)) {
      buf.push(Text.toUTF8(c));
    };
    return Hash.SHA256.hash(buf.toArray());
  };

  public func registerUserWithInternetIdentity(principal: Principal, name: Text, email: Email, password: Password): async { #ok : UserId } or { #err : Text } {
    let identity = principal.toText();
    if (users.containsKey(identity)) {
      return #err("User ID already exists");
    } else {
      let hashedPassword = hashSHA256(password);
      let newUser: User = {
        id = identity;
        name = name;
        email = email;
        hashedPassword = hashedPassword;
      };
      users.put(identity, newUser);
      return #ok(identity);
    }
  };

  
};