# -*- coding: windows-1251 -*-

import urllib, httplib

class WrongPasswordException(Exception):
    pass

class HTTPErrorException(Exception):
    def __init__(self, status_code):
        self.status_code = status_code
    
    def get_status_code(self):
        return self.status_code
    
    def __str__(self):
        return "HTTPErrorException: StatusCode: %d" % self.status_code
    
class FileOperationErrorException(Exception):
    def __init__(self, filename):
        self.filename = filename
    
class FileDeleteErrorException(FileOperationErrorException):
    def __str__(self):
        return "FileDeleteErrorException: %s" % self.filename
    
class FileImportErrorException(FileOperationErrorException):
    def __str__(self):
        return "FileImportErrorException: %s" % self.filename

class importedFile:
    file_id = ''
    file_name = ''
    file_title = ''
    file_folder = ''
    file_type = 'OFSP/addDTMLDocument'
    file_content = ''

    def __init__(self, file_id, file_name):
        self.file_id = file_id
        self.file_name = file_name

    def set_content(self, file_content):
        self.file_content = file_content
        return self

    def get_content(self):
        if (self.file_content):
            return self.file_content

        file_handler = open(self.file_name, 'rb')
        file_content = file_handler.read()
        file_handler.close()
        return file_content

    def set_folder(self, file_folder):
        self.file_folder = file_folder
        return self

    def set_title(self, file_title):
        self.file_title = file_title
        return self

    def set_type(self, file_type):
        self.file_type = file_type
        return self


class urlOpenerZopeImport(urllib.FancyURLopener, object):
    version = 'zopeImporter/0.1'
    count_attempt = 0

    def __init__(self, auth, proxy = None):
        self.user_login = auth.get('user_login')
        self.user_password = auth.get('user_password')
        urllib.FancyURLopener.__init__(self, proxy)

    def prompt_user_passwd(self, host, realm):
         if (self.count_attempt < 3):
             self.count_attempt = self.count_attempt + 1
             return (self.user_login, self.user_password)
         else:
             self.count_attempt = 0
             raise WrongPasswordException

    def http_error_default(self, url, fp, errcode, errmsg, headers):        
        raise HTTPErrorException(errcode)

class zopeImporter:
    __REQUEST_ATTEMPTS_NUMBER = 10
    
    server_url = ''
    user_login = 'manager'
    user_password = ''
    is_delete_before_import = False

    def __init__(self, server_url = ''):
        if (server_url.find('http') == -1):
            server_url = 'http://' + server_url
        self.server_url = server_url

    def set_user_login(self, user_login):
        self.user_login = user_login
        self.update_url_opener()
        return self

    def set_user_password(self, user_password):
        self.user_password = user_password
        self.update_url_opener()
        return self

    def set_delete_before_import_mode(self, mode):
        self.is_delete_before_import = mode
        return self

    def update_url_opener(self):
        urllib._urlopener = urlOpenerZopeImport(auth={'user_login': self.user_login, 'user_password': self.user_password})

    def __get_delete_url(self, deleted_file):
        return self.server_url + deleted_file.file_folder

    def get_import_url(self, imported_file):
        return self.server_url + imported_file.file_folder + 'manage_addProduct/' + imported_file.file_type

    def check_server(self, url):
        if (url.strip() == ''):
            raise Exception, 'server url is empty'

        conn = httplib.HTTPConnection(url)
        conn.request('GET', '/')
        resp = conn.getresponse()


        if resp.getheader('Server')[0:4] != 'Zope':
            raise Exception, 'server is not Zope'

        return self

    def check_password(self, path = ''):
        urllib.urlopen(self.server_url + '/' + path)

    def __delete_file(self, deleted_file):
        params = urllib.urlencode({
            'ids:list': deleted_file.file_id,
            'manage_delObjects:method': 'Delete'
        })
        delete_attempts_count = self.__REQUEST_ATTEMPTS_NUMBER
        
        while delete_attempts_count:
            delete_attempts_count -= 1
            try:
                urllib.urlopen(self.__get_delete_url(deleted_file), params)
                print 'File successful deleted from attempts #%s' % (self.__REQUEST_ATTEMPTS_NUMBER - delete_attempts_count)
                return True
            except HTTPErrorException, exception:                
                print 'Error deleting file %s%s with code %s [#%s]' % (
                    self.__get_delete_url(deleted_file),
                    deleted_file.file_id,
                    exception.get_status_code(),
                    self.__REQUEST_ATTEMPTS_NUMBER - delete_attempts_count
                )
        
        raise FileDeleteErrorException(self.__get_delete_url(deleted_file) + deleted_file.file_id)

    def make_import(self, imported_file):
        if self.is_delete_before_import:
            self.__delete_file(imported_file)

        params = urllib.urlencode({
            'id': imported_file.file_id,
            'title': imported_file.file_title,
            'file': imported_file.get_content(),
            'submit': 'Add'
        })
        
        import_attempts_count = self.__REQUEST_ATTEMPTS_NUMBER
        
        while import_attempts_count:
            import_attempts_count -= 1
            try:
                urllib.urlopen(self.get_import_url(imported_file), params)
                print 'File successful imported from attempts #%s' % (self.__REQUEST_ATTEMPTS_NUMBER - import_attempts_count)
                return True
            except HTTPErrorException, exception:                
                print 'Error importing file %s with code %s [#%s]' % (
                    self.__get_import_url(import_file),
                    exception.get_status_code(),
                    self.__REQUEST_ATTEMPTS_NUMBER - import_attempts_count
                )
        
        raise FileImportErrorException(self.__get_import_url(imported_file))


if __name__ == '__main__':
    importer = zopeImporter('kupuyc.garant.ru:8923').set_user_login('kupuyc').set_user_password('pre30ner').set_delete_before_import_mode(True)
    file_to_import = importedFile('main_frame.html', r'main_frame.html').set_folder('SESSION/PILOT/main')

    while 1:
        try:
            importer.make_import(file_to_import)
            break
        except WrongPasswordException:
            importer.set_user_password(raw_input('Enter right password: '))