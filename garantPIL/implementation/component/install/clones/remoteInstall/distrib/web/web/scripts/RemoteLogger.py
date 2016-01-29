# -*- coding: windows-1251 -*-

import os, getopt, sys

class RemoteLogger:
    
    __host = 'iv2'
    __file = r'c$\clone_install.log'
    
    def reset(self):
        os.system(r'del \\%s\%s' % (self.__host, self.__file))
        
        return self
    
    def get_log_command(self, message):
        return r'echo %s >> \\%s\%s' % (message, self.__host, self.__file)
    
    def log(self, message):
        os.system(self.get_log_command(message))

if __name__ == '__main__':
    try:
        options, args = getopt.getopt(sys.argv[1:], '', 'message=')        
        RemoteLogger().log(options[0][1])
    except getopt.GetoptError, details:
        print details
        sys.exit(2)