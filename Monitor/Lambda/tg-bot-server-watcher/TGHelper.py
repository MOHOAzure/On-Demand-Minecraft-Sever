# -*- coding: utf-8 -*-

from telebot import telebot
import my_config

class TGHelper:
    
    def __init__(self, chat_id=my_config.CHAT_ID):
        # init bot
        self.bot = telebot.TeleBot(my_config.TELEGRAM_TOKEN, parse_mode=None) # You can set parse_mode by default. HTML or MARKDOWN
        self.chat_id = chat_id

    
    def __str__(self):
        pass
    
    
    def send_message(self, msg):
        self.bot.send_message(self.chat_id, msg)
