import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/core/view_models/bottom_nav_viewmodel.dart';
import 'package:footsapp/core/view_models/user_auth_viewmodel.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:footsapp/data/api_providers/login_registration/login_reg_api.dart';
import 'package:footsapp/data/api_providers/login_registration/login_reg_api_impl.dart';
import 'package:footsapp/data/api_providers/profile_management/profile_manage_api.dart';
import 'package:footsapp/data/api_providers/profile_management/profile_manage_api_impl.dart';
import 'package:footsapp/data/local_storage_providers/login_registration/login_reg_storage.dart';
import 'package:footsapp/data/local_storage_providers/login_registration/login_reg_storage_impl.dart';
import 'package:footsapp/data/repo_services/login_registration/login_reg_repo.dart';
import 'package:footsapp/data/repo_services/login_registration/login_reg_repo_impl.dart';
import 'package:footsapp/data/repo_services/profile_management/profile_manage_repo.dart';
import 'package:footsapp/data/repo_services/profile_management/profile_manage_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // view models
  sl.registerLazySingleton<BottomNavViewModel>(() => BottomNavViewModel(
        pageIndex: 0,
      ));
  sl.registerLazySingleton<UserAuthViewModel>(() => UserAuthViewModel());
  sl.registerLazySingleton<UserProfileViewModel>(() => UserProfileViewModel());

  //! Repositories
  sl.registerLazySingleton<LoginRegRepo>(() => LoginRegRepoImpl());
  sl.registerLazySingleton<ProfileManageRepo>(() => ProfileManageRepoImpl());

  //! Api Providers
  sl.registerLazySingleton<LoginRegApi>(() => LoginRegApiImpl());
  sl.registerLazySingleton<ProfileManageApi>(() => ProfileManageApiImpl());

  //! Local Storage
  sl.registerLazySingleton<LoginRegStorage>(() => LoginRegStorageImpl());

  //! External/Utils
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SharedPrefUtil>(() => SharedPrefUtil());
}
