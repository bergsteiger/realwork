# -*- coding: windows-1251 -*-

import os, sys, tempfile

sys.path.append('distrib\web\web\scripts')

from XmlCloneScheme import *
from Error import *
from utils.FileHelper import *
from utils.TplHelper import *
from RemoteLogger import *

class RemoteInstaller:
    __clone_scheme = None
    __remote_logger = None
        
    def __init__(self):
        self.__clone_scheme = XmlCloneScheme().parse().get_scheme()
        self.__remote_logger = RemoteLogger().reset()
        
    def __psexec(self, host, command, options = ''):
        print r'pstools\psexec.exe \\%s %s %s' % (host, options, command)
        return os.system(r'pstools\psexec.exe \\%s -i %s %s' % (host, options, command))
        
    def __write_scenario_command_with_log(self, scenario_file, command):
        FileHelper.writeln(scenario_file, self.__remote_logger.get_log_command("'%s'" % command))
        FileHelper.writeln(scenario_file, command)
        
    def __make_mount_drive_scenario_section(self, scenario_file, clone_config):
        FileHelper.writeln(scenario_file, r'net use b: /D')
        FileHelper.writeln(scenario_file, r'net use b: \\kupuyc\clone_auto_install /user:kupuyc kupuyc /PERSISTENT:NO')
        
    def __make_create_temp_dir_scenario_section(self, scenario_file, clone_config):
        temp_dir_name = clone_config.get_install_path() + '_distrib'
        self.__write_scenario_command_with_log(scenario_file, r'mkdir "%s"' % temp_dir_name)
        clone_config.set_distrib_path(temp_dir_name)
    
    def __make_copy_local_distrib_scenario_section(self, scenario_file, clone_config):        
        #FileHelper.writeln(scenario_file, r'xcopy /Y b:\distrib.exe %s' % clone_config.get_distrib_path())
        self.__write_scenario_command_with_log(scenario_file, r'xcopy /Y c:\distrib\distrib.exe "%s"' % clone_config.get_distrib_path())
        
    def __make_copy_remote_distrib_scenario_section(self, scenario_file, clone_config):        
        #FileHelper.writeln(scenario_file, r'xcopy /Y b:\distrib.exe %s' % clone_config.get_distrib_path())
        self.__write_scenario_command_with_log(scenario_file, r'xcopy /Y \\iv2\c$\distrib\distrib.exe "%s"' % clone_config.get_distrib_path())
        
    def __make_extract_distrib_scenario_section(self, scenario_file, clone_config):
        self.__write_scenario_command_with_log(scenario_file, r'%s' % clone_config.get_distrib_path()[0:2])
        self.__write_scenario_command_with_log(scenario_file, r'cd "%s"' % clone_config.get_distrib_path())
        self.__write_scenario_command_with_log(scenario_file, r'distrib.exe')
        
    def __make_run_install_scenario_section(self, scenario_file, clone_config):
        self.__write_scenario_command_with_log(scenario_file, r'cd "%s\web\web"' % clone_config.get_distrib_path())
        self.__write_scenario_command_with_log(scenario_file, r'set PATH=Web\bin;%PATH%')
        self.__write_scenario_command_with_log(scenario_file, r'set PYTHONPATH=Web\lib')
        self.__write_scenario_command_with_log(scenario_file, 
            r'Web\bin\python AutoInstaller.py %s %s' % (
                self.__clone_scheme.export_options_to_command_line(), clone_config.export_to_command_line()
            )
        )
        
    def __make_install_scenario(self, clone_config):
        scenario_name = clone_config.name + '_install_scenario.cmd'
        
        scenario_file = open(scenario_name, 'w+')
        
        #self.__make_mount_drive_scenario_section(scenario_file, clone_config)
        self.__make_create_temp_dir_scenario_section(scenario_file, clone_config)
        if len(clone_config.localdistrib):
            self.__make_copy_local_distrib_scenario_section(scenario_file, clone_config)
        else:
            self.__make_copy_remote_distrib_scenario_section(scenario_file, clone_config)
        self.__make_extract_distrib_scenario_section(scenario_file, clone_config)
        self.__make_run_install_scenario_section(scenario_file, clone_config)
        
        scenario_file.close()
        
        return scenario_name
        
    def __run_install_scenario(self, scenario_name, clone_config):
        install_exit_code = self.__psexec(
            clone_config.host,
            r'-c %s' % scenario_name,
            '-u "%s" -p "%s"' % (self.__clone_scheme.options.get('username'), self.__clone_scheme.options.get('password'))
        )
        if install_exit_code != 0:
            raise InstallError, (install_exit_code, clone_config.uri) 
    
    def __make_monitoring_script(self, clone_config):
        TplHelper().open_template('monitor_scripts/template.tpl').compile({
            'VERSION': clone_config.version,
            'HOST': clone_config.host,
            'HOST_LOGIN': clone_config.username,
            'HOST_PASSWORD': clone_config.password,
            'PORT_CORBA': clone_config.new_port_corba,
            'PORT_ZOPE': clone_config.new_port_zope,
            'INSTALL_PATH': clone_config.get_install_path()[3:]            
        }).save('monitor_scripts/' + clone_config.get_monitoring_script_name() + '.cmd')
            
    def run(self):
        for clone_config in self.__clone_scheme.clone_config_list:
            try:                
                self.__remote_logger.log('Start install for %s' % clone_config.name)                
                self.__remote_logger.log('make install scenario')
                scenario_name = self.__make_install_scenario(clone_config)
                self.__remote_logger.log('run install scenario')
                self.__run_install_scenario(scenario_name, clone_config)
                self.__remote_logger.log('make monitoring script')
                self.__make_monitoring_script(clone_config)
                self.__remote_logger.log('Finish install for %s' % clone_config.name)
                self.__remote_logger.log('------------------------------------------')                
            except InstallError, details:
                print details.get_message()


if __name__ == '__main__':
    RemoteInstaller().run()