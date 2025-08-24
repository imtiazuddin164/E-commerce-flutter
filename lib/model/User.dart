class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? confirmpassword;
  final String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.confirmpassword,
    this.role,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      confirmpassword: json['confirmpassword'],
      role: json['role'],
    );
  }

  // Convert User object to JSON (for registration or login)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'confirmpassword': confirmpassword,
      'role': role,
    };
  }

  //  final int? id;
  //  final String? name;
  //  final String? userName;
  //  final String? email;
  //  final int? phone;
  //  final String? password;
  //  final String? confirmPassword;

  //   User({
  //     this.id,
  //     this.name,
  //     this.userName,
  //     this.email,
  //     this.phone,
  //     this.password,
  //     this.confirmPassword,
  //   });

  //   // From JSON factory (if you're working with APIs)
  //   factory User.fromJson(Map<String, dynamic> json) {
  //     return User(
  //       id: json['id'],
  //       name: json['u_name'],
  //       userName: json['usr_name'],
  //       email: json['e_mail'],
  //       phone: json['u_phone'],
  //       password: json['u_password'],
  //       confirmPassword: json['u_confirmpassword'],
  //     );
  //   }

  //   // To JSON method (for sending to APIs)
  //   Map<String, dynamic> toJson() {
  //     return {
  //       'id': id,
  //       'u_name': name,
  //       'usr_name': userName,
  //       'e_mail': email,
  //       'u_phone': phone,
  //       'u_password': password,
  //       'u_confirmpassword': confirmPassword,
  //     };
  //   }
}
