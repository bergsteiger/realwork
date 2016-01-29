////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/ClipboardHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::WinGUI::Helpers::ClipboardHelper
//
// вспомогательный класс для работы с буфером обмена
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Helpers/ClipboardHelper.h"

namespace WinGUI {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// копирует текст в буфер обмена, возвращает true, если все прошло успешно
bool ClipboardHelper::copy_text_to_clipboard (const std::string& text) {
	//#UC START# *4AD8526C0173*
	if (!OpenClipboard(0)) {
		return false;
	}

	if (!EmptyClipboard()) {
        return false;
	}
    
    
    HGLOBAL hnd = GlobalAlloc(GMEM_FIXED, text.size () + 1); 
    if (hnd == NULL) { 
        CloseClipboard(); 
        return false; 
    }

    LPSTR str = (LPSTR)GlobalLock(hnd); 
	ACE_OS::strcpy (str, text.c_str ());
    
    GlobalUnlock(hnd); 
    SetClipboardData(CF_TEXT, str);
    
    
    long wlen = MultiByteToWideChar(CP_ACP, 0, str, -1, 0, 0);
    
    HGLOBAL hnd2 = GlobalAlloc(GMEM_FIXED, wlen*2);
    LPWSTR wbuf = (LPWSTR)GlobalLock(hnd2);

    MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, str, -1, wbuf, wlen);
    SetClipboardData(CF_UNICODETEXT, wbuf);
    GlobalUnlock(hnd2);
    
	HGLOBAL hnd3 = GlobalAlloc(GMEM_FIXED, text.size () + 1); 
    LPSTR str2 = (LPSTR)GlobalLock(hnd3); 
    CharToOem(str, str2);
    SetClipboardData(CF_OEMTEXT, str2);
    GlobalUnlock(hnd3);
    
    CloseClipboard(); 
    return true;

	//#UC END# *4AD8526C0173*
}

} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

