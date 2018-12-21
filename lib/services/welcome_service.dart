import 'package:teledart/model.dart';

String welcomeAboard(User user) {
  return 'Seja bem vindo ao grupo, ${user.first_name}';
}

String welcomeAboardMessage(Message message) {
  switch (message.chat.type) {
    case 'private':
      return 'Olá ${message.from.first_name}, sou o bot do grupo Dart Brasil.';
      break;
    default:
      return 'Seja bem vindo ao grupo, ${message.from.first_name}';
      break;
  }
}

String goodbye(User user) {
  String sender = user.first_name;
  return 'flws $sender';
}
