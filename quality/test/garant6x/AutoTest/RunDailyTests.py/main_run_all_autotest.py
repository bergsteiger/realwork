# -*- coding: windows-1251 -*-

import subprocess, datetime, os, time, re, sys, traceback, distutils.dir_util, distutils.file_util, inspect, smtplib
import win32serviceutil
from _winreg import *
from email.mime.text import MIMEText
import win32api, win32con, win32netcon, win32security, win32wnet
from lxml import etree
import pwiki, pini, psystem

def GetIniSettings():
    pass
    # Читаем настройки из ini файла
#    iniFile = 'runadaptertest.ini'
#    conf = ConfigParser.ConfigParser()
#    conf.read(iniFile)
#    startBlockSign = conf.get('RunParams', 'startBlockSign')
#    endBlockSign = conf.get('RunParams', 'endBlockSign')
#    logFile = conf.get('RunParams', 'logFile')
#    outFile = conf.get('RunParams', 'outFile')
#    logFileEncoding = conf.get('RunParams', 'logFileEncoding')
#    xmlFile = conf.get('RunParams', 'xmlFile')

def printTM(msg, functionName=inspect.stack()[0][3]):
    'Сообщение с выводом врмени и названия текущей ф-ии'
    print datetime.datetime.now(), functionName, ':', msg 

def KillProcess(processList):
    ''' Удаление всех процессов, которые могли остаться от предыдущих запусков тестов'''
    shellProcess = GLOBAL_PATH_PSTOOLS+'\\pskill %s'
    #shellProcess = 'notepad.exe'    
    for pr in processList:
        psystem.StartConsole(shellProcess % pr)
#        print datetime.datetime.now(), ' ===> KillProcess, try to kill process: ', pr
#        proc = subprocess.Popen(shellProcess % pr, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#        out = proc.stdout.readlines()
#        for line in out:
#            print datetime.datetime.now(), ' ', line
#        if proc.stderr:#            print datetime.datetime.now(), ' ERROR in KillProcess: ', proc.stderr

def AppendLog(logFile, logMsg):
    ''' Добавление зхаписи в лог'''
    with open(logFile, 'a') as lf:
        lf.write(str(datetime.datetime.now()) + logMsg)
    
def CheckLocFile(fileName, timeOut, timeOutCount):
    ''' Проверка наличия loc файла другого расписания'''
    lockedFlag = 1
    lockMsg = ''
    while timeOutCount: # количество проверок залочки файла
        if os.path.exists(fileName): # Проверка наличия lock файла
            with open(fileName) as lock:
                lockText = lock.read()
            if GLOBAL_SET_TEST_TYPE in lockText:# проверка принадлежности lock файла к текущему расписанию
                lockedFlag = 0 # lock файл для текущего теста
                break
            lockMsg = str(datetime.datetime.now())+' lock file exist'+ fileName + ':\n' +  lockText
            print lockMsg
            print datetime.datetime.now(), 'waiting', timeOut, 'sec'
            timeOutCount -= 1
            time.sleep(timeOut)
        else:
            print datetime.datetime.now(), 'creating lock file'
            AppendLog(fileName, ' LOCK FILE 4 TEST: ' + GLOBAL_SET_TEST_TYPE)
            lockedFlag = 0
            timeOutCount = 0            
    if lockedFlag: # Высылается соотв-ее письмо на qc@garant.ru от имени AutoTest@garant.ru
        mailSubj = GLOBAL_SET_TEST_TYPE + ' ' +  os.getenv('COMPUTERNAME') + ' ' + 'не запущен из за предыдущего расписания'
        mailBody = 'lock file text:\n' + lockMsg        
        SendMail(GLOBAL_FROM_MAIL, GLOBAL_TO_MAIL, mailSubj, mailBody)
        raise Exception('SHedule is locked:\n' + lockMsg) 
        
def MakeLocFile(fileName):
    ''' Создание loc файла выполнения теста в формате autotest.%COMPUTERNAME%.loc
        в тексте указывается наименование теста'''
    if not CheckLocFile(fileName):
        print str(datetime.datetime.now())+' start test '+GLOBAL_SET_TEST_TYPE
    else:
        raise Exception()
#        err= proc.stderr
#        if proc.err:
#            print 'ERROR in KillProcess: ', proc.err  
    #call common.find_kill_no_snap.bat hsdx
    #call common.find_kill.bat TestComplete.ex
    #call common.find_kill.bat drwtsn32
    #call common.find_kill.bat f1shell
def printGlobal():
    print GLOBAL_PATH_PSTOOLS
    
def GetVersion(tagFile):
    with open(tagFile) as tf:
        for line in tf:
            if 'T_GARANTF1' in line:
                ver = re.sub("^\s+|\n|\r|\s+$", '', line)
                print '"'+ver+'"'
                return ver
        return ''

def GetJournalStatus(journal_file):
    ''' Возвращает текущий статус теста
        100 - необходима подготовка
        0 - тесты закончились
        0 < количество оставшихся итераций < 100'''

def UpdateF1(conf):
    ''' Обновление версии F1 '''
    typeF1 = conf.get('GLOBAL_APP', 'F1_TYPE')
    printTM('start updating '+typeF1+' version', inspect.stack()[0][3])
    appPath = conf.get('GLOBAL_APP', 'APP_PATH')
    buildPath = conf.get('GLOBAL_PATH', 'BUILD_PATH')

    appsDst = appPath + '\\apps'
    appsSrc = ''
    settingsDst = appPath + '\\settings'
    settingsSrc = ''
    if typeF1 == 'DESKTOP':
        appsSrc = buildPath + '\\desktop\\apps'
        settingsSrc = buildPath + '\\desktop\\settings'
    elif typeF1 == 'CLIENT_SERVER':
        psystem.PsStartStopF1('stop', conf)
        appsSrc = buildPath + '\\server\\apps' # MEDIT
        settingsSrc = buildPath + '\\server\\settings' # MEDIT
    else:
        print 'UpdateF1: некорректный тип версии F1'
    if os.path.exists(appsDst): # удаление каталого со старой версией
        print 'remove old version', appsDst
        distutils.dir_util.remove_tree(appsDst)
        print 'create folder', appsDst
        distutils.dir_util.mkpath(appsDst)
    if os.path.exists(settingsDst): # удаление старых нстроек
        print 'remove old settings', settingsDst 
        distutils.dir_util.remove_tree(settingsDst)
        print 'create folder', settingsDst
        distutils.dir_util.mkpath(settingsDst)
    print 'copy new version from', appsSrc, 'to', appsDst
    distutils.dir_util.copy_tree(appsSrc, appsDst) # копирование новой версии
    print 'copy new settings from', settingsSrc, 'to', settingsDst
    distutils.dir_util.copy_tree(settingsSrc, settingsDst) # копирование новой версии
    printTM('update done', inspect.stack()[0][3])
    if typeF1 == 'CLIENT_SERVER':
        psystem.PsStartStopF1('start', conf)
        time.sleep(450)# задержка для запуска "супера"

def RedirectClient(typeF1):
    ''' Изменение секции реестра для запуска требуемого клиента
        включая декстоп версию'''
    userName = os.getenv("USERNAME")
    printTM('changing registry fo user: '+userName, inspect.stack()[0][3])
    keyVal = r'Software\Garant.F1'
    try:
        key = OpenKey(HKEY_CURRENT_USER, keyVal, 0, KEY_ALL_ACCESS)
    except:
        key = CreateKey(HKEY_CURRENT_USER, keyVal)
    if typeF1 == 'DESKTOP':
        SetValueEx(key, "-ProductId", 0, REG_SZ, '{12D1BC8A-9734-4906-8FB5-85BA197DAA05}')
        SetValueEx(key, "ApplicationAdapterOptions", 0, REG_SZ, '-ConsultingTransportConfig \"C:\\Documents and Settings\\'+userName+'\\Application Data\\Garant-Local\\settings\\garant.ini\" -GCMConfigFile \"C:\\Etalon.desktop\\garant.ini\" -GCMSettingsPath \"C:\\Documents and Settings\\'+userName+'\\Application Data\\Garant-Local\\settings\" -GPMAdapterConfigSection \"F1Server Params\" -XMLBackupPath \"C:\\Documents and Settings\\'+userName+'\\Application Data\\Garant-Local\\settings\\xmlbackup\" -XMLLoadPath1 \"C:\\Documents and Settings\\'+userName+'\\Application Data\\Garant-Local\\settings\\xmllocal\"')
        SetValueEx(key, "Locale", 0, REG_SZ, 'ru_RU.CP1251')
        SetValueEx(key, "NetEmulatorWhiteList", 0, REG_SZ, 'consulting2.garant.ru mirror.garant.ru mirror2.garant.ru proxy ')
        SetValueEx(key, "ClearGuests", 0, REG_SZ, 'false')
    elif typeF1 == 'CLIENT_SERVER':
        SetValueEx(key, "-ProductId", 0, REG_SZ, '{486D1BA5-D873-404A-9F28-BD91D1D621F0}')
        SetValueEx(key, "ApplicationAdapterOptions", 0, REG_SZ, '-GCMConfigFile \"T:\\garant.ini\" -GPMAdapterConfigSection \"F1Client Params\" -LocalePath "T:\apps"')
        SetValueEx(key, "-GCMFastestIP", 0, REG_SZ, '10.14.3.88')
        SetValueEx(key, "-GCMServerIP", 0, REG_SZ, '10.14.3.87')
    else:
        print 'RedirectClient: unknown typeF1:', typeF1
    SetValueEx(key, "FirstStart", 0, REG_SZ, 'false')
    SetValueEx(key, "Login", 0, REG_SZ, 'perf') 
    SetValueEx(key, "NetEmulatorMode", 0, REG_DWORD, 1)
    SetValueEx(key, "IsAutoLogin", 0, REG_DWORD, 0)        
    CloseKey(key)

def SendMail(GLOBAL_FROM_MAIL, GLOBAL_TO_MAIL, mailSubj, mailBody):
    msg = MIMEText(mailBody)
    msg['Subject'] = mailSubj
    msg['From'] = GLOBAL_FROM_MAIL
    msg['To'] = GLOBAL_TO_MAIL
    s = smtplib.SMTP(GLOBAL_SMTP_SERVER)
    s.sendmail(GLOBAL_FROM_MAIL, GLOBAL_TO_MAIL, msg.as_string())
    s.quit()


def LoadXMLFromFile(fpath):
    ''' Возвращает root xml объекта на основе файла
    '''
    f = open(fpath, 'r')
    tree = etree.parse(f)
    return tree.getroot()
    f.close()

def CreateXMLFile(filePath, rootXML = None):
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

def GetWikiLimitValues(et):
    ''' Вывод эталонного и граничных значений в wiki формате
    '''
    print "'" + et + "'"
    fet = float(et)
    return ( et + '(+10%='+str( "%0.2f" % (float(et)*1.1)) + '; -10%='+str("%0.2f" % (float(et)*0.9)) )

def CheckArgs(args):
    '''Проверка параметров командной строки
    - должен пристувовать тип запуска  runType = init или autorun
    init - подготовка к тесту
    autorun - выполнение очередной интерации
    - должен присутствовать путь к ini файлу с настройками
    '''
    params = {'runType' : '', 'iniFile' : ''}
    errorMsg = ''
    for arg in args:
        if 'init' in arg: params['runType'] = 'init'
        elif 'autorun' in arg: params['runType'] = 'autorun'
        elif '.ini' in arg: params['iniFile'] = arg
    for key in params:
        if not params[key]: errorMsg += ('; "%s" argument needed' % key)
    if errorMsg:
        print CheckArgs.__doc__
        print 'args:', args
        raise Exception(errorMsg)
    return params
if __name__ == "__main__":
    try:
        params = CheckArgs(sys.argv)
        print params

        TEST_MODE=1
        if TEST_MODE:
            print datetime.datetime.now(), 'TEST_MODE'

        # Ini файл для теста
        GLOBAL_INI_FILE = params['iniFile']
        conf = pini.IniManager(params['iniFile'])

        # Буква сетевого диска с проектами TC и расписанием выполнения
        GLOBAL_PATH_NET_DRIVE = 'R:'
        # Каталог c утилитами pstools
        GLOBAL_PATH_PSTOOLS = GLOBAL_PATH_NET_DRIVE + '\\.EXTERNAL\\pstools_sleep'

        # Каталог с *.py скриптами расписания
        GLOBAL_PATH_RUN_DIR = GLOBAL_PATH_NET_DRIVE + '\\PERF.7.10\\AutoTest\RunDailyTests.py'

        # Количество последних сборок\прогонов для которых формируетсся wiki файл
        GLOBAL_REPLAYS_COUNT = 11
        
        # Каталог для размещения loc файлов сигнализирующих о выполнении расписания
        GLOBAL_PATH_LOCK_DIR = GLOBAL_PATH_RUN_DIR + '\\lock'
        
        GLOBAL_BUILD_NAME = '!daily-GARANTF1-7_10'
        #GLOBAL_BUILD_NAME = '!daily-GARANTF1-7_09'
        # Каталог с дистрибутивами
        #GLOBAL_DISTRIB_PATH = '\\\\lin-store\\garant-nemesis\\deployment'
        GLOBAL_DISTRIB_PATH = conf.get('GLOBAL_PATH','DISTRIB_PATH')
        print 'GLOBAL_DISTRIB_PATH',GLOBAL_DISTRIB_PATH
        #GLOBAL_DISTRIB_PATH = '\\\\p3single05\\works\\NEMESIS\\T_GARANTF1-7_10_0_100'
        # Каталог со сборками
        #GLOBAL_BUILD_PATH=GLOBAL_DISTRIB_PATH + '\\' + GLOBAL_BUILD_NAME
        GLOBAL_BUILD_PATH = conf.get('GLOBAL_PATH','BUILD_PATH')
        print 'GLOBAL_BUILD_PATH',GLOBAL_BUILD_PATH
        # Кодичество итераций теста (задается на 1 больше, т.к. первый запуск - подготовка настроек)
        GLOBAL_GUI_COUNT = 11
        # Журнал работы теста
        GLOBAL_JOURNAL_FILE = conf.get('GLOBAL_PATH', 'JOURNAL_FILE')
        # Флаг выполнениея тестов без перезагрузки ПК
        GLOBAL_REBOOT_FLAG = 1
        # Исполняемые файлы приложения
        #GLOBAL_F1_TYPE = 'DESKTOP' # Тип установки F1 (CLIENT_SERVER FS DESKTOP)
        GLOBAL_F1_TYPE = conf.get('GLOBAL_APP','F1_TYPE')
        GLOBAL_APP_PATH = 'C:\\Etalon.desktop'
        # ПК с серверной частью системы
        #GLOBAL_SERVER_PC = 'localhost'
        GLOBAL_SERVER_PC = conf.get('GLOBAL_APP', 'SERVER_PC')
        print 'GLOBAL_SERVER_PC:', GLOBAL_SERVER_PC
        GLOBAL_SERVER_USER = 'qc'
        GLOBAL_SERVER_PASSWORD = '22222'

        # Название сервиса 
        #GLOBAL_SERVICE_NAME='Garant.Application.Server'
        GLOBAL_SERVICE_NAME=conf.get('GLOBAL_APP','SERVICE_NAME')
        
        GLOBAL_PROCESS_NAME='F1Shell.run'
        GLOBAL_START_STOP_COUNT = 10
        GLOBAL_START_STOP_TIMEOUT = 60
        
        # Тиа теста - время выполнения контекстного поиска
        GLOBAL_SET_TEST_TYPE = 'CONTEXT_SPEED'
        # Общий лог файл расписания
        GLOBAL_SET_LOGFILE = GLOBAL_PATH_LOCK_DIR + '\\' + os.getenv('COMPUTERNAME')+ '.' + GLOBAL_SET_TEST_TYPE + '.log'
        
        ##### ПАРАМЕТРЫ ЗАПУСКА СКРИПТА ПРОИЗВОДИТЕЛЬНОСТИ #####
        # Лог работы скриптов производительности
        GLOBAL_PERF_LOG_PATH = GLOBAL_PATH_LOCK_DIR
        GLOBAL_PERF_CYCLE_COUNT = 5
        GLOBAL_PERF_TC_BIN = '"C:\\Program Files\\Automated QA\\TestComplete 6\\Bin\\TestComplete.exe"'
        #GLOBAL_PERF_TC_BIN = '"C:\\Program Files\\Automated QA\\TestExecute 6\\Bin\\TestExecute.exe"'
        GLOBAL_PERF_TC_PROJ = '"' + GLOBAL_PATH_NET_DRIVE + '\\PERF.7.10\\implementation\\projects\\GUI_Perfomance_speed\\GUI_Perfomance_speed\\GUI_Perfomance_speed.mds' + '"'
        GLOBAL_PERF_LOG_DIR = GLOBAL_PATH_NET_DRIVE + '\\PERF.7.10\\[' + os.getenv('COMPUTERNAME') + ']'
        
        #GLOBAL_PERF_XML_FILE = GLOBAL_PATH_NET_DRIVE + "\\PERF.7.10\\AutoTest\\RunDailyTests.py\\perf.desktop.710.xml"
        GLOBAL_PERF_XML_FILE = conf.get('GLOBAL_PATH','XML_FILE')
        print 'GLOBAL_PERF_XML_FILE:', GLOBAL_PERF_XML_FILE
        #GLOBAL_PERF_ETALON_XML = GLOBAL_PATH_NET_DRIVE + "\\PERF.7.10\\AutoTest\\RunDailyTests.py\\perf.super.etalon.709.xml"
        GLOBAL_PERF_ETALON_XML = conf.get('GLOBAL_PATH','XML_ETALON')
        print 'GLOBAL_PERF_ETALON_XML', GLOBAL_PERF_ETALON_XML

        GLOBAL_PERF_LOGIN = 'perf'
        GLOBAL_PERF_PASSWD = 'perf'
        
        # Параметры рассылки почтовых уведомлений
        GLOBAL_SMTP_SERVER = 'smtp.garant.ru'
        GLOBAL_FROM_MAIL = 'AutoTest@garant.ru'
        GLOBAL_TO_MAIL = 'mike@garant.ru'
        #rem лог с результатами тестов
        #IF NOT EXIST %NETWORK_DRIVE%\.PERFOMANCE\[%COMPUTERNAME%]  mkdir %NETWORK_DRIVE%\.PERFOMANCE\[%COMPUTERNAME%]
        #SET LOG_DIR=%NETWORK_DRIVE%\.PERFOMANCE\[%COMPUTERNAME%]
        #SET TC_PROJECT_PATH=%NETWORK_DRIVE%\.PERFOMANCE\quality\test\garant6x\implementation\projects\GUI_Perfomance_speed\GUI_Perfomance_speed

        # Версия сборки
        GLOBAL_SET_VERSION = ''
        
        if not TEST_MODE:
            KillProcess(['hsdx','TestComplete.ex','drwtsn32','f1shell'])
        lockFile = GLOBAL_PATH_LOCK_DIR + '\\' + os.getenv("COMPUTERNAME") + '.lock'
        CheckLocFile(lockFile, 10, 600)
        # Ожидание сборки дистрибутива с проверкой наличия lock файла каждые 5 мин.
        #AppendLog(GLOBAL_SET_LOGFILE, '\n'+str(datetime.datetime.now())+' Waiting 4 distrib compilation')
        print datetime.datetime.now(), ' Waiting distrib compilation'
        while os.path.exists(conf.get('GLOBAL_PATH','DISTRIB_PATH') + '\\!daily.build-script-schedule.lock'): time.sleep(300)
        #AppendLog(GLOBAL_SET_LOGFILE, '\n'+str(datetime.datetime.now())+' Distrib compilation ready')
        print datetime.datetime.now(), ' Distrib ready'
        
        GLOBAL_SET_VERSION = GetVersion(conf.get('GLOBAL_PATH', 'BUILD_PATH')+'\\!cvs_tag')
        conf.set('VERSION', GLOBAL_SET_VERSION)
        #AppendLog(GLOBAL_SET_LOGFILE, '\n'+str(datetime.datetime.now())+' Start test version: ' + GLOBAL_SET_VERSION)
        print datetime.datetime.now(), ' Start test version: ', GLOBAL_SET_VERSION
        #AppendLog(GLOBAL_SET_LOGFILE, '\n'+str(datetime.datexecutetime.now()) + ' *** start test: '+GLOBAL_SET_TEST_TYPE+' ***\n')

        print 'sleep 5 seconds'
        time.sleep(5) # задержка при рекурсивном вызое расписания
        
        if sys.argv[1] == 'init': # Подготовка к запуску тестов
            with open (GLOBAL_JOURNAL_FILE, 'w') as jf: # Запись кол-ва итераций
                jf.write(str(GLOBAL_GUI_COUNT))
            UpdateF1(conf) # Обновление версии
            RedirectClient(conf.get('GLOBAL_APP','F1_TYPE')) # Изменение реестра для запуска тестового клиента
            main_log = 'main_run_.'+os.getenv('COMPUTERNAME')+GLOBAL_BUILD_NAME+'.log'
            if os.path.exists(main_log):
                print datetime.datetime.now(), 'removing', main_log 
                os.remove(main_log) # Удаление предыдущего лога
            if not os.path.exists(GLOBAL_PERF_LOG_DIR): # Создание каталога для логов производительности
                print datetime.datetime.now(), 'creating', GLOBAL_PERF_LOG_DIR 
                os.mkdir(GLOBAL_PERF_LOG_DIR)
                # Запуск скрипта для подготовки настроек F1
            consoleStr =  '%s /run /project:GUI_Perfomance_speed /unit:GUI_Perfomance_speed \
/routine:Prepare_GUI_Shell /exit /SilentMode %s \
log_dir=%s cur_date=%s gui_login=%s gui_password=%s' % (GLOBAL_PERF_TC_BIN,GLOBAL_PERF_TC_PROJ,GLOBAL_PERF_LOG_DIR,str(datetime.date.today()),GLOBAL_PERF_LOGIN,GLOBAL_PERF_PASSWD)
            psystem.StartConsole(consoleStr)
            if GLOBAL_REBOOT_FLAG:
                psystem.RebootPC('DESKTOP', conf) # перезагрзука клинтского\десктоп ПК вне зависимости от типа F1
            else:
                os.startfile('c:\main_no_reboot.bat')
        elif sys.argv[1] == 'autorun': # Очерендная итерация
            # Проверка количетсва оставшихся итерций
            with open (GLOBAL_JOURNAL_FILE, 'r') as jf: # Чтение кол-ва итераций
                itrCount = int(jf.readline())
                print datetime.datetime.now(), 'ierations count left:', itrCount
            itrCount -= 1
            with open (GLOBAL_JOURNAL_FILE, 'w') as jf: # Уменьшение кол-ва итераций на 1
                jf.write(str(itrCount))
            if itrCount: # Если кол-во итераций не нулевое, выполняется тест
                if GLOBAL_F1_TYPE == 'CLIENT_SERVER':
                    psystem.RebootPC(conf.get('GLOBAL_APP','F1_TYPE'), conf)
                    time.sleep(600) # Ожидание инициализации сревера F1 (10 миню для "супера")
                if GLOBAL_F1_TYPE == 'DESKTOP': # Обнуление файлового кеша перед запуском десктоп версии
                    psystem.StartConsole('ClearFileCache.exe')
                #    %TC_PATH% /run /project:GUI_Perfomance_speed /unit:GUI_Perfomance_speed /routine:Prepare_GUI_Shell /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance_speed.mds" gui_login=perf gui_password=perf log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
                consoleStr =  '%s /run /project:GUI_Perfomance_speed /unit:GUI_Perfomance_speed \
/routine:RunPerfomanceTests_speed /exit /SilentMode %s \
log_dir=%s cur_date=%s xml_file=%s build=%s gui_login=%s \
gui_password=%s' % (GLOBAL_PERF_TC_BIN,GLOBAL_PERF_TC_PROJ,GLOBAL_PERF_LOG_DIR,str(datetime.date.today()),GLOBAL_PERF_XML_FILE,GLOBAL_SET_VERSION,GLOBAL_PERF_LOGIN,GLOBAL_PERF_PASSWD)
                print datetime.datetime.now(), 'Execute:', consoleStr
                psystem.StartConsole(consoleStr)
                time.sleep(20) # Ждем завершения работы TC
                print datetime.datetime.now(), 'Execute:', 'f1send_close.exe'
                psystem.StartConsole('f1send_close.exe')
                time.sleep(7) # Ждем завершения работы F1
                if GLOBAL_REBOOT_FLAG:
                    psystem.RebootPC('DESKTOP',conf) # перезагрзука клинтского\десктоп ПК
                else:
                    os.startfile('c:\main_no_reboot.bat')
            else: # все итерации выполнены, тест закончен
                print datetime.datetime.now(), ' Removing lock file:', lockFile
                os.remove(lockFile)
                print datetime.datetime.now(), ' Removing journal file:', GLOBAL_JOURNAL_FILE
                os.remove(GLOBAL_JOURNAL_FILE)
                print datetime.datetime.now(), ' commit K Page:'
                pwiki.CreateKPage(conf) # занесение результатов в К
        else:
            raise Exception('MAIN: unknown program argument: ' + sys.argv[1])
    except Exception as e:
        traceback.print_exc(file=sys.stdout)        
        emsg = ''
        for msg in e:
            emsg += ' ' + str(msg).decode('cp1251')
        print emsg