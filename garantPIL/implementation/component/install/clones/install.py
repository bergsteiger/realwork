#  -*- coding: windows-1251 -*-
import sys, os, string, time
import win32com.client
import _winreg
from serviceHelper import *

install_path = r'C:\Program Files\Garant-Intranet Clone'

corba_port = r'5151'
zope_port = r'80'
checkdir = 1

smtp_server_name = ''
smtp_server_login = ''
smtp_server_passwd = ''

def file_subst (filename, installpath, corbaport, zopeport, smtp_server_name = '', smtp_server_login = '', smtp_server_passwd = '', overwrite = 0):
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
        os.system(r'"%s\%s"' % (install_path, 'datasetup.exe'))

def f_stop_services (install_path):

    print "\nЋбв ­®ўЄ  б«г¦Ў ѓЂђЂЌ’-€­ва ­Ґв... "

    os.system (r'"%s\Web\Instance\bin\stopservice.bat"' % install_path)
    time.sleep (30)

def f_start_services (install_path):

    print "\n‡ ЇгбЄ б«г¦Ў ѓЂђЂЌ’-€­ва ­Ґв... "

    os.system (r'"%s\Web\Instance\bin\startservice.bat"' % install_path)
    time.sleep (30)

install_version = get_install_version()
print "Џа®Ја ¬¬  гбв ­®ўЄЁ ‘ЁбвҐ¬л ѓЂђЂЌ’-€­ва ­Ґв Љ«®­, бЎ®аЄ : %s\n" % install_version

tmp = raw_input ("Џгвм Ё­бв ««пжЁЁ [%s]\n(Install path [%s]): " % (install_path, install_path))
if len(tmp) > 0:
    install_path = tmp

current_dir = os.getcwd()
current_version =  get_version (install_path)

if (os.path.exists (install_path)):
    print "Љ в «®Ј г¦Ґ бгйҐбвўгҐв. Џа®¤®«¦Ґ­ЁҐ Ё­бв ««пжЁЁ ­Ґ ў®§¬®¦­®.\nFile or catalog already exists. Please choose another catalog."
    os.system ('pause')
    sys.exit()

tmp = raw_input ("\nЏ®ав ўҐЎ-бҐаўҐа  [%s]\n(Web server port [%s]): " % (zope_port, zope_port))
if len(tmp) > 0:
    zope_port = tmp

tmp = raw_input ("\nЏ®ав бҐаўҐа  ЇаЁ«®¦Ґ­Ё© [%s]\n(Application server port [%s]): " % (corba_port, corba_port))
if len(tmp) > 0:
    corba_port = tmp

smtp_server_name = ''
smtp_server_login = ''
smtp_server_passwd = ''


os.system ('mkdir "%s"' % install_path)
if not os.path.isdir (install_path):
    print "ЌҐ г¤ «®бм б®§¤ вм Є в «®Ј\nCan't create dir", install_path

    if os.path.isfile (install_path):
        print "%s ¬®¦Ґв Ўлвм д ©«®¬ - б®ваЁвҐ ҐЈ®" % install_path
    sys.exit()


os.chdir (current_dir)

print "\nЉ®ЇЁаговбп д ©«л ў %s. Џ®¦ «г©бв  Ї®¤®¦¤ЁвҐ" % install_path
print "Please wait."

os.system (r'xcopy /Y /D /E /F * "%s" >"%s\install.log"' % (install_path, install_path))
os.system (r'xcopy /Y /E /F Web\Instance\zope\var\data.fs "%s\Web\Instance\zope\var\data.fs"' % (install_path))

os.chdir (install_path)

def create_shortcuts (install_path):
    f = open(r"%s\uninstall.ini" % install_path, "w+")

    shell = win32com.client.Dispatch("WScript.Shell")
    start = "%s\\%s" % (shell.SpecialFolders("Programs").encode("cp1251"), "Гарант-Интранет")


    shortcuts = [
      ('ГАРАНТ', "%s" % (start), '%s' % (r'http://127.0.0.1'))
      , ('ГАРАНТ-Администратор', "%s" % (start), '%s' % (r'http://127.0.0.1/admin'))

      , ('Запустить службы ГАРАНТ-Интранет',  "%s" % (start), '%s\\%s' % (install_path, 'Web\\Instance\\bin\\startservice.bat'))
      , ('Остановить службы ГАРАНТ-Интранет', "%s" % (start), '%s\\%s' % (install_path, 'Web\\Instance\\bin\\stopservice.bat'))

      , ('Удаление ГАРАНТ-Интранет', "%s" % (start), '%s\\%s' % (install_path, 'uninstall.bat'))
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

os.system (r'copy Web\bin\msvcr71.dll %SystemRoot%\system32')

create_shortcuts (install_path)

def install_or_update_services():
    print ''
    service_name = 'Garant Intranet Data %s:%s' % (corba_port, zope_port)

    sub_key = r'SOFTWARE\%s' % service_name

    aReg = _winreg.ConnectRegistry(None,_winreg.HKEY_LOCAL_MACHINE)
    gar_key = _winreg.CreateKey(_winreg.HKEY_LOCAL_MACHINE, sub_key)
    _winreg.SetValueEx (gar_key, "ApplicationServerOptions", None, _winreg.REG_SZ, r'-GCMConfigFile "%s\garant.ini"' % install_path)
    _winreg.SetValueEx (gar_key, "-ClearGuests", None, _winreg.REG_SZ, "false")

    os.chdir (install_path)
    os.chdir (r'Web\Instance\bin')
    os.system ("installservice")

from profiles import *
from zopeImport import *

def makeProfilesMigration():
    #Ё¬Ї®ав ЁбЇ®«м§®ў ўиЁебп ¤® ®Ў­®ў«Ґ­Ёп Їа®дЁ«Ґ©
    print "\n\nЃг¤Ґв ўлЇ®«­Ґ­  ¬ЁЈа жЁп Їа®дЁ«Ґ© Ё§ ЇаҐ¤л¤гйҐ© Ё­бв ««пжЁЁ. ‚Ќ€ЊЂЌ€…! ‘«г¦Ўл ЇаҐ¤гйҐ© Ё­бв ««пжЁЁ ¤®«¦­л Ўлвм § ЇгйҐ­л.";
    print "Would the migration profiles of the previous installation. ATTENTION! Services of a previous installation should be run.\n\n";

    urlPrevious = raw_input ("•®бв ®вЄг¤  Ўг¤гв нЄбЇ®авЁа®ў вмбп Їа®дЁ«Ё, ­ ЇаЁ¬Ґа server.garant.ru:8080\n(Profiles export host, example server.garant.ru:8080): ").strip ()
    passwordPrevious = raw_input ("Џ а®«м гзҐв­®© § ЇЁбЁ manager\n(Manager user password): ")

    profileMigrator = iProfiles ()

    while 1:
        if (profileMigrator.check_server (urlPrevious)):
            break
        tmp = raw_input ("ЌҐ г¤ «®бм ®Ў­ аг¦Ёвм Їа®дЁ«Ё ѓ а ­в-€­ва ­Ґв ­  гЄ § ­­®¬ е®бвҐ. ‡ ЇгбвЁвҐ, Ї®¦ «г©бв , б«г¦Ўл Ё«Ё гЄ ¦ЁвҐ ¤Ґ©бвўгойЁ© е®бв\n(Export host inaccessible. Enter another host [%s]): " % (urlPrevious)).strip()
        if (tmp):
            urlPrevious = tmp

    importer = zopeImporter(urlPrevious).setUserPassword(passwordPrevious)
    fileToImport = importedFile('get_profiles_list', 'get_profiles_list').setFolder('profiles').setContent('<dtml-in "profiles.objectItems(\'Folder\')" sort=\'id\'><dtml-let key=sequence-key name=sequence-item><dtml-if "name.hasProperty(\'profileName\')"><dtml-var sequence-key>\n</dtml-if></dtml-let></dtml-in>')

    while 1:
        try:
            importer.makeImport(fileToImport)
            break
        except ExceptionWrongPassword:
            passwordPrevious = raw_input('Џ а®«м ¤«п manager - ­ҐЇа ўЁ«м­л©! ‚ўҐ¤ЁвҐ Ї а®«м\nManager password is wrong. Enter password: ')
            importer.setUserPassword(passwordPrevious)

    profileMigrator.set_server (url=urlPrevious, p=passwordPrevious, path = install_path)
    profileMigrator.get_profiles_list ()
    profileMigrator.export_profiles ()
    #f_stop_services (install_path)
    ServiceHelper().set_corba_port(corba_port).set_zope_port(zope_port).set_force_mode(True).stop()
    install_or_update_services()
    #f_start_services (install_path)
    ServiceHelper().set_corba_port(corba_port).set_zope_port(zope_port).start()
    profileMigrator.set_server (':'.join (('127.0.0.1', zope_port)), install_path)
    profileMigrator.import_profiles ()

isMakeProfilesMigration = 'Y'
while 1:
    tmp = raw_input ("\n‡ ЇгбвЁвм ¬ бвҐа ¬ЁЈа жЁЁ Їа®дЁ«Ґ©? [%s]\n(Run profiles migration? [%s]): " % (isMakeProfilesMigration, isMakeProfilesMigration))
    if (not tmp):
        break
    if (tmp in ('Y', 'y', 'N', 'n')):
        isMakeProfilesMigration = tmp
        break

if (isMakeProfilesMigration in ['Y', 'y']):
    makeProfilesMigration()
else:
    ServiceHelper().set_corba_port(corba_port).set_zope_port(zope_port).set_force_mode(True).stop()
    install_or_update_services ()

ServiceHelper().set_corba_port(corba_port).set_zope_port(zope_port).set_force_mode(True).stop()

print "\n“бв ­®ўЄ  гбЇҐи­® § ўҐаиҐ­ ."