// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mybook/Core/utils/api_service.dart';
// import 'package:mybook/Features/home/data/repos/home_repo_impl.dart';

// final getIt = GetIt.instance;

// void setupLocator() {
//   getIt.registerSingleton<ApiService>(
//     ApiService(Dio()),
//   );
//   getIt.registerSingleton<HomeRepoImpl>(
//     HomeRepoImpl(
//       getIt.get<ApiService>(),
//     ),
//   );
// }
