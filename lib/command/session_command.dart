import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSessionInformation() async {
  return SharedPreferences.getInstance();
}

Future<String> getBaseAddress() async {
  SharedPreferences sessionInfo = await getSessionInformation();
  return sessionInfo.getString('baseAddress')!;
}

Future initSession() async {
  SharedPreferences sessionInfo = await getSessionInformation();
  sessionInfo.setInt('MODE_T', 0);
  sessionInfo.setInt('MODE_A', 1);
  sessionInfo.setInt('MODE_P', 2);
  sessionInfo.setInt('MODE_TA', 10);
  sessionInfo.setInt('MODE_TP', 11);
  sessionInfo.setInt('MODE_AP', 12);
  sessionInfo.setInt('MODE_TAP', 111);

  // sessionInfo.setString('baseAddress', '10.0.2.2:8080');
  // sessionInfo.setString('baseAddress', 'localhost:8080');
  sessionInfo.setString('baseAddress', '100.70.70.131:8080');
  // sessionInfo.setString('baseAddress', '192.168.1.42:8080');
}

Future sessionToken(String token) async {
  print('token_ini - $token');

  SharedPreferences sessionInfo = await getSessionInformation();
  sessionInfo.setString('token', token);
}

Future userLogin(int id, String userName, int userType, int interactionType) async {
  SharedPreferences sessionInfo = await getSessionInformation();
  sessionInfo.setInt('id', id);
  sessionInfo.setString('userName', userName);
  sessionInfo.setInt('userType', userType);
  sessionInfo.setInt('interactionType', interactionType);
  
  print('Login successful!');
}

Future userLogout() async {
  SharedPreferences sessionInfo = await getSessionInformation();
  sessionInfo.remove('token');
  sessionInfo.remove('id');
  sessionInfo.remove('userName');
  sessionInfo.remove('userType');
  sessionInfo.remove('interactionType');

  print('Logout successful!');
}
