import 'package:flutter_easy_english/models/reset_pass_with_otp_req.dart';
import 'package:flutter_easy_english/services/i_auth_service.dart';
import 'dart:convert';
import 'package:flutter_easy_english/models/active_account_response.dart';
import 'package:flutter_easy_english/models/login_response.dart';
import 'package:flutter_easy_english/models/otp_request.dart';
import 'package:flutter_easy_english/models/update_password_request.dart';
import 'package:flutter_easy_english/models/user_dto.dart';
import 'package:flutter_easy_english/models/login_request.dart';
import 'package:flutter_easy_english/models/register_request.dart';
import 'package:flutter_easy_english/utils/auth_utils.dart';
import 'package:flutter_easy_english/utils/http_request.dart';

class AuthService extends IAuthService {
  final String SUFFIX_AUTH = '/v1/auth';

  @override
  Future<String> register(RegisterRequest registerRequest) async {
    final response = await HttpRequest.postReturnDynamic('$SUFFIX_AUTH/register', registerRequest.toJson());
    return response;
  }

  @override
  Future<ActiveAccountResponse> activateAccount(OtpRequest otpRequest) async {
    final response = await HttpRequest.putReturnDynamic('$SUFFIX_AUTH/active-account', otpRequest.toJson());
    return ActiveAccountResponse.fromJson(response);
  }

  @override
  Future<UserDTO> resendOtpToActiveAccount(String username) async {
    final response = await HttpRequest.post('$SUFFIX_AUTH/resend-otp-to-active-account/$username', {});
    return UserDTO.fromJson(response);
  }


  @override
  Future<String> generateOtpToLogin(LoginRequest loginRequest) async {
    final response = await HttpRequest.post('$SUFFIX_AUTH/generate-otp-to-login', loginRequest.toJson());
    return response['otp'];
  }

  @override
  Future<LoginResponse> loginWithOtp(OtpRequest otpRequest) async {
    final response = await HttpRequest.post('$SUFFIX_AUTH/login-with-otp', otpRequest.toJson());
    return LoginResponse.fromJson(response);
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await HttpRequest.post('$SUFFIX_AUTH/login', loginRequest.toJson());
    LoginResponse loginResponse = LoginResponse.fromJson(response);
    await AuthUtils.saveLoginResponse(loginResponse);
    return loginResponse;
  }

  @override
  Future<String> logout() async {
    final response = await HttpRequest.postReturnDynamic('$SUFFIX_AUTH/logout', {});
    return response;
  }

  @override
  Future<UserDTO> getUserByToken(String token) async {
    final response = await HttpRequest.get('$SUFFIX_AUTH/get-user-by-token', headers: {'Authorization': 'Bearer $token'});
    return UserDTO.fromJson(response);
  }

  @override
  Future<UserDTO> updateOwnPassword(UpdatePasswordRequest updatePasswordRequest) async {
    final response = await HttpRequest.put('$SUFFIX_AUTH/update-own-password', updatePasswordRequest.toJson());
    return UserDTO.fromJson(response);
  }

  @override
  Future<String> generateOtpToUpdateProfile(String username) async {
    final response = await HttpRequest.post('$SUFFIX_AUTH/generate-otp-to-update-profile/$username}', {});
    return response['message'];
  }

  @override
  Future<String> generateOtpToResetPassword(String email) async {
    var response = await HttpRequest.postReturnDynamic('$SUFFIX_AUTH/generate-otp-to-reset-password/$email', {});
    return response;
  }

  @override
  Future<String> resetPasswordWithOtp(ResetPassWithOtpReq req) async {
    var response = await HttpRequest.putReturnDynamic('$SUFFIX_AUTH/reset-password-with-otp', req.toJson());
    return response;
  }
}
