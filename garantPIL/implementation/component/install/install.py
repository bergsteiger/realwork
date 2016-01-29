#  -*- coding: windows-1251 -*-
import sys, os, string, time
import win32com.client


install_path = r'C:\Program Files\Garant-Intranet 2.1'

if (not os.path.exists (install_path)):
    install_path = r'C:\Program Files\Garant-Intranet'

corba_port = r'5151'
zope_port = r'80'
checkdir = 1

smtp_server_name = ''
smtp_server_login = ''
smtp_server_passwd = ''

import socket

def file_subst (filename, installpath, corbaport, zopeport, smtp_server_name = '', smtp_server_login = '', smtp_server_passwd = '', overwrite = 0, host_name = 'localhost'):
    f = open (filename+".dist")
    content = f.read ()
    f.close ()

    content = string.replace (content,r'##INSTALL_PATH##', installpath)
    content = string.replace (content,r'##CORBA_PORT##', corbaport)
    content = string.replace (content,r'##ZOPE_PORT##', zopeport)

    content = string.replace (content,r'##SMTP_SERVER_NAME##', smtp_server_name)
    content = string.replace (content,r'##SMTP_SERVER_LOGIN##', smtp_server_login)
    content = string.replace (content,r'##SMTP_SERVER_PASSWD##', smtp_server_passwd)
    content = string.replace (content,r'##SERVER_ID##', str(int(time.time())))
    content = string.replace (content,r'##HOST_NAME##', host_name)
    

#    if (not os.path.exists (filename) or overwrite):
    f = open(filename, "w+")
    f.write (content)
    f.close ()

def get_install_version ():
  import imp

  version = imp.load_compiled("version", r'Web\Instance\zope\Products\Garant\version.pyc')
  install_version = version.build_version

  return install_version


def get_installed_config (install_path):
  import imp

  try:
      zs = imp.load_compiled("zopeservice", r'%s\Web\Instance\bin\zopeservice.pyc' % install_path)
  except:
      return (5151, 80)

  return (zs.CORBA_PORT, zs.ZOPE_PORT)


def get_version (install_path):
  import imp

  try:
      version = imp.load_compiled("version", r'%s\Web\Instance\zope\Products\Garant\version.pyc' % install_path)
      current_version = version.build_version
  except:
      current_version = '0.0'

  return current_version

def ini_fix (filename, install_path):

    f = open (filename)
    content = f.read ()
    f.close ()

    content = string.replace (content, r'C:\Program Files\Garant-Nemesis', install_path)
    content = string.replace (content, r'##INSTALL_PATH##', install_path)

    f = open(filename, "w+")
    f.write (content)
    f.close ()


def f_start_data_setup (install_path):

    start_data_setup = 'Y'
    while 1:
      tmp = raw_input ("\n‡ ЇгбвЁвм ¬ бвҐа гбв ­®ўЄЁ ¤ ­­ле? [%s]\n(Run data setup? [%s]): " % (start_data_setup, start_data_setup))
      if (not tmp): break

      if (tmp in ('Y', 'y', 'N', 'n')):
        start_data_setup = tmp
        break;    

    if (start_data_setup in ['Y', 'y']):
        time.sleep (10)
        os.system(r'"%s\%s"' % (install_path, 'datasetup.exe'))

def f_stop_services (install_path):

    tmp = raw_input ("‘ЁбвҐ¬  ѓЂђЂЌ’-€­ва ­Ґв Ўг¤Ґв ®Ў­®ў«Ґ­ . „«п Їа®¤®«¦Ґ­Ёп Ё­бв ««пжЁЁ, Ї®¦ «г©бв , ­ ¦¬ЁвҐ Enter")

    print "Ћбв ­®ўЄ  б«г¦Ў ѓЂђЂЌ’-€­ва ­Ґв... "

    os.system (r'"%s\Web\Instance\bin\stopservice.bat"' % install_path)
    time.sleep (30)



install_version = get_install_version()
print "Џа®Ја ¬¬  гбв ­®ўЄЁ ‘ЁбвҐ¬л ѓЂђЂЌ’-€­ва ­Ґв, бЎ®аЄ : %s\n" % install_version

tmp = raw_input ("Џгвм Ё­бв ««пжЁЁ [%s]\n(Install path [%s]): " % (install_path, install_path))
if len(tmp) > 0:
    install_path = tmp

current_dir = os.getcwd()
current_version =  get_version (install_path)

if ((os.path.exists (install_path)) and (os.path.exists (r"%s\Web\Instance\bin\stopservice.bat" % install_path))):

    if os.path.isdir (install_path):
        msg = "Љ в «®Ј"
    elif os.path.isfile (install_path):
        msg = "” ©«"
    else:
        msg = "” ©« Ё«Ё Є в «®Ј"

    (corba_port, zope_port) = get_installed_config (install_path)

    file_subst (r'Web\Instance\bin\startservice.bat', install_path, corba_port, zope_port)
    file_subst (r'Web\Instance\bin\stopservice.bat', install_path, corba_port, zope_port)

    os.system (r'xcopy /Y /E Web\Instance\bin\startservice.bat "%s\Web\Instance\bin"' % (install_path))
    os.system (r'xcopy /Y /E Web\Instance\bin\stopservice.bat "%s\Web\Instance\bin"' % (install_path))

    print "ЋЎ­®ў«Ґ­ЁҐ ‘ЁбвҐ¬л ѓЂђЂЌ’-€­ва ­Ґв ..."

    if (current_version != '0.0'):
        file_subst (r'settings\xmltools\winNT\F1UsersSave.exe.bat', install_path, corba_port, zope_port, overwrite = 1)
        os.system (r'xcopy /Y /E settings\xmltools\winNT\F1UsersSave.exe.bat "%s\settings\xmltools\winNT\"' % (install_path))

    if (current_version == '2.1.b30'):
        os.system (r'xcopy /Y /E tools\fix_b31\F1UsersSave.exe  "%s\settings\xmltools\winNT\F1UsersSave.exe"' % (install_path))
        os.system (r'xcopy /Y /E tools\fix_b31\F1ServerStopper.exe "%s\apps\winNT\"' % (install_path))

    if (current_version == '2.1.b28'):
        os.system (r'xcopy /Y /E tools\fix_b29\F1ServerStopper.exe "%s\apps\winNT\"' % (install_path))

    if (current_version == '2.0.b5'):
        os.system (r'xcopy /Y /E tools\fix_b23\F1ServerStopper.exe "%s\apps\winNT\"' % (install_path))

    if (current_version in ('2.2.b30', '2.2.b31')):
        os.rename ("%s\\settings-xml" % install_path,  "%s\\settings-xml_2231" % install_path)
        #print r'xcopy /Y /E /F settings-xml "%s\settings-xml"' % (install_path)
        os.system (r'xcopy /Y /E /F settings-xml "%s\settings-xml\"' % (install_path))


    if (current_version in ('2.3.b27')):
        f_stop_services (install_path)
        os.system (r'xcopy /Y /E /F Web\Instance\zope\var\data.fs "%s\Web\Instance\zope\var\data.fs"' % (install_path))
        os.system (r'xcopy /Y /E /F Web\Instance\zope\Products\Garant\*.pyc "%s\Web\Instance\zope\Products\Garant\"' % (install_path))

        os.system (r'"%s\Web\Instance\bin\startservice.bat"' % install_path)
        print "ЋЎ­®ў«Ґ­ЁҐ § ўҐаиҐ­®."
        f_start_data_setup (install_path)
        sys.exit ()

    if (current_version in ('2.4.b0')):  # Замена сервера F1 и всех exe-файлов
        f_stop_services (install_path)
        os.rename (r'%s\Web\Instance\extensions' % install_path,  r'%s\Web\Instance\extensions_2411' % install_path)

        os.system (r'xcopy /Y /E /F Web\Instance\extensions\* "%s\Web\Instance\extensions\*"' % (install_path))
        os.system (r'xcopy /Y /E /F /O /X /K Web\Instance\extensions\InvalidName_pidl.pyc "%s\Web\Instance\extensions\InvalidName_pidl.pyc"' % (install_path))

        os.system (r'xcopy /Y /E /F apps\WinNT\* "%s\apps\WinNT\"' % (install_path))
        os.system (r'xcopy /Y /E /F apps\* "%s\apps\"' % (install_path))

        os.rename ("%s\\settings-xml" % install_path,  "%s\\settings-xml_2411" % install_path)
        os.system (r'xcopy /Y /E /F settings-xml "%s\settings-xml\"' % (install_path))
        
        os.system (r'xcopy /Y /F * "%s\"' % (install_path))

        os.system (r'"%s\Web\Instance\bin\startservice.bat"' % install_path)
        print "ЋЎ­®ў«Ґ­ЁҐ § ўҐаиҐ­®."
        f_start_data_setup (install_path)
        sys.exit ()


    try:
        os.mkdir (r'%s\tools' % (install_path))
    except: pass

    os.system (r'xcopy /Y /E tools\srvstop.bat "%s\tools\"' % (install_path))

    os.chdir (r'%s\tools' % install_path)
    os.system (r'"%s\tools\srvstop.bat"' % (install_path))
    os.chdir (current_dir)

    f_stop_services (install_path)


#    elif (current_version == install_version):
#        pass
    if (current_version == '2.0.b5'):
        os.chdir (r'%s\settings\xmltools\winNT' % install_path)
        os.system (r'"%s\settings\xmltools\winNT\F1UsersSave.exe.bat"' % (install_path))
        os.chdir (current_dir)

        time.sleep(5)
        os.rename ("%s\\settings" % install_path,  "%s\\settings_2131" % install_path)
        os.system (r'xcopy /Y /E /F settings "%s\settings\"' % (install_path))

    
    os.system (r'xcopy /Y /E /F settings\xmltools\winNT\F1UsersSave.exe  "%s\settings\xmltools\winNT\"' % (install_path))
    os.system (r'xcopy /Y /E /F tools\F1IniConverter.exe   "%s\tools\"' % (install_path))

    os.system (r'tools\F1IniConverter.exe -f "%s\garant.ini" -n "%s\garant.ini.dist"' % (install_path, current_dir))
    os.system (r'xcopy /Y /E /F Web\Instance\zope\var\data.fs "%s\Web\Instance\zope\var\data.fs"' % (install_path))

    os.system (r'xcopy /Y /E /F Web\Instance\zope\Products\Garant\*.pyc "%s\Web\Instance\zope\Products\Garant\"' % (install_path))
    os.system (r'xcopy /Y /E /F Web\Instance\zope\Products\Garant\*.py "%s\Web\Instance\zope\Products\Garant\"' % (install_path))
    #os.system (r'xcopy /Y /E /F Web\Instance\zope\Products\CookieLess\*.py "%s\Web\Instance\zope\Products\CookieLess\"' % (install_path))
    
    if (current_version != '0.0'):
        try:
            os.rename (r'%s\Web\Instance\extensions' % install_path,  r'%s\Web\Instance\extensions_2517' % install_path)
        except: pass
        try:
            os.rename (r'%s\settings-xml' % install_path,  r'%s\settings-xml_2517' % install_path)
        except: pass

    os.system (r'xcopy /Y /E /F settings-xml  "%s\settings-xml\"' % (install_path))
    os.system (r'xcopy /Y /E /F Web\Instance\extensions\* "%s\Web\Instance\extensions\*"' % (install_path))
    os.system (r'xcopy /Y /E /F /O /X /K Web\Instance\extensions\InvalidName_pidl.pyc "%s\Web\Instance\extensions\InvalidName_pidl.pyc"' % (install_path))

    
    os.system (r'xcopy /Y /E /F apps\WinNT\* "%s\apps\WinNT\"' % (install_path))
    os.system (r'xcopy /Y /E /F apps\* "%s\apps\"' % (install_path))
    os.system (r'xcopy /Y /E /F help\* "%s\help\"' % (install_path))
    os.system (r'xcopy /Y /F * "%s\"' % (install_path))

    os.system (r'xcopy /Y /E /F Web\lib\* "%s\Web\lib"' % (install_path))

    file_subst (r'Web\Instance\bin\zopeservice.py', install_path, corba_port, zope_port, overwrite = 1)
    os.system (r'xcopy /Y /E /F Web\Instance\bin\zopeservice.* "%s\Web\Instance\bin"' % (install_path))

    ini_fix ("%s\garant.ini" % (install_path), install_path)

    os.system (r'"%s\Web\Instance\bin\startservice.bat"' % install_path)
    
    print "ЋЎ­®ў«Ґ­ЁҐ § ўҐаиҐ­®."

    f_start_data_setup (install_path)

    sys.exit ()

elif (os.path.exists (install_path)):
    print "Љ в «®Ј г¦Ґ бгйҐбвўгҐв. Џа®¤®«¦Ґ­ЁҐ Ё­бв ««пжЁЁ ­Ґў®§¬®¦­®.\nFile or catalog already exists. Please choose another catalog."
    os.system ('pause')
    sys.exit()


tmp = raw_input ("\nЏ®ав ўҐЎ-бҐаўҐа  [%s]\n(Web server port [%s]): " % (zope_port, zope_port))
if len(tmp) > 0:
    zope_port = tmp    

tmp = raw_input ("\nЏ®ав бҐаўҐа  ЇаЁ«®¦Ґ­Ё© [%s]\n(Application server port [%s]): " % (corba_port, corba_port))
if len(tmp) > 0:
    corba_port = tmp

tmp = raw_input ("\n€¬п SMTP бҐаўҐа  [%s]\n(SMTP server name [%s]): " % (smtp_server_name, smtp_server_name))
if len(tmp) > 0:
    smtp_server_name = tmp

tmp = raw_input ("\n€¬п Ї®«м§®ў вҐ«п SMTP бҐаўҐа  [%s]\n(SMTP server username [%s]): " % (smtp_server_login, smtp_server_login))
if len(tmp) > 0:
    smtp_server_login = tmp

tmp = raw_input ("\nЏ а®«м ¤«п ¤®бвгЇ  Є SMTP бҐаўҐаг [%s]\n(SMTP server password [%s]): " % (smtp_server_passwd, smtp_server_passwd))
if len(tmp) > 0:
    smtp_server_passwd = tmp


os.system ('mkdir "%s"' % install_path)
if not os.path.isdir (install_path):
    print "ЌҐ г¤ «®бм б®§¤ вм Є в «®Ј\nCan't create dir", install_path

    if os.path.isfile (install_path):
        print "%s ¬®¦Ґв Ўлвм д ©«®¬ - б®ваЁвҐ ҐЈ®" % install_path
    sys.exit()


os.chdir (current_dir)

print "\nЉ®ЇЁаговбп д ©«л ў %s. Џ®¦ «г©бв , Ї®¤®¦¤ЁвҐ" % install_path
print "Please wait."

os.system (r'xcopy /Y /D /E /F * "%s" >"%s\install.log"' % (install_path, install_path))
os.system (r'xcopy /Y /E /F Web\Instance\zope\var\data.fs "%s\Web\Instance\zope\var\data.fs"' % (install_path))

os.chdir (install_path)



def create_shortcuts (install_path):
    f = open(r"%s\uninstall.ini" % install_path, "w+")

    shell = win32com.client.Dispatch("WScript.Shell")
    hostname = socket.getfqdn()

    start = "%s\\%s" % (shell.SpecialFolders("Programs").encode("cp1251"), "Гарант-Интранет")
    shortcuts = [
      ('Руководство по установке обновления банка данных', "%s\\%s" % (start, 'Документация'), '%s\\%s' % (install_path, 'help\\F1DataTools.chm')) 
      , ('Пакетное пополнение', "%s\\%s" % (start, 'Информационный банк'), '%s\\%s' % (install_path, 'dataupd.exe'))
      , ('Загрузка файлов пакетного пополнения', "%s\\%s" % (start, 'Информационный банк'), '%s\\%s' % (install_path, 'download.exe'))
      , ('Установка данных', "%s\\%s" % (start, 'Информационный банк'), '%s\\%s' % (install_path, 'datasetup.exe'))

      , ('ГАРАНТ', "%s" % (start), '%s' % ('http://%s:%s' % (hostname, zope_port)))
      , ('ГАРАНТ-Администратор', "%s" % (start), '%s' % ('http://%s:%s/admin' % (hostname, zope_port)))

      , ('Запустить службы ГАРАНТ-Интранет',  "%s" % (start), '%s\\%s' % (install_path, 'Web\\Instance\\bin\\startservice.bat'))
      , ('Остановить службы ГАРАНТ-Интранет', "%s" % (start), '%s\\%s' % (install_path, 'Web\\Instance\\bin\\stopservice.bat'))

      , ('Удаление ГАРАНТ-Интранет', "%s" % (start), '%s\\%s' % (install_path, 'uninstall.bat'))
    ]

    # e_start e_shortcuts !!
    e_start = "%s\\%s" % (shell.SpecialFolders("Programs").encode("cp1251"), "GARANT Intranet System")
    e_shortcuts = [
      ('User Manual for DataBase Update', "%s\\%s" % (start, 'Documentation'), '%s\\%s' % (install_path, 'help\\F1DataTools.chm'))

      , ('Packet Add-On', "%s\\%s" % (start, 'Informational Bank'), '%s\\%s' % (install_path, 'dataupd.exe'))
      , ('Packet Add-On Files Loading', "%s\\%s" % (start, 'Informational Bank'), '%s\\%s' % (install_path, 'download.exe'))
      , ('Data Installation', "%s\\%s" % (start, 'Informational Bank'), '%s\\%s' % (install_path, 'datasetup.exe'))

      , ('GARANT', "%s" % (start), '%s' % ('http://%s:%s' % (hostname, zope_port)))
      , ('GARANT Administration System', "%s" % (start), '%s' % ('http://%s:%s/admin' % (hostname, zope_port)))

      , ('Start GARANT Services',  "%s" % (start), '%s\\%s' % (install_path, 'Web\\Instance\\bin\\startservice.bat'))
      , ('Stop GARANT Services', "%s" % (start), '%s\\%s' % (install_path, 'Web\\Instance\\bin\\stopservice.bat'))

      , ('Uninstall Product', "%s" % (start), '%s\\%s' % (install_path, 'uninstall.bat'))
    ]


    os.system ('mkdir "%s"' % (start))

    for shortcut in shortcuts:
        os.system ('mkdir "%s"' % (shortcut[1]))

        f.write ("%s\\%s.lnk\n" % (shortcut[1], shortcut[0]))

        scut = shell.CreateShortCut ("%s\\%s.lnk" % (shortcut[1], shortcut[0]))
        scut.Targetpath = "%s" % shortcut[2]

        scut.save ()

    f.write ("%s\n" % start)

    f.close ()



file_subst (r'pilot\pilotuserssave.bat', install_path, corba_port, zope_port)
file_subst (r'Web\Instance\etc\zope.conf', install_path, corba_port, zope_port)
file_subst (r'Web\Instance\bin\runservice.bat', install_path, corba_port, zope_port)
file_subst (r'Web\Instance\bin\runzope.bat', install_path, corba_port, zope_port)
file_subst (r'Web\Instance\bin\zopeservice.py', install_path, corba_port, zope_port)
file_subst (r'Web\Instance\bin\appservice.py', install_path, corba_port, zope_port)

file_subst (r'Web\Instance\bin\startservice.bat', install_path, corba_port, zope_port)
file_subst (r'Web\Instance\bin\stopservice.bat', install_path, corba_port, zope_port)

file_subst (r'Web\Instance\omni-ORB.cfg', install_path, corba_port, zope_port)

file_subst (r'settings\xmltools\winNT\f1userssave.exe.bat', install_path, corba_port, zope_port)

file_subst (r'garant.ini', install_path, corba_port, zope_port, smtp_server_name, smtp_server_login, smtp_server_passwd)
file_subst (r'uninstall.bat', install_path, corba_port, zope_port)
file_subst (r'logon.wsf', install_path, corba_port, zope_port, host_name = socket.getfqdn())

os.system (r'copy Web\bin\msvcr71.dll %SystemRoot%\system32')

create_shortcuts (install_path)



import _winreg

service_name = 'Garant Intranet Data %s:%s' % (corba_port, zope_port)

sub_key = r'SOFTWARE\%s' % service_name

aReg = _winreg.ConnectRegistry(None,_winreg.HKEY_LOCAL_MACHINE)
gar_key = _winreg.CreateKey(_winreg.HKEY_LOCAL_MACHINE, sub_key)
_winreg.SetValueEx (gar_key, "ApplicationServerOptions", None, _winreg.REG_SZ, r'-GCMConfigFile "%s\garant.ini"' % install_path)
_winreg.SetValueEx (gar_key, "-ClearGuests", None, _winreg.REG_SZ, "false")


aaa = """
start_converter = 'N'
while 1:
  tmp = raw_input ("\n‡ ЇгбвЁвм Їа®жҐ¤гаг Є®­ўҐав жЁЁ ­ бва®ҐЄ? [%s]\n(Run settings converter? [%s]): " % (start_converter, start_converter))
  if (not tmp): break

  if (tmp in ('Y', 'y', 'N', 'n')):
    start_converter = tmp
    break;    
  

if (start_converter in ['Y', 'y']):
    os.system (r'pilot\pilotuserssave.bat')
"""


os.chdir (r'Web\Instance\bin')
os.system ("installservice")
os.system ("startservice")

f_start_data_setup (install_path)
