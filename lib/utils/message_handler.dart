import 'package:dartbrasil_bot/services/welcome_service.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

Function handler = 
  (TeleDart bot, String type) => 
    (Function parser) => 
      (Message message) => 
        _messageHandler(bot, message, type, parser);

Function defaultActions = 
  (TeleDart bot) => 
    (Message message) => 
      _takeDefaultActions(bot, message);

void _messageHandler(TeleDart bot, Message message, String type, Function messageHandler) {
  switch (type) {
    case 'MESSAGE':
      bot.telegram.sendMessage(message.chat.id, messageHandler(message));
      break;
    case 'REPLY':
      bot.telegram.sendMessage(message.chat.id, messageHandler(message), reply_to_message_id: message.message_id);
      break;
    default:
      break;
  }
}

void _takeDefaultActions(TeleDart bot, Message message) {
  if (message.new_chat_members != null) {
    message.new_chat_members.forEach((User user) {
      bot.telegram.sendMessage(message.chat.id, welcomeAboard(user), reply_to_message_id: message.message_id);
    });
  }
  if (message.left_chat_member != null) {
    bot.telegram.sendMessage(message.chat.id, goodbye(message.left_chat_member));
  }
}

Function answer = (TeleDart bot) => handler(bot, 'MESSAGE');
Function reply = (TeleDart bot) => handler(bot, 'REPLY');
Function def = (TeleDart bot) => defaultActions(bot);
