# -*- coding: utf-8 -*-

import os

# tg bot token
TELEGRAM_TOKEN = os.getenv('TELEGRAM_TOKEN')

# Check the token is set
if TELEGRAM_TOKEN is None:
    raise EnvironmentError("Missing TELEGRAM_TOKEN env variable!")

# chat rooms in telegram that bot would response
# CHAT_ID = os.getenv('CHAT_ID_DM')
CHAT_ID = os.getenv('CHAT_ID_GROUP_MAIN')
# VALID_CHAT_ID = []
# VALID_CHAT_ID.append(os.getenv('CHAT_ID_GROUP_MAIN'))
# VALID_CHAT_ID.append(os.getenv('CHAT_ID_GROUP_TEST'))
# VALID_CHAT_ID.append(os.getenv('CHAT_ID_DM'))

# instance under watch
INSTANCE_ID = os.getenv('INSTANCE_ID')
