# -*- coding: windows-1251 -*-

import xml.dom.minidom as xmldom
from CloneConfig import *
from utils.XmlHelper import *

class CloneScheme:
    def export_options_to_command_line(self):
        if not self.options:
            return ''
            
        result = []
        for option in self.options.items():
            result.append('--%s=%s' % option)
        return ' '.join(result)

class XmlCloneScheme:
    __scheme = None
    
    def get_scheme(self):
        return self.__scheme
        
    def parse(self, xml_file = 'clones.xml'):
        self.__scheme = CloneScheme()
        dom = xmldom.parse(xml_file)
        dom.normalize()
        
        self.__obtain_scheme_options(dom)
        self.__obtain_clone_config_list(dom)
        
        return self
        
    def __obtain_scheme_options(self, dom):
        self.__scheme.options = {}
        for option in dom.getElementsByTagName('options')[0].childNodes:
            if option.nodeType != option.TEXT_NODE:
                self.__scheme.options.update({option.nodeName: XmlHelper.get_element_value(option)})
    
    def __obtain_clone_config_list(self, dom):
        self.__scheme.clone_config_list = []
        for clone_element in dom.getElementsByTagName('clone'):
            clone_config = CloneConfig().import_from_xml_element(clone_element)
            clone_config.version = self.__scheme.options.get('version')
            clone_config.build = self.__scheme.options.get('build')
            clone_config.username = self.__scheme.options.get('username')
            clone_config.password = self.__scheme.options.get('password')
            self.__scheme.clone_config_list.append(clone_config)
        
if __name__ == '__main__':
    #print XmlCloneScheme().parse().get_scheme().clone_config_list[0].old_port_corba
    #print XmlCloneScheme().parse().get_scheme().options.get('username')
    print XmlCloneScheme().parse().get_scheme().export_options_to_command_line()   