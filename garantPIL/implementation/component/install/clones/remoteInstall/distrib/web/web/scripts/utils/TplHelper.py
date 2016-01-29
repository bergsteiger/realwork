# -*- coding: windows-1251 -*-

import string

class SaveNotCompiledTemplateError(Exception): pass
class CompileEmptyTemplateError(Exception): pass

class TplHelper:
    
    __var_marker = '##'
    __template_content_raw = None
    __template_content_compiled = None
        
    def open_template(self, filename):
        file = open(filename)
        self.__template_content_raw = file.read()
        file.close()
        __template_content_compiled = None
        
        return self
    
    def compile(self, var_dict):
        if not self.__template_content_raw:
            raise CompileEmptyTemplateError

        self.__template_content_compiled = self.__template_content_raw
        for pattern in var_dict.items():
            self.__template_content_compiled = string.replace(
                self.__template_content_compiled,
                self.__var_marker + pattern[0].strip() + self.__var_marker,
                pattern[1]
            )
        
        return self
        
    def save(self, filename):
        if not self.__template_content_compiled:
            raise SaveNotCompiledTemplateError
             
        file = open(filename, 'w+')
        file.write(self.__template_content_compiled)
        file.close()
        
        return self
        
if __name__ == '__main__':
    TplHelper().open_template('monitor_scripts/template.tpl').compile({'HOST': 'iv2', 'HOST_LOGIN': 'intranet'}).save('monitor_scripts/template.cmd')