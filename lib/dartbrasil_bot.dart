import 'package:dartbrasil_bot/services/pub_service.dart';
import 'package:dotenv/dotenv.dart' show load, env;

import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void start() {
  load();
  TeleDart bot = new TeleDart(new Telegram(env['TG_TOKEN']), new Event());

  bot.startFetching();

  bot
    .onMessage(entityType: 'bot_command', keyword: 'start')
    .listen((message) {
      bot.telegram.sendMessage(message.from.id, 'Como vai? Sou o bot do Dart Brasil no Telegram.');
    });

  bot
      .onMessage(keyword: 'dart')
      .where((Message message) => message.text.contains('telegram'))
      .listen((message) {
    bot.replyPhoto(
        message,
//            new io.File('example/dart_bird_catchs_telegram.png'),
        'https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dart_bird_catchs_telegram.png',
        caption: 'This is how the Dart Bird and Telegram are met');
  });
  
  bot
    .onCommand('search')
    .listen((message) {
      bot.telegram.sendMessage(message.from.id, PubService.searchPackage(message.text), reply_to_message_id: message.message_id);
  });

  // Inline mode
  bot.onInlineQuery().listen((inlineQuery) {
    List<InlineQueryResult> results = [
      new InlineQueryResultArticle()
        ..id = 'ping'
        ..title = 'ping'
        ..input_message_content = (new InputTextMessageContent()
          ..message_text = '*pong*'
          ..parse_mode = 'markdown'),
      new InlineQueryResultArticle()
        ..id = 'ding'
        ..title = 'ding'
        ..input_message_content = (new InputTextMessageContent()
          ..message_text = '_dong_'
          ..parse_mode = 'markdown')
    ];
    bot.answerInlineQuery(inlineQuery, results);
  });
}
