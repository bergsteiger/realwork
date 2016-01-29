#  -*- coding: windows-1251 -*-

import sys

#sys.path.append('..\distrib\web\web\scripts')

import base64
import xml.dom.minidom as xmldom
from utils.XmlHelper import *
from ZopeImport import *

class PatchConfig:   
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
    
    def __getattr__(self, key):
        try:
            return self.__dist__[key]
        except:
            return ''
            

class PatchScheme:
    __patch_list = None
    
    def get_patch_list(self):
        return self.__patch_list
        
    def parse(self, xml_file = 'update.xml'):
        dom = xmldom.parse(xml_file)
        dom.normalize()
        
        self.__obtain_patch_list(dom)
        
        return self
        
    def __obtain_patch_list(self, dom):
        self.__patch_list = []
        for patch_element in dom.getElementsByTagName('patch'):
            patch_config = PatchConfig().import_from_xml_element(patch_element)
            self.__patch_list.append(patch_config)
        

class ClonePatcher:
    LOG_FILE_NAME = 'update.log'
        
    __updater_login = 'kupuyc'
    __updater_password = 'pre30ner'
    __host_uri = None
    
    def __init__(self):
        self.__log('Update started', 'w')
    
    def __log(self, message, mode = 'a'):
        file_handler = open(self.LOG_FILE_NAME, mode)
        file_content = file_handler.write(('%s' % message) + '\n')
        file_handler.close()
    
    def __prompt_host_config(self):
        while 1:
            self.__host_uri = raw_input ('Ђ¤аҐб ®Ў­®ў«пҐ¬®Ј® е®бв  б Ї®ав®¬ (­ ЇаЁ¬Ґа: server.com:8181)\n(Host address with port (example: server.com:8181)): ').strip()
            try:
                zopeImporter(self.__host_uri).set_user_login(self.__updater_login).set_user_password(self.__updater_password).check_server(self.__host_uri).check_password('SESSION')                    
                break
            except Exception, details:
                self.__log('Check connection error: ' + self.__host_uri)

    def run(self):
        self.__prompt_host_config()
        self.__log('Host: ' + self.__host_uri)
        patch_list = PatchScheme().parse().get_patch_list()
        for patch in patch_list:
            try:
                self.__log('Try import: ' + patch.name)                
                importer = zopeImporter(self.__host_uri).set_user_login(self.__updater_login).set_user_password(self.__updater_password).set_delete_before_import_mode(True)
                file_to_import = importedFile(patch.name, patch.name).set_folder(patch.path).set_content(base64.b64decode(patch.code))
                importer.make_import(file_to_import)
            except Exception, details:
                self.__log('Import of "%s" error: %s' % (patch.name, details))
                return False
        self.__log('Update finished')
        
        return True