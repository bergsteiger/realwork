# -*- coding: windows-1251 -*-
'''
Работа с xml файлами
'''

from lxml import etree
import time

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
    #TODO Сделать немнго позже
def GetEtalonFromXML(opId, etXML):
    ''' Получение эталонного значения операции из XML файла
    '''
    res = ''
    with open(etXML, 'r') as et:
        rootXML = LoadXMLFromFile(etXML)
        resList = rootXML.xpath('//operation[@id="%s"]/result_list' % opId)
        if resList:
            res = resList[0].get('avg_delay')
        return res

def CleanResultXML(results, xmlFile):
    '''
    Удаление из XML пустых результатов неудачных прогонов
      в качестве параметра передается кортеж из пар сборка-дата.
      Например: (('30.03.14', 'T_GARANTF1-7_09_1_010'), ('31.03.14', 'T_GARANTF1-7_09_1_011'))
    '''
    xmlOUT = xmlFile + '.out.xml'
    targetRoot = ''
    with open(xmlFile, 'r') as target_xml:
        targetRoot = etree.parse(target_xml).getroot()
    for result in results:
        print '<result:>', result
        nodeList = targetRoot.xpath("//result_list[@build='%s' and @date='%s']" % result)
        if nodeList:
            for node in nodeList:
                parentNode = node.getparent()
                print 'deleting:', '<'+parentNode.get('id')+'><'+node.tag+'>'+str(node.attrib) #TODO печатать ndoe.attrib c выравниванием\отступом
                parentNode.remove(node)
    with open(xmlOUT, 'w') as rx:
        rx.write(etree.tostring(targetRoot, pretty_print=True, encoding='utf-8'))

def CleanSMS(xmlFile):
    xmlOUT = xmlFile+'out.xml'
    targetRoot = ''
    with open(xmlFile, 'r') as target_xml:
        targetRoot = etree.parse(target_xml).getroot()
        #nodeList = targetRoot.xpath("//sms[@address='900' and contains()@body='MTS']")
        nodeList = targetRoot.xpath("//sms[@address='900']")
        #+79161916347
        if nodeList:
            for node in nodeList:
                if u'вход в систему. Не вводите пароль для отмены' in node.get('body'):
                    print node.get('body')
                    parentNode = node.getparent()
                    parentNode.remove(node)
        else: print 'Empty'
    time.sleep(1)
    flag = 0
    if flag:
        with open(xmlFile, 'w') as rx:
            rx.write(etree.tostring(targetRoot, pretty_print=True, encoding='utf-8'))
def CalcNodeAvarage(xmlFile, xPathStr):
    '''
    Вычисление среднего арифметчиеского узла
    :param xmlFile: путь к xml файлу
    :param xPathStr: выражение для поиска узла
    '''
    rootXML = LoadXMLFromFile(xmlFile)
    resList = rootXML.xpath(xPathStr)#$('//operation[@id="%s"]/result_list' % opId)
    if resList:
        for node in resList:
            print node.getparent().get('name')
            print node.get('build'), 'elements', len(node), node.get('avg_delay')
            average = 0.0
            count = 0
            for child in node:
                print child.get('delay')
                delay = float(child.get('delay'))
                if delay > 0:
                    count += 1
                    average += delay
            average = average / count
            print 'average:', average
            node.set('avg_delay', str(round(average,1)))
        with open(xmlFile, 'w') as xf:
            xf.write(etree.tostring(rootXML, pretty_print=True, encoding='utf-8'))

if __name__ == '__main__':
    xps = '//result_list[@build="%s" and @date="%s"]' % ("T_GARANTF1-7_11_0_921", "17.05.15")
    CalcNodeAvarage('R:\PERF.7.10\AutoTest\RunDailyTests\perf.bp_list_doc.710.xml', xps)