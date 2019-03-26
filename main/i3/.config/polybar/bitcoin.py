#!/usr/bin/env python3
# Módulo para última cotação BRL/BTC do Foxbit.
# Rafael Cavalcanti

import requests

try:
    r = requests.get('https://api.blinktrade.com/api/v1/BRL/ticker?crypto_currency=BTC')
    ticker = r.json()

    print('R$ %.2f' % float(ticker['last']))
except:
    print('Error')
