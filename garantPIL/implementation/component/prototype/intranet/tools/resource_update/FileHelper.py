# -*- coding: windows-1251 -*-

class FileHelper:
    
    @staticmethod
    def writeln(file, line):
        file.write(line + '\n')
        
    @staticmethod
    def get_content(filename):
        try:
            file_handler = open(filename)
            result = file_handler.read()
            file_handler.close()
            return result
        except:
            return None
    
    @staticmethod
    def put_content(filename, content = '', file_mode = 'w'):
        try:
            file_handler = open(filename, file_mode)
            result = file_handler.write(content)
            file_handler.close()
            return True
        except:
            return False