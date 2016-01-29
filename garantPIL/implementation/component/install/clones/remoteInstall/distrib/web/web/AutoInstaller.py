# -*- coding: windows-1251 -*-

import os, sys, getopt, time, string, _winreg

sys.path.append('scripts')

from CloneConfig import *
from profiles import *
from ZopeImport import *
from utils.ServiceHelper import *
from utils.TplHelper import *
from Error import *
from RemoteLogger import *

class AutoInstaller:
    __config = None
    __CLI_options = [
        'username=',
        'password=',
        'version=',
        'build=',
        'name=',
        'uri=',
        'host=',        
        'localdistrib=',
        'old_port_corba=',
        'old_port_zope=',
        'new_port_corba=',
        'new_port_zope='
    ]
    __files_for_update_by_config = (
        r'Web\Instance\etc\zope.conf',
        r'Web\Instance\bin\runservice.bat',
        r'Web\Instance\bin\runzope.bat',
        r'Web\Instance\bin\zopeservice.py',
        r'Web\Instance\bin\appservice.py',
        r'Web\Instance\bin\startservice.bat',
        r'Web\Instance\bin\stopservice.bat',
        r'Web\Instance\omni-ORB.cfg',
        r'settings\xmltools\winNT\f1userssave.exe.bat',
        r'garant.ini',
        r'uninstall.bat'
    )    
    __manager_login = 'supermanager'
    __manager_password = '!supermanager'
    __check_manager_password_path = 'profiles'
    
    def __init__(self):
        self.__remote_logger = RemoteLogger()
        self.__config = self.__get_config()
        if not len(self.__config.get_distrib_path()):
            self.__config.set_distrib_path(os.getcwd())  
    
    def __get_config(self):
        try:
            options, args = getopt.getopt(sys.argv[1:], '', self.__CLI_options)
            return CloneConfig().import_from_command_line(options)
        except getopt.GetoptError, details:
            print details
            sys.exit(2)
    
    def __update_file_by_config(self, filename):
        TplHelper().open_template(filename + '.dist').compile({
            'INSTALL_PATH': self.__config.get_install_path(),
            'CORBA_PORT': self.__config.new_port_corba,
            'ZOPE_PORT': self.__config.new_port_zope,
            'SMTP_SERVER_NAME': self.__config.new_port_smtp,       #always empty
            'SMTP_SERVER_LOGIN': self.__config.new_smtp_login,     #always empty
            'SMTP_SERVER_PASSWD': self.__config.new_smtp_password, #always empty
            'SERVER_ID': str(int(time.time()))            
        }).save(filename)
        
    def __check_install_path(self):
        if os.path.exists(self.__config.get_install_path()):
            raise InstallDirExistsError, (self.__config.get_install_path())
            
    def __check_previous_install_accessible(self):
        urlPrevious = self.__config.uri + ':' + self.__config.old_port_zope
        if not iProfiles().check_server(urlPrevious):
            raise PreviousInstallInaccessible, (urlPrevious)
            
    def __check_manager_password(self):
        urlPrevious = self.__config.uri + ':' + self.__config.old_port_zope
        try:
            zopeImporter(urlPrevious).setUserLogin('supermanager').setUserPassword(self.__manager_password).checkPassword(self.__check_manager_password_path)
        except ExceptionWrongPassword:
            raise PreviousInstallPasswordWrong, (urlPrevious) 
            
    def check_install_possibility(self):
        try:
            self.__check_install_path()
            self.__check_previous_install_accessible()
            self.__check_manager_password()
        except ApplicationError, details:
            print details.get_message()
            sys.exit(details.get_error_code())
            
    def __is_current_install_accessible(self):
        url = self.__config.uri + ':' + self.__config.new_port_zope
        return iProfiles().check_server(url)
        
    def __is_overwrite_type_update(self):
        return self.__config.new_port_zope == self.__config.old_port_zope and self.__config.new_port_corba == self.__config.old_port_corba
        
    def copy_files(self):
        os.system(r'mkdir "%s"' % self.__config.get_install_path())        
        os.system(r'xcopy /Y /D /E /F * "%s" >"%s\install.log"'
            % (self.__config.get_install_path(), self.__config.get_install_path()))
        os.system(r'xcopy /Y /E /F "%s\Web\Instance\zope\var\data.fs" "%s\Web\Instance\zope\var\data.fs"'
            % (self.__config.get_distrib_path(), self.__config.get_install_path()))
        os.system (r'copy Web\bin\msvcr71.dll %SystemRoot%\system32')
            
    def update_files_by_config(self):
        os.chdir(self.__config.get_install_path())
        for filename in self.__files_for_update_by_config:            
            self.__update_file_by_config(filename)
            
    def install_or_update_services(self):
        service_key = 'SOFTWARE\Garant Intranet Data %s:%s' % (self.__config.new_port_corba, self.__config.new_port_zope)
    
        aReg = _winreg.ConnectRegistry(None,_winreg.HKEY_LOCAL_MACHINE)
        service_key_handler = _winreg.CreateKey(_winreg.HKEY_LOCAL_MACHINE, service_key)
        _winreg.SetValueEx (service_key_handler, "ApplicationServerOptions", None, _winreg.REG_SZ, r'-GCMConfigFile "%s\garant.ini"' % self.__config.get_install_path())
        _winreg.SetValueEx (service_key_handler, "-ClearGuests", None, _winreg.REG_SZ, "false")
        
        os.chdir(self.__config.get_install_path())
        os.chdir(r'Web\Instance\bin')    
        os.system('installservice')
        time.sleep(30)
        
    def make_profiles_migration(self):
        url_previous = self.__config.uri + ':' + self.__config.old_port_zope
        
        profile_migrator = iProfiles()
       
        importer = zopeImporter(url_previous).setUserLogin('supermanager').setUserPassword(self.__manager_password)
        file_to_import = importedFile('get_profiles_list', 'get_profiles_list').setFolder('profiles').setContent('<dtml-in "profiles.objectItems(\'Folder\')" sort=\'id\'><dtml-let key=sequence-key name=sequence-item><dtml-if "name.hasProperty(\'profileName\')"><dtml-var sequence-key>\n</dtml-if></dtml-let></dtml-in>')        
        
        importer.makeImport(file_to_import)
        
        profile_migrator.set_server(url = url_previous, l = self.__manager_login, p = self.__manager_password, path = self.__config.get_install_path())
        profile_migrator.get_profiles_list()
        profile_migrator.export_profiles()
        
        if self.__is_overwrite_type_update():
            ServiceHelper().set_corba_port(self.__config.old_port_corba).set_zope_port(self.__config.old_port_zope).stop()
        
        self.install_or_update_services()        
        
        ServiceHelper().set_corba_port(self.__config.new_port_corba).set_zope_port(self.__config.new_port_zope).start()
        
        if self.__is_current_install_accessible():
            profile_migrator.set_server(url = self.__config.uri + ':' + self.__config.new_port_zope, path = self.__config.get_install_path(), l = self.__manager_login, p = self.__manager_password)
            profile_migrator.import_profiles()
        else:
            raise CurrentInstallInaccessible, (self.__config.uri + ':' + self.__config.new_port_zope)

    def run(self):
        self.check_install_possibility()
        
        try:
            self.__remote_logger.log('\copy files after extract')
            #self.copy_files()
            #self.__remote_logger.log('\update files by config')
            #self.update_files_by_config()
            #self.__remote_logger.log('\profiles migration')
            #self.make_profiles_migration()
        except ApplicationError, details:
            print details.get_message()
            sys.exit(details.get_error_code())

if __name__ == '__main__':
    AutoInstaller().run()