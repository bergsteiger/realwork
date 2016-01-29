# -*- coding: windows-1251 -*-

import sys

sys.path.append('distrib\web\web\scripts')

from XmlCloneScheme import *
from Error import *
from ZopeImport import *

class RemoteImporter:
    __clone_scheme = None
        
    def __init__(self):
        self.__clone_scheme = XmlCloneScheme().parse().get_scheme()
            
    def run(self, file_to_import):
        for clone_config in self.__clone_scheme.clone_config_list:
            print '\npatching: %s:%s - %s%s' % (clone_config.uri, clone_config.old_port_zope, file_to_import.file_folder, file_to_import.file_name)
            try:                
                importer = zopeImporter('%s:%s' % (clone_config.uri, clone_config.old_port_zope)).set_user_login(clone_config.username).set_user_password(clone_config.password).set_delete_before_import_mode(True)
                importer.make_import(file_to_import)                              
            except Exception, exception:
                print exception
        
        return self

if __name__ == '__main__':
    print 'Start patching...'
    RemoteImporter().run(importedFile('counters.html', r'counters.html').set_folder('/')).run(importedFile('color.js', r'color.js').set_folder('/lib/'))