# -*- coding: windows-1251 -*-

class ApplicationError(Exception):
    def get_error_code(self):
        return self._error_code

class InstallDirExistsError(ApplicationError):
    _error_code = 820010
    
    def get_message(self):
        return 'Error: install path "%s" is already exists.' % tuple(self)
        
class PreviousInstallInaccessible(ApplicationError):
    _error_code = 820020
    
    def get_message(self):
        return 'Error: previous install version at "%s" is inaccessible or wrong.' % tuple(self)
        
class PreviousInstallPasswordWrong(ApplicationError):
    _error_code = 820030
    
    def get_message(self):
        return 'Error: wrong manager password for previous install version at "%s".' % tuple(self)
        
class MountDriveRemoteError(ApplicationError):
    _error_code = 820040
    
    def get_message(self):
        return 'Error: can not mount network drive at "%s".' % tuple(self)    
        
class CreateTempDirError(ApplicationError):
    _error_code = 820050
    
    def get_message(self):
        return 'Error: can not create temp dir "%s" at "%s".' % tuple(self)
        
class CopyDistribError(ApplicationError):
    _error_code = 820060
    
    def get_message(self):
        return 'Error: can not copy distrib to "%s" at "%s".' % tuple(self)
        
class ExtractDistribError(ApplicationError):
    _error_code = 820070
    
    def get_message(self):
        return r'Error: can not extract "%s\distrib.exe" at "%s".' % tuple(self)
        
class InstallError(ApplicationError):
    _error_code = 820080
    
    def get_message(self):
        return r'Error: remote install finished with error %s. Details: %s' % tuple(self)

class CurrentInstallInaccessible(ApplicationError):
    _error_code = 820090
    
    def get_message(self):
        return 'Error: current install version at "%s" is inaccessible or wrong.' % tuple(self)