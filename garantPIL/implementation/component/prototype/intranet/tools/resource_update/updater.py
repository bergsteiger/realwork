# -*- coding: windows-1251 -*-

import re
from FileHelper import *

class ResourceUpdater:
    __filename_shell = ''
    __filename_intranet = ''
    __filename_pattern_output = ''
    
    def set_shell_resource(self, filename):
        self.__filename_shell = filename
        return self
    
    def set_intranet_resource(self, filename):
        self.__filename_intranet = filename
        return self
        
    def set_output_pattern(self, pattern):
        self.__filename_pattern_output = pattern
        return self
        
    def __get_shell_re(self):
        return re.compile(r'\{.+?\}\s+?(.+?)\s+?#\s+?(.+?)\s+?#', re.M | re.S | re.I)
        
    def __get_intranet_re(self):
        return re.compile(r'\{(.+?)\}\s+?(.+?)\s+?#\s+?#', re.M | re.S | re.I)
        
    def __format(self, identifier, part_ru, part_en):
        return '{%s}\n%s\n#\n%s\n#\n' % (identifier, part_ru, part_en) 
        
    def update(self):
        content_shell = FileHelper().get_content(self.__filename_shell)
        content_intranet = FileHelper().get_content(self.__filename_intranet)
        content_translated = content_not_translated = '' 
        
        replace_dictionary = {}
        for replace_tuple in re.findall(self.__get_shell_re(), content_shell):
            replace_dictionary.update({replace_tuple[0]: replace_tuple[1]})
        
        for intranet_pairs in re.findall(self.__get_intranet_re(), content_intranet):
            intranet_identifier, intranet_russian = intranet_pairs 
            if replace_dictionary.has_key(intranet_russian):
                content_translated += self.__format(intranet_identifier, intranet_russian, replace_dictionary[intranet_russian])
            else:
                content_not_translated += self.__format(intranet_identifier, intranet_russian, intranet_russian)                
            
        FileHelper().put_content(self.__filename_pattern_output + '.translated', content_translated)
        FileHelper().put_content(self.__filename_pattern_output + '.!translated', content_not_translated)

if __name__ == '__main__':
    #ResourceUpdater().set_source('shell.mo.small').set_destination('resource.small').set_output('resource.out').update()
    ResourceUpdater().set_shell_resource('shell.mo').set_intranet_resource('resource').set_output_pattern('resource').update()