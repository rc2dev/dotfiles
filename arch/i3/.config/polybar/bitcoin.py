#!/usr/bin/env python3
# Adaptado a partir do código no GitHub do Polybar para Mercado Bitcoin,
# Rafael Cavalcanti

import requests

try:
    r = requests.get('https://www.mercadobitcoin.net/api/BTC/ticker/')
    ticker = r.json()

    print('R$ %.2f' % float(ticker['ticker']['last']))
except:
    print('Error')
