import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart';

class AuthKeyService {
  final Uuid uuid = Uuid();
  final LocalStorage storage = new LocalStorage('auth_key');

  /// generate a new uuid
  String _generateUuid() => uuid.v4();

  /// Check if the key is a valid UUID
  bool isKeyUUID(String key) => (key != null) ? isUUID(key) : false;

  /// Read uuid from the local storage
  ///
  /// return NULL if a auth_key doesn't exist
  String getKey() {
    String authKey = 'auth_key';
    String key = storage.getItem(authKey);
    return (this.isKeyUUID(key)) ? key : null;
  }

  /// Write a new uuid in the local storage
  ///
  /// If the storage doesn't already exist
  void setKey() {
    String value = getKey();

    if (value == null) {
      String newAuthKey = this._generateUuid();
      storage.setItem('auth_key', newAuthKey);
    }
  }
}
