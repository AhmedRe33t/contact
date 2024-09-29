part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class CheckSuccessState extends AuthState {}

class RejestsuccessState extends AuthState {}
class RejestFaluireStateUserWeakPassword extends AuthState {
 final String message;
 RejestFaluireStateUserWeakPassword({required this.message});
}
class RejestFaluireStateUserused extends AuthState {
 final String message;
 RejestFaluireStateUserused({required this.message});
}

class LoginSuccessState extends AuthState {}
class LoginFaluireStateUserNotfound extends AuthState {
 final String message;
 LoginFaluireStateUserNotfound({required this.message});
}

class LoginFaluireStateUserRongPassword extends AuthState {
 final String message;
 LoginFaluireStateUserRongPassword({required this.message});
}


class SignOutSuccessState extends AuthState {}

class PickgallerySuccessState extends AuthState {}



class AddDataSuccess extends AuthState {}

class NavGhangeSuccessState extends AuthState{}


class ChangeBottomSuccess extends AuthState{}

class LoadingPersonalDataLoading extends AuthState{}
class successPersonalDataLoading extends AuthState{}

class UpdateSuccessState extends AuthState{}
class LoadingUpdate extends AuthState{}

class DeletSuccessState extends AuthState{}
class GetFavoriteDataSuccess extends AuthState{}


class ChangeThemSuccess extends AuthState{}

 
