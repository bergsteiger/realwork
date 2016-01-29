# -*- coding: windows-1251 -*-
import datetime, inspect
__author__ = 'polumike'

def printTM(msg, functionName=inspect.stack()[0][3]):
    'Сообщение с выводом врмени и названия текущей ф-ии'
    print datetime.datetime.now(), functionName, ':', msg