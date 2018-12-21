import 'package:teledart/model.dart';

String welcomeAboard(User user) {
  return 'Seja bem vindo ao grupo, ${user.first_name}';
}

String welcomeAboardMessage(Message message) {
  return 'Seja bem vindo ao grupo, ${message.from.first_name}';
}

String goodbye(User user) {
  String sender = user.first_name;
  return 'flws $sender';
}
