# -*- coding: windows-1251 -*-

from update import *

if __name__ == '__main__':
    if ClonePatcher().run():
        print '\n���������� �ᯥ譮 �����襭�.'
        print 'Update finished successful.'
    else:
        print '\n��������! � 室� ���������� �������� �訡��. ��令��� � �㦡�� �����প� �� ���� hotline@garant.ru, �ਫ���� � ����� 䠩�� update.xml � update.log.'
        print 'Warning! Update finished with error. Contact with support by email hotline@garant.ru and send update.xml, update.log.'