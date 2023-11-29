import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSessionInformation() {
  return SharedPreferences.getInstance();
}

void userLogin(String userName, int userType, int interactionType) async {
  SharedPreferences sessionInfo = await getSessionInformation();
  sessionInfo.setString('userName', userName);
  sessionInfo.setInt('userType', userType);
  sessionInfo.setInt('interactionType', interactionType);

  print('login successful');
}

void userLogout() async {
  SharedPreferences sessionInfo = await getSessionInformation();
  sessionInfo.remove('userName');
  sessionInfo.remove('userType');
  sessionInfo.remove('interactionType');

  print('logout successful');
}
