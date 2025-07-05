import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  logout() async{
    emit(ProfileLoading());
    ProfileRepo.logout().then((response) {
      if (response) {
        SharedPref.removeUserInfo();
        emit(LogoutSuccess());
      } else {
        emit(ProfileError(message: 'Failed to logout'));
      }
    }).catchError((error) {
      emit(ProfileError(message: error.toString()));
    });
  }
}
