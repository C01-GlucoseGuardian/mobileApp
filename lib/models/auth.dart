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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    if (otp != null) data['otp'] = otp;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['needOtp'] = needOtp;
    data['idUtente'] = idUtente;
    data['tipoUtente'] = tipoUtente;
    data['token'] = token;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['newPassword'] = newPassword;
    data['otp'] = otp;
    return data;
  }
}
