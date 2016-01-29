# -*- coding: windows-1251 -*-

instances = [
    dict(
        name               = 'checkServer',      
        url                = 'http://kupuyc.garant.ru:8071/check/availability.html',
        http_timeout       = 30,
        path_f1            = r'c:/__intranets__/check',
        path_zope          = r'c:/__intranets__/check',
        port_data          = 5171,
        port_web           = 8071, 
        handler_f1         = r'handlers/handlerF1.cmd',
        handler_zope       = r'handlers/handlerZope.cmd',
        handler_additional = r'handlers/handlerEmpty.cmd',
        #handler_additional = r'handlers/handlerAdditional.cmd',
        is_async           = True,
        is_notify_by_sms   = False,
        is_notify_by_mail  = True
    ),
    dict(
        name               = 'main',      
        url                = 'http://kupuyc.garant.ru/check/availability.html',
        http_timeout       = 30,
        path_f1            = r'c:/__intranets__/i2517_main',
        path_zope          = r'c:/__intranets__/i2517_main',
        port_data          = 5148,
        port_web           = 8048, 
        handler_f1         = r'handlers/handlerF1.cmd',
        handler_zope       = r'handlers/handlerZope.cmd',
        handler_additional = r'handlers/handlerEmpty.cmd',
        #handler_additional = r'handlers/handlerAdditional.cmd',
        balancer           = 'http://mobileonline.garant.ru/bm',
        is_async           = True,
        is_notify_by_sms   = False,
        is_notify_by_mail  = True
    )    
]

import httplib
import smtplib
import urllib
import sys
import os
import traceback
import time
import subprocess
import re
import socket
import sets
from urlparse import urlparse
from email.Header import Header

class iChecker(object):
    
    """
        Перечень адресов на которые будут слаться уведомления
    """
    MAILTO = ['kupuyc@garant.ru'] #['kupuyc@garant.ru', 'nash@garant.ru', 'rykov@garant.ru']
    
    """
        Перечень номеров на которые будут слаться смс-уведомления
    """
    SMSTO = ['+79266906289'] #, '+79265854237'
        
    """
        Дефолтный таймаут операций с http
    """
    HTTP_TIMEOUT = 30
    
    """
        Шаблон URL к которой будет произведено обращение для отправки смс
    """
    SMS_URL_PATTERN = 'http://root:admin%%21garant2008@80.253.4.114/sms?%s'
    
    """
        Путь к хранилищу временных файлов
    """
    TEMP_STORAGE_PATH = 'temp'
    
    """
        Путь к логу чекера
    """
    LOG_FILE = r'logs/!сhecker.log'
    
    """
        Типы логов
        
        @see: iChecker._check_logs()
    """
    LT_F1  = 'F1'
    LT_ZOPE  = 'ZOPE'
    
    """
        Типы маркеров
        
        @see: iChecker._check_logs()
    """
    MT_WARNING          = 'WARNING'          #уведомление почтой
    MT_WARNING_CRITICAL = 'WARNING_CRITICAL' #уведомление и почтой, и смс
    MT_CRITICAL_F1      = 'CRITICAL_F1'
    MT_CRITICAL_ZOPE    = 'CRITICAL_ZOPE'
    
    """
        Путь к проверяемым чекером логам Intranet
        
        @see: iChecker._check_logs()
    """
    CHECKABLE_LOGS = [
        dict(
             file = r'intranet-event.log',
             is_share = False,
             type = LT_ZOPE,
             markers = {
                'TRANSIENT: CORBA\.TRANSIENT\(': MT_WARNING,
                "ERROR ZODB\.Connection Shouldn\'t load state for": MT_CRITICAL_ZOPE,
                'login_error\.htm': MT_WARNING_CRITICAL
             }
        ),
        dict(
             file = r'intranet.log',
             is_share = False,
             type = LT_ZOPE,
             markers = {
                "ERROR ZODB\.Connection Shouldn\'t load state for": MT_CRITICAL_ZOPE,
                'login_error\.htm': MT_WARNING_CRITICAL
             }
        )
        #,
        #dict(
        #     file = r'garant.log',
        #     type = LT_F1,
        #     is_share = True,
        #     markers = {
        #        '-LM_ERROR:.*?The End of Memory': MT_CRITICAL_F1
        #     }
        #)
    ]
    
    """
        Состояния клона INSTANCE_STATES
    """
    IS_OK               = 0
    IS_ZOPE_FAILED      = 1
    IS_F1_FAILED        = 2
    IS_WARNING          = 3
    IS_WARNING_CRITICAL = 4
    
    """
        Типы состояний WARNING
    """
    WT_LOG_MARKER  = 0
    
    """
        Текстовые значения кодов ошибок добавочных утилит проверки
    """
    HANDLER_ADDITIONAL_EXIT_CODE_TITLES = {
        0: 'Ok',
        1: 'Error'
    }
    
    """
        Данные проверяемого клона
        @type _instance: dict
    """
    _instance = None
    
    """
        Хранилище логов чекера
        
        @type _log_storage: file
    """
    _log_storage = None
    
    """
        Признак того, что нотификация по почте уже была произведена
    """
    _is_notified_by_mail = None
    
    """
        Состояние клона
        
        @type instance_states: sets.Set
    """
    instance_states = None
    
    """
        Данные по состоянию WARNING
    
        @type warning_data: dict  
    """
    warning_data = None
    
    """
        Cообщения, описывающие диагностированную проблему
        
        @type message: str
    """
    _messages = None
    def get_messages(self):
        messages = self._messages[0:]
        messages.append('See details in "logs/%s.log".' % instance.get('name'))
        
        return '\r\n'.join(messages)
    messages = property(get_messages, None, None, 'messages property')

    def __init__ (self, instance):
        """
            Инициализация
            @param instance: dict
        """
        
        self._instance = instance
        self._log_storage = None
        self._is_notified_by_mail = False
        self.instance_states = sets.Set()
        self.warning_data = {}
        self._messages = []
        self._log_storage = open(self.LOG_FILE, 'a')
        socket.setdefaulttimeout(self._instance.get('http_timeout', self.HTTP_TIMEOUT))
        
    def check(self):
        """
            Проведет проверку клона и запустит обработчики в зависимости от результата и данных клона
            Вернет истину, если клон в рабочем состоянии
            
            @return: bool
        """
        
        self._log('START: check of "%s" instance' % self._instance.get('name'))
        
        is_check_clear = True #мы оптимисты
        
        if self._instance.get('balancer'):
            is_check_clear = self._check_balancer()
        
        if self._instance.get('url'):
            self._check_url()
            self._check_logs()
            
            handler_additional_exit_code = self._execute_handler(self._instance.get('handler_additional'), True)
            
            if (self._instance.get('handler_additional') and
                0 != handler_additional_exit_code and
                not self._instance.get('is_async', False)
            ):
                
                self._log('Instance "%s": %s exited with code %s (%s).' % (
                    self._instance.get('name'),
                    self._instance.get('handler_additional'),
                    handler_additional_exit_code,
                    self.HANDLER_ADDITIONAL_EXIT_CODE_TITLES.get(handler_additional_exit_code, 'Unknown')
                ), 1)
            
            if self.instance_states.difference(sets.Set([self.IS_OK, self.IS_WARNING, self.IS_WARNING_CRITICAL])):
                is_check_clear = False
                self._process_critical_state()
                    
            if self.IS_WARNING_CRITICAL in self.instance_states:
                is_check_clear = False                
                self._process_warning_critical_state()                
                  
            if self.IS_WARNING in self.instance_states or self.IS_OK != handler_additional_exit_code:
                is_check_clear = False
                self._process_warning_state()
                    
        self._log('STOP: check of "%s" instance' % self._instance.get('name'))
        
        return is_check_clear
    
    def _check_balancer(self):
        """
            Распарсит вывод статистики по балансировщику и проверит корректность путей перенаправления
        """
        
        is_check_clear = True
        
        self._log('START: balancer check of "%s" instance' % self._instance.get('name'), 1)
        
        try:            
            connection = self._request_url(self._instance.get('balancer'))
            response = connection.getresponse()
                        
            status = int(response.status)
        except:
            print 'Request of "%s" ended with error "%s".' % (self._instance.get('balancer'), exception.args)            
            status = -1
        
        if httplib.OK == status:
            for port_url, port_path in re.findall(re.compile('<tr>\s*<td>\s*<a[^>]*?>[^<]*?:(\d+)\s*</a>\s*</td>\s*<td>[^<]*?(\d+)</td>', re.M | re.S), response.read()):
                if port_url != port_path:
                    is_check_clear = False
                    self._messages.append(r'Balancer paths of "%s" instance is wrong: %s <-> %s.' % (instance.get('name'), port_url, port_path))
                    self._log(r'Balancer paths of "%s" instance is wrong: %s <-> %s.' % (instance.get('name'), port_url, port_path), 2)
                    
        elif httplib.NOT_FOUND == status:            
            self._messages.append(r'Balancer of "%s" instance is inaccessible.' % instance.get('name'))
            self._log(r'Balancer of "%s" instance is inaccessible.' % instance.get('name'), 2)
        
        self._log('STOP: balancer check of "%s" instance' % self._instance.get('name'), 1)
        
        if not is_check_clear:
            self.instance_states.add(self.IS_WARNING_CRITICAL)
            
        return is_check_clear
        
    def _check_url(self):
        """
            Выполнит HTTP-запрос по url-у проверки клона и в зависимости от статуса установит
            нужное состояние self.instance_states
        """
        
        self._log('START: url check of "%s" instance' % self._instance.get('name'), 1)
                
        try:            
            connection = self._request_url(self._instance.get('url'))
            response = connection.getresponse()
            response.read()
            
            status = int(response.status)
        except httplib.socket.timeout, exception:
            print 'Request of "%s" ended with error "%s". F1 marked as dead.' % (self._instance.get('url'), exception)            
            status = httplib.NOT_FOUND
        except httplib.socket.error, exception:             
            print 'Request of "%s" ended with error "%s". Zope marked as dead.' % (self._instance.get('url'), exception.args[1])            
            status = httplib.INTERNAL_SERVER_ERROR
        except:
            print 'Request of "%s" ended with UNKNOW error "%s". Zope marked as dead.' % (self._instance.get('url'), exception.args[1])            
            status = -1
            
        if httplib.OK == status:
            self.instance_states.add(self.IS_OK)
            self._log('URL check: instance "%s" is OK.' % self._instance.get('name'), 2)
        elif httplib.NOT_FOUND == status:
            self.instance_states.add(self.IS_F1_FAILED)
            self._messages.append(r'Instance "%s" is DOWN: F1 not respond.' % instance.get('name'))
            self._log('URL check: instance "%s" is DOWN: F1 not respond.' % self._instance.get('name'), 2)    
        elif -1 == status or httplib.INTERNAL_SERVER_ERROR == status:
            self.instance_states.add(self.IS_ZOPE_FAILED)
            self._messages.append(r'Instance "%s" is DOWN: Zope not respond.' % instance.get('name'))
            self._log('URL check: instance "%s" is DOWN: Zope not respond.' % self._instance.get('name'), 2)
        
        self._log('STOP: url check of "%s" instance' % self._instance.get('name'), 1)
            
    def _check_logs(self):
        """
            Выберет из логов строки с момента последней проверки и проверит их на наличие
            маркеров говорящих о сбоях
        """
        
        self._log('START: log check of "%s" instance' % self._instance.get('name'), 1)
        
        is_logs_clear = True
        
        for log in self.CHECKABLE_LOGS:            
            log_part = self._get_log_part_by_size(log)            
                        
            for marker, marker_type in log.get('markers').items():                
                if re.search(marker, log_part, re.M | re.S):
                    is_logs_clear = False
                    
                    if self.MT_WARNING == marker_type:
                        self.instance_states.add(self.IS_WARNING)
                        self._messages.append(r'Instance "%s" WARNING: "%s" marker was occured.' % (instance.get('name'), marker))
                    elif self.MT_WARNING_CRITICAL == marker_type:
                        self.instance_states.add(self.IS_WARNING_CRITICAL)
                        self._messages.append(r'Instance "%s" WARNING_CRITICAL: "%s" marker was occured.' % (instance.get('name'), marker))
                    elif self.MT_CRITICAL_ZOPE == marker_type:
                        self.instance_states.add(self.IS_ZOPE_FAILED)
                        self._messages.append(r'Instance "%s" is DOWN: Zope not respond.' % instance.get('name'))
                    elif self.MT_CRITICAL_F1 == marker_type:
                        self.instance_states.add(self.IS_F1_FAILED)
                        self._messages.append(r'Instance "%s" is DOWN: F1 not respond.' % instance.get('name'))
                    else:
                        print 'Marker "%s" is occured but not handled' % marker
                    
                    self._log('LOG check: instance "%s" %s: log "%s" contains error marker "%s".' % (
                        self._instance.get('name'),
                        marker_type,
                        log.get('file'),
                        marker
                    ), 2)
            
        if is_logs_clear:
            self._log('LOG check: instance "%s" is OK.' % self._instance.get('name'), 2)
            
        self._log('STOP: log check of "%s" instance' % self._instance.get('name'), 1)
        
    def _get_log_part_by_size(self, log):
        """
            Вернет часть лога, заданного параметром, начиная от последнего запуска
            
            @param log: dict
            @return: str 
        """
        
        try:
            file = open(self._get_log_filename(log), 'rb')
            file.seek(self._get_previous_log_filesize(log))
            log_part = file.read()
            file.close()
            
            self._update_previous_log_filesize(log)
        except IOError, exception:
            print 'File "%s" is not exist and skiped.' % exception.filename
            return ''
        
        return log_part
    
    def _get_log_filesize(self, log):
        """
            Вернет размер файла лога
            
            @param log: dict
            @return: int
        """
        
        return os.path.getsize(self._get_log_filename(log))
    
    def _get_previous_log_filesize(self, log):
        """
            Вернет размер файла лога при предыдущем вызове скрипта
            
            @param log: dict
            @return: int
        """
        
        try:
            file = open(self._get_previous_log_filesize_filename(log))
            filesize = int(file.read())
            file.close()
            
            if self._get_log_filesize(log) < filesize:
                return 0
            
            return filesize
        except Exception, exception:
            print exception
            
            return self._get_log_filesize(log)
        
    def _update_previous_log_filesize(self, log):
        """
            Сохранит текущий размер файла лога для последующих запусков скрипта
            
            @param log: dict
        """
        
        try:
            file = open(self._get_previous_log_filesize_filename(log), 'w')
            file.write(str(self._get_log_filesize(log)))
            file.close()
        except:
            pass
        
    def _get_log_filename(self, log):
        """
            Вернет имя файла лога с путем
            
            @param log: dict
            @return: str
        """
        
        if self.LT_F1 == log.get('type'):
            return '%s/%s/%s' % (self._instance.get('path_f1'), 'logs', log.get('file'))
        
        if self.LT_ZOPE == log.get('type'):
            return '%s/%s/%s' % (self._instance.get('path_zope'), 'logs', log.get('file'))
        
    def _get_previous_log_filesize_filename(self, log):
        """
            Вернет имя файла с путем куда будет храниться размер файла лога
            
            @param log: dict
            @return: str
        """
        
	if log.get('is_share', False):
            return '%s/%s.filesize' % (self.TEMP_STORAGE_PATH, log.get('file'))
        else:
            return '%s/%s-%s.filesize' % (self.TEMP_STORAGE_PATH, self._instance.get('name'), log.get('file'))
    
    def _animate(self):
        """
            Предпримет действия по оживлению клона
        """
        
        if self.IS_F1_FAILED in self.instance_states:
            self._execute_handler(self._instance.get('handler_f1'))
        elif self.IS_ZOPE_FAILED in self.instance_states:
            self._execute_handler(self._instance.get('handler_zope'))

    def _execute_handler(self, handler, is_force_sync_mode = False):
        """
            Запустит переданный в качестве параметра обработчик
            В случае ассинхронного вызова будет возвращен pid процесса, иначе - код возврата
            
            @see: глобальный словарь instances
            @param handler: str
            @return: int
        """
        
        command = r'%s/%s %s "%s" "%s" %s %s' % (
            os.getcwd(),
            handler,
            self._instance.get('name', ''),
            self._instance.get('path_f1', ''),
            self._instance.get('path_zope', ''),
            self._instance.get('port_data', ''),
            self._instance.get('port_web', '')
        )
        
        if self._instance.get('is_async', False) and not is_force_sync_mode:
            return subprocess.Popen(command).pid        
        
        return subprocess.call(command)
    
    def _process_critical_state(self):
        """
            Предпримет действия связанные с состоянием CRITICAL
            
            Попытается востановить работу: остановит службы, перепишет настройки, запустит службы
        """
        
        self._animate()
        
        if self._instance.get('is_notify_by_sms'):
            self._notify_by_sms('iChecker: %s CRITICAL' % instance.get('name'))
        
        if self._instance.get('is_notify_by_mail'):
            self._notify_by_mail('iChecker: %s CRITICAL' % instance.get('name'), self.messages)
    
    def _process_warning_critical_state(self):
        """
            Предпримет действия связанные с состоянием WARNING_CRITICAL
            
            Отправит уведомления о ситуации
        """
        
        if self._instance.get('is_notify_by_mail'):
            self._notify_by_mail('iChecker: %s WARNING_CRITICAL' % instance.get('name'), self.messages)
            
        if self._instance.get('is_notify_by_sms'):
            self._notify_by_sms('iChecker: %s WARNING_CRITICAL' % instance.get('name'))
                        
    def _process_warning_state(self):
        """
            Предпримет действия связанные с состоянием WARNING
            
            Отправит уведомления о ситуации
        """
        
        if self._instance.get('is_notify_by_mail'):
            self._notify_by_mail('iChecker: %s WARNING' % instance.get('name'), self.messages)
            
    def _request_url(self, url):
        """
            Запросит страницу по ссылке и вернет объект ответа
            
            @param url: str
            @return: HTTPConnection
        """
        
        connection = httplib.HTTPConnection(urlparse(url)[1])
        connection.request('GET', url)
        
        return connection

    def _log(self, message, level = 0):
        """
            Выведет в лог сообщение с датой
            @param message: str
        """
        
        if level:
            message = message.rjust(len(message) + level * 2)
        
        try:
            self._log_storage.write('[%s] %s\n' % (str(time.ctime(time.time())), message))
            self._log_storage.flush()
        except Exception, exception:
            print exception
    
    def _notify_by_mail(self, subject, message):
        """
            Разошлет уведомления на почту подписчиков self.MAILTO
            
            @param subject: str
            @param message: str
        """
        
        if not self._is_notified_by_mail:
            self._send_mail(subject, message)
            self._is_notified_by_mail = True        
        
    def _send_mail(self, subject, message):
        """
            Отправит сообщение на почту
            
            @param subject: str
            @param message: str
        """

        smtpserver = "smtp.garant.ru"
        charset = "windows-1251"
        mailfrom = "hotline@garant.ru"
    
        server = smtplib.SMTP(smtpserver)
    
        from_header = "%s <%s>" % (Header ("Web Tester", charset), mailfrom)
        subject = Header(subject, charset)
        body = "To: %s \nFrom: %s\nSubject: %s\nContent-type: text/plain; charset=windows-1251\n\n%s" % (self.MAILTO, mailfrom, subject, message)
    
        server.sendmail(from_header, self.MAILTO, body)
        server.quit()
        
    def _notify_by_sms(self, message):
        """
            Разошлет смс-уведомления на телефоны подписчиков self.SMSTO
            
            @param message: str
        """
        
        for phone in self.SMSTO:
            self._send_sms(phone, message)
        
    def _send_sms(self, phone, message):
        """
            Отправит sms-сообщение
            
            @param phone: str
            @param message: str
        """
        
        try:
            socket.setdefaulttimeout(self.HTTP_TIMEOUT)
            handler = urllib.urlopen(self.SMS_URL_PATTERN % urllib.urlencode({
                'phone': phone,
                'message': message
            }))
            handler.close()
        except Exception, exception:
            self._log('Error when sending sms - %s (phone: %s, message: %s)' % (exception, phone, message))


failed_checkers = []

print '\n\n\n[%s]' % str(time.ctime(time.time()))

for instance in instances:
    checker = iChecker(instance)
    
    if not checker.check():
        failed_checkers.append(checker)        

if failed_checkers:
    print '\n-----------------\nSome tests FAILED\n'
    for checker in failed_checkers:
        print checker.messages
else:
    print '\n-----------------\nAll test passed OK'
