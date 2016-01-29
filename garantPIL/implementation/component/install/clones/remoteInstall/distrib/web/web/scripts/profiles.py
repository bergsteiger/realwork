# -*- coding: windows-1251 -*-
import urllib, string, os, traceback
import httplib

class iProfiles:
    url_opener = None
    login = ''
    password = ''
    server_url = ''
    server_path = ''
    profiles = []

    def __init__ (self):
        pass

    def check_server (self, url):
      status = 0

      try:
          if (url.strip() == ''):
              raise Exception
          conn = httplib.HTTPConnection(url)
          conn.request ('GET', '/')
          resp = conn.getresponse ()
          
          if (resp.getheader('Server')[0:4] == 'Zope'):
            status = resp.status
      except:
        pass

      return (status != 0)

    def set_server (self, url='', path='', l='supermanager', p='!supermanager'):
        self.login = l
        self.password = p
        self.server_url = url
        self.server_path = path
        urllib._urlopener = None
        return self        

    def get_profiles_list (self):
        server_url = 'http://%s:%s@%s/profiles/get_profiles_list' % (self.login, self.password, self.server_url)
            
        data = urllib.urlopen (server_url)
        for p in data.readlines ():
            self.profiles.append (string.strip(p))
            
        data.close ()
        
    def export_profiles (self):
        
        for name in self.profiles:
            self._get (name)

        print '\nЊЁЈа жЁп Їа®дЁ«Ґ©: нЄбЇ®ав гбЇҐи­® § ўҐаиҐ­'

    def import_profiles (self):   
    
        for name in self.profiles:
            if (name == 'etalon'): continue
            self._put (name)

        print '\nЊЁЈа жЁп Їа®дЁ«Ґ©: Ё¬Ї®ав гбЇҐи­® § ўҐаиҐ­'

    def _get (self, profile_name):
        server_url = 'http://%s:%s@%s/profiles/manage_exportObject/?download:int=1&id=%s&submit=Export' % (self.login, self.password, self.server_url, profile_name)
        import_path = r'%s\Web\import' % (self.server_path)

        try:
            os.mkdir  (import_path)
        except: pass        
        
        (f_name, http_message) = urllib.urlretrieve (server_url, r'%s\%s.zexp' % (import_path, profile_name))
        #os.system (r'xcopy /Y /D /E /Q *.zexp "%s\Web\import"' % ())

    def _put (self, profile_name):        
        delete_url = 'http://%s:%s@%s/profiles/?ids:list=%s&manage_delObjects:method=Delete' % (self.login, self.password, self.server_url, profile_name)

        # предварительно удалим, уже существующий профиль
        data = urllib.urlopen (delete_url)
        
        # Это новая инсталляция, логин и пароль еще дефолтные
        import_url = 'http://%s:%s@%s/profiles/manage_importObject/?set_owner:int=0&file=%s.zexp&submit=Import' % (self.login, self.password, self.server_url, profile_name)
            
        # загрузим профиль
        data = urllib.urlopen (import_url)
