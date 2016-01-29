# -*- coding: windows-1251 -*-

from update import *

if __name__ == '__main__':
    if ClonePatcher().run():
        print '\nЋЎ­®ў«Ґ­ЁҐ гбЇҐи­® § ўҐаиҐ­®.'
        print 'Update finished successful.'
    else:
        print '\n‚­Ё¬ ­ЁҐ! ‚ е®¤Ґ ®Ў­®ў«Ґ­Ёп ў®§­ЁЄ«  ®иЁЎЄ . ‘ўп¦ЁвҐбм б® б«г¦Ў®© Ї®¤¤Ґа¦ЄЁ Ї® Ї®звҐ hotline@garant.ru, ЇаЁ«®¦Ёў Є ЇЁбм¬г д ©«л update.xml Ё update.log.'
        print 'Warning! Update finished with error. Contact with support by email hotline@garant.ru and send update.xml, update.log.'