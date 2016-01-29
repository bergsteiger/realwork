# -*- coding: windows-1251 -*-
'''
������ � xml �������
'''

from lxml import etree
def LoadXMLFromFile(fpath):
    ''' ���������� root xml ������� �� ������ �����
    '''
    f = open(fpath, 'r')
    tree = etree.parse(f)
    return tree.getroot()
    f.close()

def CreateXMLFile(filePath, rootXML = None):
    ''' �������� ������� xml �����-�������� ����� � root �����
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
    ''' ���������� ��������� ���� �� ������� �������� - (('atr1','val1'),('atr2','val2'))
    '''
    for el in attrTuple:
        node.set(el[0], el[1])
