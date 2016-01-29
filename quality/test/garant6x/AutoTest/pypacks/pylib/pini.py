# -*- coding: windows-1251 -*-
import ConfigParser, re, os, distutils.file_util

class IniManager:
    "Читает и хранит данные ini файла"
    iniDIct = {} # Словарь со всеми значениями ini файла
    GLOBALS = {}
    iniFile = ''
    def __init__(self, iniFile):
        ''' Перенос содержимого ini файла в словарь
        '''
        self.conf = ConfigParser.SafeConfigParser()
        self.conf.read(iniFile)
        self.iniFile = iniFile
        self.GLOBALS = {}
    def CheckRef(self, section, value):
        ''' Проверка на наличие в значении ссылок на другие ключи ini файла.
         Например, для вычисления пути к файлу заданному как "{DRIVE_LETTER}+\dir1\file1.txt",
         надо найти в текущей (пока) секции значение для ключа DRIVE_LETTER и выдать
         конечное значение "C:\dir1\file1.txt"
        '''
        print '>>>>>>> CheckRef >>>>>>>'
        m = re.search(r'\$\[(.+)\]', value)
        print 'value:', value
        if m:
            print 'ta da...'
            value = re.sub(r'\$\[(.+)\]', os.getenv(m.group(1)), value)
        return value
        # l = value.split('+')
        # if l > 1: # В строке есть ссылки на другие значения ini файла секции
        #     value = ''
        #     for el in l: # в каждом элементе ищем элемент в фигурных скобках - {*}
        #         m = re.search("[\%\{](.+)[\%\}]", el)
        #         if m:
        #             if '{' in el:
        #                 refOption = m.group(1)
        #                 value += self.get(section, refOption)
        #             elif '%' in el:
        #                 value += os.getenv(m.group(1))
        #         else:
        #             value += el
        # return value
    def get(self, section, option=''):
        if option:
            res = self.conf.get(section, option)
            m = re.search(r'\$\[(.+)\]', res)
            if m:
                res = re.sub(r'\$\[(.+)\]', os.getenv(m.group(1)), res)
        else:
            res = self.GLOBALS[section]
        return res
        #return self.CheckRef(section, self.conf.get(section, option))
    def set(self, globalKey, globalValue):
        self.GLOBALS[globalKey] = globalValue
    def set_value(self, section, option, value):
        self.conf.set(section, option, value)
    def has_option(self, section, option=''):
        if self.conf.has_option(section, option):
            return True
        else:
            return False
    def save(self):
        with open(self.iniFile, 'wb') as configfile:
            self.conf.write(configfile)

if __name__ == "__main__":
    # PSTOOLS='{NET_DRIVE}+\.EXTERNAL\pstools_sleep'
    # regExpResult = re.search("{(.+)}", PSTOOLS)
    # if regExpResult: print regExpResult.group(1)


    settings = IniManager('main.KC.710.ini')
    #settings = ConfigParser.SafeConfigParser()
    #settings.read('main.KC.710.ini')
    print 'NET_DRIVE:', settings.get('GLOBAL_PATH', 'NET_DRIVE')
    print settings.get('GLOBAL_PATH', 'RUN_DIR')
    print settings.get('GLOBAL_PATH', 'XML_FILE')
    print settings.get('GLOBAL_PATH', 'PSTOOLS')
    print settings.get('GLOBAL_PATH', 'LOCK_DIR')
    print settings.get('GLOBAL_PATH', 'LOGFILE')
    print settings.get('GLOBAL_PATH', 'BUILD_NAME')
    print settings.get('GLOBAL_PATH', 'DISTRIB_PATH')
    #print settings.get('GLOBAL_PATH', 'BUILD_PATH')
    #print 'TEST3', settings.get('GLOBAL_PATH', 'ENV.HOST')