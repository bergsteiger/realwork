# -*- coding: windows-1251 -*-

import time
import win32service
import win32serviceutil
import win32pdh
import win32api, win32con
import win32security
import pywintypes
import wmi
import sys
import getopt
import copy

class ServiceNotExistsError(Exception):
    def get_message(self):
        return 'Error: service "%s" is not exists.' % tuple(self)
    
class TimeoutError(Exception):
    def get_message(self):
        return 'Error: %s of "%s" timed out.' % tuple(self)

class ServiceHelper:
    CORBA_SERVICE_DEFAULT_NAME = 'GARANT. Platform F1 Application Server'
    
    _is_use_default_corba_service_name = False
    
    _service_name_pattern = 'Garant Intranet %s %s:%s'
    
    _service_type_corba = 'Data'
    _service_type_zope = 'Web'
    
    _service_state_start_pending = 'Start Pending'
    _service_state_stop_pending = 'Stop Pending'
    _service_state_running = 'Running'
    
    timeout_limit = 30
    
    service_location = '127.0.0.1'
    corba_port = '5151'
    zope_port = '80'
    
    is_force_mode = False
    
    def __init__(self):
        self._set_debug_priveleges()
    
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
    
    def use_default_corba_service_name(self, is_use):
        self._is_use_default_corba_service_name = is_use
    
    def get_service_name(self, service_type):
        if self._service_type_corba == service_type and self._is_use_default_corba_service_name:
            return self.CORBA_SERVICE_DEFAULT_NAME
                
        return self._service_name_pattern % (service_type, self.corba_port, self.zope_port)
        
    def is_service_running(self):
        return (self._get_service_state(self._service_type_corba) == self._service_state_running and
            self._get_service_state(self._service_type_zope) == self._service_state_running)     
            
    def is_service_stopping(self):
        return (self._get_service_state(self._service_type_corba) == self._service_state_stop_pending or
            self._get_service_state(self._service_type_zope) == self._service_state_stop_pending)
            
    def start_corba(self):
        return self._start(self._service_type_corba)
    
    def stop_corba(self):
        return self._stop(self._service_type_corba)
        
    def start_zope(self):
        return self._start(self._service_type_zope)
    
    def stop_zope(self):
        return self._stop(self._service_type_zope)
        
    def start(self):
        self.start_corba()
        self.start_web()
    
    def stop(self):
        self.stop_corba()
        self.stop_web()
    
    def _get_service_state(self, service_type):
        try:
            return wmi.WMI().Win32_Service(DisplayName = self.get_service_name(service_type))[0].State
        except IndexError:
            raise ServiceNotExistsError             
        
    def _is_exists(self, service_type):
        try:
            self._get_service_state(service_type)
        except ServiceNotExistsError:
            return False
        
        return True
        
    def _is_running(self, service_type):
        return self._get_service_state(service_type) == self._service_state_running
        
    def _start(self, service_type):
        count_timeout = self.timeout_limit - 1
        try:
            if not self._is_exists(service_type):
                raise ServiceNotExistsError, (self.get_service_name(service_type))
            
            if (self.is_force_mode or not self._is_running(service_type)):
                win32serviceutil.StartService(self.get_service_name(service_type), self.service_location)
                while (self._get_service_state(service_type) == self._service_state_start_pending and count_timeout != 0):
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
    
    def _stop(self, service_type):
        count_timeout = self.timeout_limit - 1
        try:
            if not self._is_exists(service_type):
                raise ServiceNotExistsError, (self.get_service_name(service_type))
            if (self.is_force_mode or self._is_running(service_type)):
                win32serviceutil.StopService(self.get_service_name(service_type), self.service_location)
                while (self._get_service_state(service_type) == self._service_state_stop_pending and count_timeout != 0):
                    time.sleep(1)
                    count_timeout -= 1
                if (count_timeout == 0):
                    raise TimeoutError, ('stop', self.get_service_name(service_type))  
                                  
                return True
        except ServiceNotExistsError, details:
            print details.get_message()
        except TimeoutError, details:
            print details.get_message(), 'Stop by kill process.'
            self._kill(service_type)
            
            return True
        except Exception, details:
            print 'Can\'t stop "' + self.get_service_name(service_type) + '" service: %s' % details
            
            return False
            
    def _kill(self, service_type):
        service_list = wmi.WMI().Win32_Service(DisplayName = self.get_service_name(service_type))
        if service_list:
            for service in service_list:
                handle = win32api.OpenProcess(win32con.PROCESS_TERMINATE, 0, service.ProcessId)
                win32api.TerminateProcess(handle, 0)
                win32api.CloseHandle(handle)                   
   
    def _set_debug_priveleges(self):
        token_handler = win32security.OpenProcessToken(win32api.GetCurrentProcess(), win32security.TOKEN_ADJUST_PRIVILEGES | win32security.TOKEN_QUERY)
        new_privs = [(win32security.LookupPrivilegeValue (None, win32security.SE_DEBUG_NAME), win32security.SE_PRIVILEGE_ENABLED)]
        win32security.AdjustTokenPrivileges (token_handler, 0, new_privs)
    
if __name__ == '__main__':
    try:
        options, args = getopt.getopt(sys.argv[1:], '', ['action=', 'port_data=', 'port_web=', 'is_default_data_service_name'])
        options = dict([(option[0].replace('--', ''), option[1]) for option in options])
        
        status = None
        helper = ServiceHelper()
        
        if 'is_default_data_service_name' in options:
            helper.use_default_corba_service_name(True) 
        
        if 'start' == options.get('action'):
            helper.set_corba_port(options.get('port_data')).set_zope_port(options.get('port_web')).set_force_mode(True).start()
        elif 'stop' == options.get('action'):
            helper.set_corba_port(options.get('port_data')).set_zope_port(options.get('port_web')).set_force_mode(True).stop()
        elif 'startData' == options.get('action'):
            service_action = 'start'
            service_type = 'Data'
            status = helper.set_corba_port(options.get('port_data')).set_zope_port(options.get('port_web')).set_force_mode(True).start_corba()            
        elif 'startWeb' == options.get('action'):
            service_action = 'start'
            service_type = 'Web'
            status = helper.set_corba_port(options.get('port_data')).set_zope_port(options.get('port_web')).set_force_mode(True).start_zope()
        elif 'stopData' == options.get('action'):
            service_action = 'stop'
            service_type = 'Data'
            status = helper.set_corba_port(options.get('port_data')).set_zope_port(options.get('port_web')).set_force_mode(True).stop_corba()            
        elif 'stopWeb' == options.get('action'):
            service_action = 'stop'
            service_type = 'Web'
            status = helper.set_corba_port(options.get('port_data')).set_zope_port(options.get('port_web')).set_force_mode(True).stop_zope()
            
        if None != status and True == status:
            print 'Service "%s" was %sed %s' % (helper.get_service_name(service_type), service_action,'successful.')
            
        if None != status and False == status:
            print 'Service "%s" was %sed %s' % (helper.get_service_name(service_type), service_action, 'fail.')
            
    except getopt.GetoptError, details:
        print details
        sys.exit(2)
        