# -*- coding: windows-1251 -*-
'''
Работа с xml файлами
'''

from lxml import etree
def LoadXMLFromFile(fpath):
    ''' Возвращает root xml объекта на основе файла
    '''
    f = open(fpath, 'r')
    tree = etree.parse(f)
    return tree.getroot()
    f.close()

def CreateXMLFile(filePath, rootXML = None):
    ''' Создание пустого xml файла-болванки толко с root узлом
    '''
    try:
        f = open(filePath, 'w')
        if rootXML:
            f.write(etree.tostring(rootXML))
        else:
            root = etree.XML('<Root xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"></Root>')
            f.writelines(etree.tostring(root, xml_declaration=True, encoding='utf-8', pretty_print=True))
    except:
        print 'Error working with file: ' + filePath
    finally:
        f.close()

def SetAttribs(node, attrTuple):
    ''' Заполнение атрибутов узла из кортежа кортежей - (('atr1','val1'),('atr2','val2'))
    '''
    for el in attrTuple:
        node.set(el[0], el[1])
