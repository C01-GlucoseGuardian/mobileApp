class LoginInput {
  String? email;
  String? password;
  int? otp;

  LoginInput({this.email, this.password, this.otp});

  LoginInput.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    return data;
  }
}

// TODO: if needOtp is true token will be null
class LoginOutput {
  bool? needOtp;
  String? idUtente;
  int? tipoUtente;
  String? token;

  LoginOutput({this.needOtp, this.idUtente, this.tipoUtente, this.token});

  LoginOutput.fromJson(Map<String, dynamic> json) {
    needOtp = json['needOtp'];
    idUtente = json['idUtente'];
    tipoUtente = json['tipoUtente'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['needOtp'] = this.needOtp;
    data['idUtente'] = this.idUtente;
    data['tipoUtente'] = this.tipoUtente;
    data['token'] = this.token;
    return data;
  }
}

/// otp va inserito se la prima richiesta ritorna {needOtp: true}
class ChangePassword {
  String? password;
  String? newPassword;
  int? otp;

  ChangePassword({this.password, this.newPassword, this.otp});

  ChangePassword.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    newPassword = json['newPassword'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['password'] = this.password;
    data['newPassword'] = this.newPassword;
    data['otp'] = this.otp;
    return data;
  }
}
