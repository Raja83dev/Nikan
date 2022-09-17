class UserModel {
  String? fullName;
  String? phone;
  String? idNumber;
  String? born;
  String? email;
  String? job;
  String? avatar;
  String? state;
  String? city;
  String? password;

  UserModel(
      {this.password,
      this.fullName,
      this.phone,
      this.idNumber,
      this.born,
      this.email,
      this.job,
      this.avatar,
      this.state,
      this.city});
}
