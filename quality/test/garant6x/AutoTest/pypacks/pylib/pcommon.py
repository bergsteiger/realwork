# -*- coding: windows-1251 -*-
import datetime, inspect
__author__ = 'polumike'

def printTM(msg, functionName=inspect.stack()[0][3]):
    '��������� � ������� ������ � �������� ������� �-��'
    print datetime.datetime.now(), functionName, ':', msg