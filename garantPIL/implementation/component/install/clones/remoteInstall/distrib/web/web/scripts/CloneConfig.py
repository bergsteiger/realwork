# -*- coding: windows-1251 -*-

import xml.dom.minidom as xmldom
from utils.XmlHelper import *

class CloneConfig:
    __distrib_path = ''

    def import_from_command_line(self, options):
        for option, value in options:
            self.__dict__[option[2:]] = value
        return self
    
    def export_to_command_line(self):
        result = []
        for property in self.__dict__:
            if property[0] != '_':
                result.append('--' + property + '=' + self.__dict__[property])
        return ' '.join(result)
    
    def import_from_xml_element(self, element):
        for node in element.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                self.__convert_node_to_property(node)
        return self
        
    def __convert_node_to_property(self, node, property_name = ''):
        if len(property_name):
            property_name = property_name + '_' + node.nodeName
        else:
            property_name = node.nodeName
        if len(node.childNodes) == 1:
            self.__dict__[property_name] = XmlHelper.get_element_value(node)
        else:
            for child in node.childNodes:
                if child.nodeType == child.ELEMENT_NODE:
                    self.__convert_node_to_property(child, property_name)
        
    def set_distrib_path(self, path):
        self.__distib_path = path.strip()
        return self
        
    def get_distrib_path(self):
        return self.__distib_path
    
    def get_install_path(self):
        return 'C:\\Clones ' + self.version + '\\' + '_'.join((self.name, 'b' + self.build, self.new_port_zope))
        
    def get_monitoring_script_name(self):
        return '_'.join((self.name, 'b' + self.build, self.new_port_zope))  
        
    def check_integrity(self):
        pass
    
    def __getattr__(self, key):
        try:
            return self.__dist__[key]
        except:
            return ''
    
    def dump(self):
        print self.__dict__

if __name__ == '__main__':
    print CloneConfig().import_from_command_line([('--option1', 'value1'), ('--option2', 'value2')]).option1