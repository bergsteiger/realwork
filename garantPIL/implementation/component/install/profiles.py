# -*- coding: windows-1251 -*-
import urllib, string, os

class iProfiles:
    url_opener = None
    login = ''
    password = ''
    server_url = ''
    server_path = ''
    profiles = []

    def __init__ (self):
        pass

    def set_server (self, url='', path='', l='manager', p='!manager'):
        self.login = l
        self.password = p
        self.server_url = url
        self.server_path = path

    def get_profiles_list (self):
        server_url = 'http://%s:%s@%s/profiles/get_profiles_list' % (self.login, self.password, self.server_url)
            
        data = urllib.urlopen (server_url)

        for p in data.readlines ():
            self.profiles.append (string.strip(p))
            
        data.close ()
        
    def export_profiles (self):
        print 'export start'
        
        for name in self.profiles:
            self._get (name)

        print 'export done'

    def import_profiles (self):
        print 'import start'
        try:
            os.mkdir  (r'%s\Web\import' % (self.server_path))
        except: pass
        os.system (r'xcopy /Y /D /E /F *.zexp "%s\Web\import"' % (self.server_path))
    
        for name in self.profiles:
            if (name == 'etalon'): continue
            print name
            self._put (name)

        print 'import done'

    def _get (self, profile_name):
        server_url = 'http://%s:%s@%s/profiles/manage_exportObject/?download:int=1&id=%s&submit=Export' % (
            self.login, self.password, self.server_url, profile_name)
        
        (f_name, http_message) = urllib.urlretrieve (server_url, r'.\%s.zexp' % profile_name)

    def _put (self, profile_name):
        delete_url = 'http://%s:%s@%s/profiles/?ids:list=%s&manage_delObjects:method=Delete' % (
            self.login, self.password, self.server_url, profile_name)

        # предварительно удалим, уже существующий профиль
        data = urllib.urlopen (delete_url)
        #print delete_url
        
        # Это новая инсталляция, логин и пароль еще дефолтные
        import_url = 'http://%s:%s@%s/profiles/manage_importObject/?set_owner:int=0&file=%s.zexp&submit=Import' % (
            self.login, self.password, self.server_url, profile_name)
            
        # загрузим профиль
        data = urllib.urlopen (import_url)
        #print import_url


a = iProfiles ()
a.set_server (url='nash.garant.ru')
a.get_profiles_list ()
a.export_profiles ()
a.set_server (url='nash.garant.ru:8088', path=r'c:\in222')
a.import_profiles ()