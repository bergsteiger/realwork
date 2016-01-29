# -*- coding: windows-1251 -*-
import time, os, distutils.dir_util, inspect, glob
import psystem, pcommon
def UpdateF1(conf):
    ''' Обновление версии F1 '''
    typeF1 = conf.get('GLOBAL_APP', 'F1_TYPE')
    pcommon.printTM('start updating '+typeF1+' version', inspect.stack()[0][3])
    appPath = conf.get('GLOBAL_APP', 'APP_PATH')
    buildPath = conf.get('GLOBAL_PATH', 'BUILD_PATH')

    appsDst = appPath + '\\apps'
    appsSrc = ''
    settingsDst = appPath + '\\settings'
    settingsSrc = ''
    if typeF1 == 'DESKTOP':
        appsSrc = buildPath + '\\desktop\\apps'
        settingsSrc = buildPath + '\\desktop\\settings'
    elif typeF1 == 'NETWARE':
        appsSrc = buildPath + '\\netware\\apps'
        settingsSrc = buildPath + '\\netware\\settings'
    elif typeF1 == 'CLIENT_SERVER':
        psystem.PsStartStopF1('stop', conf)
        appsSrc = buildPath + '\\server-private\\apps' # MEDIT
        settingsSrc = buildPath + '\\server-private\\settings' # MEDIT
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
    pcommon.printTM('update done', inspect.stack()[0][3])
    if typeF1 == 'CLIENT_SERVER':
        psystem.PsStartStopF1('start', conf)
        time.sleep(450)# задержка для запуска "супера"

def GetDeltaFiles(path):
    '''
    Возвращает список файлов по максе *.zip или *.D0*
    '''
    dlt_files = glob.glob(path+'\\*.zip')
    if not dlt_files: #Если не найдены запакованные дельты, ищем распакованные по маске *.D0*
        dlt_files = glob.glob(path+'\\*.D0*')
    return dlt_files

def runDownload(conf):
    '''
    Запуск F1Download в автоматическом режиме
    '''
    psystem.StartConsole(conf.get('GLOBAL_APP','download.exe.path')) # запуск загрузки де1льты (download.exe)
    waitStartingF1DownloadCount = 30
    while not psystem.ProcessExist('F1Download.run'):
        print 'starting F1Download.run, wait 1 sec';time.sleep(1)# ждем запуска F1Download.run
        waitStartingF1DownloadCount -= 1
        if not waitStartingF1DownloadCount: break
    while psystem.ProcessExist('F1Download.run'):print 'wait F1Download.run - 2 min';time.sleep(120)# ждем завершения F1Download.run
    while psystem.ProcessExist('F1Shell.run'):print 'wait F1Shell.run - 10 sec';time.sleep(10)# ждем завершения F1Shell.run

def runUpdate(conf):
    '''
    Запуск dataupd.exe в автоматическом режиме
    '''
    pcommon.printTM('Start data update')
    psystem.StartConsole(conf.get('GLOBAL_APP','dataupd.exe.path')) # запуск загрузки де1льты (download.exe)
    while not psystem.ProcessExist('F1DataUpd.run'):print 'starting F1DataUpd.run, wait 1 sec';time.sleep(1)# ждем запуска F1DataUpd.run
    while psystem.ProcessExist('F1DataUpd.run'):print 'wait F1DataUpd.run - 2 min';time.sleep(120)# ждем завершения F1Download.run
    while psystem.ProcessExist('F1Shell.run'):print 'wait F1Shell.run - 10 sec';time.sleep(10)# ждем завершения F1Shell.run
    pcommon.printTM('Delay after data update 7 sec')
    time.sleep(7)

def ApplyDelta(conf):
    '''
    Применение загруженных дельт двумя способами
    '''
    #Бэкап текущих баз оболочки на случай неудачного обновления
    psystem.FolderBackup(conf.get('common','base_7tr'), conf.get('common','backup_7tr'))
    psystem.FolderBackup(conf.get('common','base_3456'), conf.get('common','backup_3456'))

    #Копирование в бэкап дельты для последующего обновления сбоку (внчале прямое обновление)
    dlt_files = GetDeltaFiles(conf.get('common','delta_3456'))#Список файлов из каталога delta
    if not os.path.exists(conf.get('common','delta_7tr')): #Создание каталога для бэкапа дельт на момент обновления
        print 'makeing folder %s ' % conf.get('common','delta_7tr')
        os.mkdir(conf.get('common','delta_7tr'))
    for f in dlt_files: #Бэкап дельты для последующего обновления "сбоку"
        psystem.fcopy_l(f,conf.get('common','delta_7tr'))
    #Подложить garant.ini для обычного обновления
    psystem.fcopy_l(conf.get('GLOBAL_APP','APP_PATH')+'\garant.3456.ini', conf.get('GLOBAL_APP','APP_PATH')+'\garant.ini')
    #Запустить обычное обновление последней оболочкой
    runUpdate(conf)
    #Восстановление из бэкапа дельты для обновления сбоку
    dlt_files = GetDeltaFiles(conf.get('common','delta_7tr'))#Список файлов каталога delta.backup
    print 'dlt_files', dlt_files
    for f in dlt_files:
        psystem.fmove_l(f,conf.get('common','delta_3456'))
    #FolderBackup(conf.get('GLOBAL_APP','APP_PATH')+'\delta\Archive', conf.get('GLOBAL_APP','APP_PATH')+'\delta')
    #Подложить garant.ini для обновления сбоку
    psystem.fcopy_l(conf.get('GLOBAL_APP','APP_PATH')+'\garant.7tr.ini', conf.get('GLOBAL_APP','APP_PATH')+'\garant.ini')
    #Запустить обновление сбоку последней оболочкой 7.10 (на SSD)
    runUpdate(conf)

if __name__ == '__main__':
    pcommon.printTM('WOW')