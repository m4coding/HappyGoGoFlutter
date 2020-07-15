
class RegisterEvent {

  static const int TYPE_REGISTER_SUCCESS = 2001;
  final int type;
  final String username;
  final String password;
  RegisterEvent(this.type, {this.username, this.password});
}