# -*- coding: windows-1251 -*-

import time
import win32service
import win32serviceutil
import win32pdh
import win32api, win32con
import win32security
import pywintypes
import wmi

class ServiceNotExistsError(Exception):
    def get_message(self):
        return 'Error: service "%s" is not exists.' % tuple(self)
    
class TimeoutError(Exception):
    def get_message(self):
        return 'Error: %s of "%s" timed out.' % tuple(self)

class ServiceHelper:
    __service_name_pattern = 'Garant Intranet %s %s:%s'
    
    __service_type_corba = 'Data'
    __service_type_zope = 'Web'
    
    __service_state_start_pending = 'Start Pending'
    __service_state_stop_pending = 'Stop Pending'
    __service_state_running = 'Running'
    
    timeout_limit = 120
    
    service_location = '127.0.0.1'
    corba_port = '5151'
    zope_port = '80'
    
    is_force_mode = False
    
    def __init__(self):
        self.__set_debug_priveleges()
    
    def set_corba_port(self, port):
        self.corba_port = port
        return self
        
    def set_zope_port(self, port):
        self.zope_port = port
        return self
        
    def set_force_mode(self, force_mode):
        self.is_force_mode = force_mode
        return self
        
    def set_timeout(self, timeout_in_seconds):
        self.timeout_limit = timeout_in_seconds
        return self
    
    def get_service_name(self, service_type):
        return self.__service_name_pattern % (service_type, self.corba_port, self.zope_port)
        
    def is_service_running(self):
        return (self.__get_service_state(self.__service_type_corba) == self.__service_state_running and
            self.__get_service_state(self.__service_type_zope) == self.__service_state_running)     
            
    def is_service_stopping(self):
        return (self.__get_service_state(self.__service_type_corba) == self.__service_state_stop_pending or
            self.__get_service_state(self.__service_type_zope) == self.__service_state_stop_pending)
            
    def start(self):
        self.__start(self.__service_type_corba)
        self.__start(self.__service_type_zope)
    
    def stop(self):
        self.__stop(self.__service_type_zope)
        self.__stop(self.__service_type_corba)
    
    def __get_service_state(self, service_type):
        try:
            return wmi.WMI().Win32_Service(DisplayName = self.get_service_name(service_type))[0].State
        except IndexError:
            raise ServiceNotExistsError             
        
    def __is_exists(self, service_type):
        try:
            self.__get_service_state(service_type)
        except ServiceNotExistsError:
            return False
        return True
        
    def __is_running(self, service_type):
        return self.__get_service_state(service_type) == self.__service_state_running
        
    def __start(self, service_type):
        count_timeout = self.timeout_limit - 1
        try:
            if not self.__is_exists(service_type):
                raise ServiceNotExistsError, (self.get_service_name(service_type))
            if (self.is_force_mode or not self.__is_running(service_type)):
                win32serviceutil.StartService(self.get_service_name(service_type), self.service_location)
                while (self.__get_service_state(service_type) == self.__service_state_start_pending and count_timeout != 0):
                    time.sleep(1)
                    count_timeout -= 1
                if (count_timeout == 0):
                    raise TimeoutError, ('start', self.get_service_name(service_type))
                time.sleep(10)
                return True
        except (ServiceNotExistsError, TimeoutError), details:
            print details.get_message()
        except Exception, details:
            print 'Can\'t start "' + self.get_service_name(service_type) + '" service: %s' % details
        return False
    
    def __stop(self, service_type):
        count_timeout = self.timeout_limit - 1
        try:
            if not self.__is_exists(service_type):
                raise ServiceNotExistsError, (self.get_service_name(service_type))
            if (self.is_force_mode or self.__is_running(service_type)):
                win32serviceutil.StopService(self.get_service_name(service_type), self.service_location)
                while (self.__get_service_state(service_type) == self.__service_state_stop_pending and count_timeout != 0):
                    time.sleep(1)
                    count_timeout -= 1
                if (count_timeout == 0):
                    raise TimeoutError, ('stop', self.get_service_name(service_type))                    
                return True
        except ServiceNotExistsError, details:
            print details.get_message()
        except TimeoutError, details:
            print details.get_message(), 'Stop by kill process.'
            self.__kill(service_type)
            return True
        except Exception, details:
            print 'Can\'t stop "' + self.get_service_name(service_type) + '" service: %s' % details
            return False
            
    def __kill(self, service_type):
        service_list = wmi.WMI().Win32_Service(DisplayName = self.get_service_name(service_type))
        if service_list:
            for service in service_list:
                handle = win32api.OpenProcess(win32con.PROCESS_TERMINATE, 0, service.ProcessId)
                win32api.TerminateProcess(handle, 0)
                win32api.CloseHandle(handle)                   
   
    def __set_debug_priveleges(self):
        token_handler = win32security.OpenProcessToken(win32api.GetCurrentProcess(), win32security.TOKEN_ADJUST_PRIVILEGES | win32security.TOKEN_QUERY)
        new_privs = [(win32security.LookupPrivilegeValue (None, win32security.SE_DEBUG_NAME), win32security.SE_PRIVILEGE_ENABLED)]
        win32security.AdjustTokenPrivileges (token_handler, 0, new_privs)
    
if __name__ == '__main__':
    print ServiceHelper().set_corba_port('5140').set_zope_port('8040').set_force_mode(False).stop()         
    print ServiceHelper().set_corba_port('5140').set_zope_port('8040').set_force_mode(False).start()