# -*- coding: windows-1251 -*-

import subprocess, datetime, distutils.file_util, re, os, win32security, win32con, psutil, shutil
import win32serviceutil, time, psystem, pcommon

def StartConsole(app):
    ''' Запуск консольных приложений'''
    res = []
    print datetime.datetime.now(), app
    proc = subprocess.Popen(app, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in iter(proc.stdout.readline, ''):
        print datetime.datetime.now(), ' ', line
        res.append(line)
    if proc.stderr:
        print datetime.datetime.now(), 'ERROR running', app,  'at StartConsole: ', proc.stderr
    return res

def fcopy(src, dest): # Обертка для копирования файлов
    distutils.file_util.copy_file(src, dest)

def fcopy_l(src, dest):
    '''
    Копирование с логированием операции
    '''
    print '%s copying from %s to %s' % ( datetime.datetime.now(), src, dest)
    fcopy(src, dest)

def fmove_l(src, dest):
    '''
    Пересно файла с логированием операции
    '''
    print '%s moving from %s to %s' % (datetime.datetime.now(), src, dest)
    distutils.file_util.move_file(src, dest)

def FolderBackup(fromPath, toPath):
    '''
    Создание резервной копии обновляемой базы
    '''
    print datetime.datetime.now(), 'clean folder:', toPath
    filelist = os.listdir(toPath)
    for f in filelist:
        pcommon.printTM('removing %s' % f)
        os.remove(toPath+'\\'+f)
    print datetime.datetime.now(), 'start copy from', fromPath, 'to', toPath
    distutils.dir_util.copy_tree(fromPath, toPath) # копирование новой версии
    print datetime.datetime.now(), 'finish copy from', fromPath, 'to', toPath

def ProcessExist(pName):
    '''
    Проверка существования процесса
    '''
    result = False
    for p in psutil.get_process_list():
        try:
            if p.name == pName:
                result =  True
                break
        except psutil._error.AccessDenied:
            pass #print "ProcessExist: can't get Process name. pid:", p.pid
    return result

def ServiceManager(action, machine, service):
    if action == 'stop':
        win32serviceutil.StopService(service, machine)
    elif action == 'start':
        win32serviceutil.StartService(service, machine)
    elif action == 'restart':
        win32serviceutil.RestartService(service, machine)
    elif action == 'status':
        srvStatus = win32serviceutil.QueryServiceStatus(service, machine)[1]
        print 'Service Status:', srvStatus
        if srvStatus == 4:
            srvStatus = "%s running normally" % service
        elif srvStatus == 1:
            srvStatus = "%s is *not* running" % service
        else:
            srvStatus = 'NONE'
        print 'ServiceManager: %s' % srvStatus
        return srvStatus

def StopStartService(srvOperation, conf): # Остановка сервиса с тайматаутом
    serverPC = conf.get('GLOBAL_APP', 'SERVER_PC')
    serviceName = conf.get('GLOBAL_APP', 'SERVICE_NAME')
    timeOut = int(conf.get('SHEDULE', 'SERVER_START_STOP_TIMEOUT'))
    # Увеличиваем счетчик попыток для для проверки состояния сервиса после timeOutCount попыток
    timeOutCount = int(conf.get('SHEDULE', 'SERVER_START_STOP_COUNT')) + 1
    startCount = timeOutCount
    while (timeOutCount):
        srvStatus = ServiceManager('status', serverPC, serviceName)
        executeOperation = 0
        if (srvStatus == ("%s is *not* running" % serviceName)) and (srvOperation == 'start'): # надо ли запускать сервис
            executeOperation = 1
        if srvStatus == (('%s running normally' % serviceName)) and (srvOperation == 'stop'): # надо ли останавливать сервис
            executeOperation = 1
        if srvStatus == 'NONE':
            executeOperation = 1
        if executeOperation:
            if timeOutCount == 1: # После timeOutCount сервис все еще не остановлен\запущен
                #SendMail(GLOBAL_FROM_MAIL, GLOBAL_TO_MAIL, mailSubj, mailBody)
                raise Exception("StopStartService: can't %s service %s" % (srvOperation, serviceName))
            else: # Попытка остановить\запустить сервис
                if (startCount == timeOutCount) and srvStatus != 'NONE':
                    print datetime.datetime.now(), 'Try %s service %s' % (srvOperation, serviceName)
                    ServiceManager(srvOperation,serverPC, serviceName) # Запускается или останавливается сервис
                print datetime.datetime.now(), 'waiting stop service', timeOut, 'sec'
                time.sleep(timeOut)
                timeOutCount -= 1
        else:
            print datetime.datetime.now(), 'service %s is %sed' % (serviceName, srvOperation)
            timeOutCount = 0

def PsServiceManager(action, pc, service, login, password, pst_path):
    '''
    Управление сервисами на основе утилит pstools'''
    if action in ['start', 'stop', 'status']:
        if action == 'status': action = 'query'
    else:
        raise Exception("PsServiceManager: uncknown action - %s" % action)
    pst_path.replace('"', '') # На всякий случай удаляем кавычки, добавляются позже
    app = '"%s%s" \\\\%s -u %s -p %s %s %s' % (pst_path, '\psservice.exe', pc, login, password, action, service)
    return PsGetServiceStatus(StartConsole(app))


def PsGetServiceStatus(linesOut):
    '''
    Извлечение статуса сервиса на основании выдачи утилиты psservice'''
    for line in linesOut:
        if 'STATE' in line:
            m = re.search(r':\s+(\d+)\s+([A-Z]+)',line)
            if m:
                print 'm.groups():', m.groups()
                return m.groups()
            else:
                return m

def PsStartStopF1(action, conf):
    '''
    Запуск и остановка сервера F1'''
    pc = conf.get('GLOBAL_APP', 'SERVER_PC')
    service = conf.get('GLOBAL_APP', 'SERVICE_NAME')
    login = conf.get('GLOBAL_APP', 'SERVER_USER')
    password = conf.get('GLOBAL_APP', 'SERVER_PASSWORD')
    timeOut = int(conf.get('SHEDULE', 'SERVER_START_STOP_TIMEOUT'))
    pst_path = conf.get('GLOBAL_PATH', 'PSTOOLS')
    # Увеличиваем счетчик попыток для для проверки состояния сервиса после timeOutCount попыток
    timeOutCount = int(conf.get('SHEDULE', 'SERVER_START_STOP_COUNT')) + 1
    startCount = timeOutCount
    if action not in ('start', 'stop'):
        raise Exception("PsStartStopF1: incorrect action: %s" % action)
    while (timeOutCount):
        srvStatus = PsServiceManager('status', pc, service, login, password, pst_path)
        print 'srvStatus:', srvStatus
        executeOperation = 0
        if (srvStatus[1] == 'STOPPED') and (action == 'start'): # надо ли запускать сервис
            executeOperation = 1
        if (srvStatus[1] == 'RUNNING') and (action == 'stop'): # надо ли останавливать сервис
            executeOperation = 1
        if srvStatus[1] in ('Start Pending', 'Stop Pending'): # сервис в процессе запуска или остановки
            print 'PsStartStopF1: ', srvStatus[1]
            executeOperation = 1
        if srvStatus[1] not in ('Start Pending', 'Stop Pending', 'STOPPED', 'RUNNING'):
            raise Exception("PsStartStopF1: uncknown srvStatus[1]: %s" % srvStatus[1])
        if executeOperation:
            if timeOutCount == 1: # После timeOutCount сервис все еще не остановлен\запущен
                #SendMail(GLOBAL_FROM_MAIL, GLOBAL_TO_MAIL, mailSubj, mailBody)
                raise Exception("PsStartStopF1: can't %s service %s" % (action, service))
            else: # Попытка остановить\запустить сервис
                if (startCount == timeOutCount) and srvStatus[1] != 'NONE':
                    print datetime.datetime.now(), 'Try %s service %s' % (action, service)
                    PsServiceManager(action, pc, service, login, password, pst_path) # Запускается или останавливается сервис
                print datetime.datetime.now(), 'waiting %s service' % action, timeOut, 'sec'
                time.sleep(timeOut)
                timeOutCount -= 1
        else:
            print datetime.datetime.now(), 'service %s is %sed' % (service, action)
            timeOutCount = 0

def ShutdownPC(host='localhost', user=None, passwrd=None, msg=None, timeout=60, force=1,
             reboot=1):
    """ Shuts down a remote computer, requires NT-BASED OS. """

    # Create an initial connection if a username & password is given.
    connected = 0
    if user and passwrd:
        try:
            win32wnet.WNetAddConnection2(win32netcon.RESOURCETYPE_ANY, None,
                                         ''.join([r'\\', host]), None, user,
                                         passwrd)
        # Don't fail on error, it might just work without the connection.
        except:
            pass
        else:
            connected = 1
    # We need the remote shutdown or shutdown privileges.
    p1 = win32security.LookupPrivilegeValue(host, win32con.SE_SHUTDOWN_NAME)
    p2 = win32security.LookupPrivilegeValue(host,
                                            win32con.SE_REMOTE_SHUTDOWN_NAME)
    newstate = [(p1, win32con.SE_PRIVILEGE_ENABLED),
                (p2, win32con.SE_PRIVILEGE_ENABLED)]
    # Grab the token and adjust its privileges.
    htoken = win32security.OpenProcessToken(win32api.GetCurrentProcess(),
                                           win32con.TOKEN_ALL_ACCESS)
    win32security.AdjustTokenPrivileges(htoken, False, newstate)
    win32api.InitiateSystemShutdown(host, msg, timeout, force, reboot)
    # Release the previous connection.
    if connected:
        win32wnet.WNetCancelConnection2(''.join([r'\\', host]), 0, 0)

def PsShutdownPC(pc, login, password, pst_path):
    '''
    Перезагрузка ПК при помощи pstools'''
    if pc == 'localhost':
        pst_path.replace('"', '') # На всякий случай удаляем кавычки, добавляются позже
        app = '%s%s  -r -f -t 1' % (pst_path, '\psshutdown.exe')
    else:
        app = '"%s%s"  \\\\%s -u %s -p %s -r -f -t 33' % (pst_path, '\psshutdown.exe', pc, login, password)
    StartConsole(app)

def RebootPC(pcType, conf): # пререзагрузка клиента или сервера
    print datetime.datetime.now(), ' Start rebootig', pcType
    pc = conf.get('GLOBAL_APP', 'SERVER_PC')
    login = conf.get('GLOBAL_APP', 'SERVER_USER')
    password = conf.get('GLOBAL_APP', 'SERVER_PASSWORD')
    pst_path = conf.get('GLOBAL_PATH', 'PSTOOLS')

    waitCount = 5 # количество проверок наличия сетвеолго ресурса
    waitTimeout = 180 # таймаут проверки ресурса
    rebootFlagFile = conf.get('GLOBAL_APP', 'APP_PATH') + '\\reboot.' + os.getenv('COMPUTERNAME') + '.flag'
    if pcType == 'CLIENT_SERVER':
        with open (rebootFlagFile, 'w') as ff:
                ff.write('reboot flag')  # файл - флаг перезагрузки
        PsStartStopF1('stop', conf)
        # MEDIT Надо обработать собст-е исключение о неовзможности отключить сервер
        PsShutdownPC(pc, login, password, pst_path)
        while waitCount:# ожидание появление сетевого ресурса
            time.sleep(waitTimeout)
            if os.path.exists(rebootFlagFile): break
            else: waitCount -= 1
        if not os.path.exists(rebootFlagFile):
            raise Exception('RebootPC: cant reboot: ' + GLOBAL_SERVER_PC)
            #MEDIT также можно обработать
    elif pcType == 'DESKTOP':
        PsShutdownPC('localhost', 'user', 'password', pst_path)
    else: raise Exception('RebootPC: unknown pcType: ' + pcType)

def RenameFilePrefix(filePath, srcFileExtension, dstFileExtension, incIndex, fileCount):
    '''
    Переименования префикса файла представляющего порядковый номер.
    К текущему порядковому номеру добавляется константа и файл переименовывается.
    Например: Константа = 123. Текущее имя файла - "23.ctx". Станет "146.ctx"
    incIndex - константа, на которую надо увеличить порядковый номер файла.
    '''
    #srcFileExtension = '.txt' # расширение обрабатываемых файлов перед обработкой
    #srcFileExtension = '.ctx.etalon' # расширение обрабатываемых файлов после обработки
    startIndex = 1; # нименьшее значения префикса в обрабатываемых файлах
    finishIndex = fileCount; # максимальное значение префикса обрабатываемых файлов
    fileName=''
    newFileName=''
    for prefix in range(startIndex, finishIndex):
        # В лог выводится переименование первого и последнего файла
        fileName = filePath+ '\\' +str(prefix)+srcFileExtension # имя обрабатывамого файла
        if os.path.exists(fileName): # найден файл с требуемым префиксом
            newFileName = filePath+ '\\' +str(prefix)+dstFileExtension
            if (prefix == startIndex) or (prefix == finishIndex):
                print '%s - renaming to %s' % (fileName, newFileName)
            shutil.move(fileName, newFileName)
        else:
            print '%s - file not found' % fileName

def GetDeltaSegments():
    '''
    Забирает дельты сегментов из указанного каталога
    '''
    destFolder = ''# Каталог с дельтами сегментов
    strSegments = "1,6,7,9,11,12,13,14,15,16,17,21,23,24,25,26,28,29,30,33,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,75,76,77,78,79,80,81,82,83,84,85,86,87,88,90,91,93,94,95,97,101,103,104,108,109,110,112,114,120,121,122,126,131,132,133,135,136,137,141,142,143,144,145,146,147,148,149,151,153,154,155,156,161,162,163,167,169,170,171,172,173,176,179,180,181,183,185,186,187,188,190,192,193,194,195,197,202,207,211,213,215,217,218,222,228,229,230,232,235,238"# Строка с номерами сегментов

    #Преобразуем строку в массив и перебираем элементы с номероми сегментов
    listSegments = strSegments.split(',')
    for seg in listSegments:
        segLen = len(seg)
        prefix = ''
        if segLen == 1:
            prefix = '00'+seg
        elif segLen == 2:
            prefix = '0'+seg
        elif segLen == 3:
            prefix = ''+seg
        else:
            raise Exception('incorrect segment number: %s' % seg)
        print prefix

if __name__ == '__main__':
    try:
        raw_input("Press Enter to continue...")
        # conf = pini.IniManager('run_DailyTest.ini')
        # pc = conf.get('GLOBAL_APP', 'SERVER_PC')
        # service = conf.get('GLOBAL_APP', 'SERVICE_NAME')
        # login = conf.get('GLOBAL_APP', 'SERVER_USER')
        # password = conf.get('GLOBAL_APP', 'SERVER_PASSWORD')
        # timeOut = int(conf.get('SHEDULE', 'SERVER_START_STOP_TIMEOUT'))
        # pst_path = conf.get('GLOBAL_PATH', 'PSTOOLS')
        # # Увеличиваем счетчик попыток для для проверки состояния сервиса после timeOutCount попыток
        # timeOutCount = int(conf.get('SHEDULE', 'SERVER_START_STOP_COUNT')) + 1
        # startCount = timeOutCount
        # action = 'stop'
        # if action not in ('start', 'stop'):
        #     raise Exception("PsStartStopF1: incorrect action: %s" % action)
        # while (timeOutCount):
        #     srvStatus = PsServiceManager('status', 'test-06', service, login, password, pst_path)
        curPath = os.getcwd()
        os.chdir('D:\\SearchTest.update\\TestSet\\Result\\Contexts')
        shutil.copy('1.ctx.etalon', '1.ctx.etalon.cpy')
        os.chdir(curPath)
        shutil.copy('testlib.bat', 'testlib.bat.cpy')
        #  ->
    except Exception as e:
        emsg = ''
        for msg in e:
            emsg += ' ' + str(msg).decode('cp1251')
        print emsg