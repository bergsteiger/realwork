# -*- coding: windows-1251 -*-

# Формирование файла wiki.etalon.ХХX.txt на основании эталонных данных из xml
import ConfigParser, re, os, distutils.file_util
import datetime
import pxml, pini, psystem
from lxml import etree

def CreateWikiEtalon(conf): #conf - экземпляр класса IniManager
    ''' Формирование wiki текста с данными производительности на основе xml
    '''
    wikiFileHead = 'Заголовок wiki файла'
    rootXML = pxml.LoadXMLFromFile(conf.get('GLOBAL_PATH', 'XML_FILE'))
    with open(conf.get('GLOBAL_PATH', 'WIKI_FILE'), 'w') as wf:
        wf.write(conf.get('GLOBAL_PATH', 'WIKI_HEAD'))
        pcName = rootXML.xpath('//pc')[0].get('name')
        wf.write('\n' + 'h2. Эталонные задержки для стенда "%s"' % pcName)
        opList = rootXML.xpath('//operation') # Список операций xml файла
        for op in opList: # Операции для которых замеряется производительность
            opId = op.get('id')
            wf.write('\n*' + op.get('name').encode('windows-1251') + '*')
            for node in op:
                opAvgDelay = node.get('avg_delay')
                wf.write('\nЭталон\n'+'{metadata:%s.%s_etalon}'%(pcName,opId)+node.get('avg_delay')+'{metadata}')
                wf.write('\nЭталон+10%\n'+'{metadata:%s.%s_etalon_plus10}'%(pcName,opId)+str(float(node.get('avg_delay'))*1.1)+'{metadata}')
                wf.write('\nЭталон-10%\n'+'{metadata:%s.%s_etalon_minus10}'%(pcName,opId)+str(float(node.get('avg_delay'))*0.9)+'{metadata}')

def GetWikiLimitValues(et):
    ''' Вывод эталонного и граничных значений в wiki формате
    '''
    return ( et + ' (+10%='+str( "%0.2f" % (float(et)*1.1)) + '; -10%='+str("%0.2f" % (float(et)*0.9))+')' )

def CreateWikiFile(settings, strDate = ''):
    ''' Формирование wiki текста с данными производительности на основе xml
    '''
    wikiFile = settings.get('GLOBAL_PATH', 'WIKIFILE')
    wikiFileHead = settings.get('GLOBAL_PATH', 'WIKIHEAD')
    # пример wiki строки для записи в файл
    #|{metadata:TEST-05.auth_1_date}22.01.14{metadata}|{metadata:TEST-05.auth_1_build}079{metadata}|{metadata:TEST-05.auth_1}7,731{metadata}|
    wikiTempl = "|{metadata:%(Pc)s.%(Operation)s_%(Index)s_date}%(Date)s{metadata}|{metadata:%(Pc)s.%(Operation)s_%(Index)s_build}%(Build)s{metadata}|{metadata:%(Pc)s.%(Operation)s_%(Index)s}%(AvgDelay)s{metadata}|"
    # пример словаря для подстановки в строку wikiStr
    # dict(Pc='', Operation='', Index='', Date='', Build='', AvgDelay='')
    if not strDate:
        curDate = datetime.date.today()
        strDate = curDate.strftime("%d.%m.%y")
    print datetime.datetime.now(), 'processing xml for date:', strDate
    rootXML = pxml.LoadXMLFromFile(settings.get('GLOBAL_PATH', 'XML_FILE'))
    with open(wikiFile, 'w') as wf:
        wf.write(wikiFileHead)
        pcName = rootXML.xpath('//pc')[0].get('name')
        wf.write('\n*' + pcName + '*')
        opList = rootXML.xpath('//operation') # Список операций xml файла
        for op in opList: # Операции для которых замеряется производительность
            # Если нет узла для сборки за текущую дату, добалвяется пустой с нулевым средним значением
            buildVersion = settings.get('VERSION')
            curResultList = op.xpath("result_list[@date='%s' and @build='%s']" % (strDate, buildVersion))
            if not curResultList: # Создается новый узел
                print 'result_list for', strDate, 'not found'
                emptyResultList = etree.SubElement(op, "result_list")
                pxml.SetAttribs(emptyResultList, (('avg_delay', '0'),('build',buildVersion),('date',strDate)))
            wf.write('\n*' + op.get('name').encode('windows-1251') + '*')
            opEtalon = pxml.GetEtalonFromXML(op.get('id'), settings.get('GLOBAL_PATH', 'XML_ETALON')) # Эталонная задержка для операции из эталонного xml
            if opEtalon:
                opEtalon = GetWikiLimitValues(opEtalon)
            else:
                opEtalon = 'Эталон не найден'
            wf.write('\n' + '|| Дата || Сборка ||Эталон: %s|| ' % opEtalon) # Запись шапки таблицы с эталоном и 10% отклонениями
            # ПРОВЕРКА НАЛИЧИЯ УЗЛА ЗА ТЕКУЩУЮ ДАТУ, ЕСЛИ НЕТ СОЗДАТЬ ПУСТОЙ
            lowBound = 0 # количетво элементов с конца списка
            if len(op) > int(settings.get('SHEDULE', 'REPLAYS_COUNT')):
                lowBound = len(op) - int(settings.get('SHEDULE', 'REPLAYS_COUNT'))
            counter = 1
            for i in range(lowBound ,len(op)):
                wikiStr = wikiTempl % dict(Pc=pcName, Operation=op.get('id'), Index=str(counter), Date=op[i].get('date'), Build=op[i].get('build')[-3:], AvgDelay=op[i].get('avg_delay'))
                wf.write('\n'+wikiStr)
                counter += 1
    pxml.CreateXMLFile(settings.get('GLOBAL_PATH', 'XML_FILE'), rootXML)

def CreateKPage(settings):
    '''Создание wiki файла и его занесение в К
    '''
    CreateWikiFile(settings) # Создание файла с wiki текстом
    psystem.fcopy(settings.get('GLOBAL_PATH', 'KPAGETOOL'),'.') # Копируем утилиту из текущей сборки и запускаем
    psystem.StartConsole("KPageTool.exe -GCMConfigFile %s" % settings.get('GLOBAL_PATH', 'KPAGETOOL_INI'))


def KPageCommit(settings):
    '''
    Внесение страницы в К и изменение ее параметров
    :param settings: объект с настройками ini Файла
    '''
    print 'current dir:', os.getcwd()
    psystem.fcopy_l(settings.get('GLOBAL_PATH', 'KPAGETOOL'),'.') # Копируем утилиту из текущей сборки и запускаем
    psystem.StartConsole("KPageTool.exe -GCMConfigFile %s" % settings.get('GLOBAL_PATH', 'KPAGETOOL_INI'))

def KPageCommitEx(settings, operation, fileName):
    '''
    Расширенная версия KPageCommitEx с возможностью изменения меток и прикрепления вложений
    Внесение страницы в К и изменение ее параметров
    :param settings: объект с настройками ini Файла
    :param operation: операция поддерживемая утилитой KPageTool.exe
    PA_SET - установить текст страницы
    PA_SET_LABEL - установить новые лэйблы (задаются одной строкой, через запятую)
    PA_ATTACH - добавить новое вложение
    :param  fileName:
    путь к файлу с wiki текстом страницы, текстом устанавливаемых лэйблов или прикрепляемому файлу
    '''
    # изменение парамета ini файла определяющего выполняемую операцию
    kpageConf = pini.IniManager(settings.get('GLOBAL_PATH','KPAGETOOL_INI'))
    if operation not in ('PA_SET','PA_SET_LABEL','PA_ATTACH'):
        raise Exception('KPageCommitEx: incorrect parameter: operation, must be PA_SET, PA_SET_LABEL or PA_ATTACH')
    else:
        kpageConf.set_value('Common Params', '-operation', operation)
        kpageConf.set_value('Common Params', '-file', fileName)
        kpageConf.save()
    KPageCommit(settings)

def CreateKPage(settings):
    '''Создание wiki файла и его занесение в К
    '''
    CreateWikiFile(settings) # Создание файла с wiki текстом
    KPageCommit(settings)

def Test():
    rootXML = pxml.LoadXMLFromFile('perf.new.etalon.333.xml')
    opList = rootXML.xpath('//operation') # Список операций xml файла
    for op in opList: # Операции для которых замеряется производительность
        for child in op:
            print child.tag, child.attrib
        curResultList = op.xpath("result_list[@date='%s' and @build='%s']" % ('28.04.14', r"T_GARANTF1-7_09_0_333\n"))
        if curResultList: # что-то нашли
            for res in curResultList:
                print '******* TARGET:', res.tag, res.attrib
        else:
            print '******* TARGET:', 'NOT FOUND'

# if __name__ == '__main__':
#     conf = pini.IniManager('petalon.79.ini')
#     CreateWikiEtalon(conf)
if __name__ == '__main__':
    conf = pini.IniManager('main.server.710.ini')
    conf.set('VERSION', 'T_GARANTF1-7_09_0_334')
    #CreateWikiFile(conf, '24.04.14')
    CreateKPage(conf)