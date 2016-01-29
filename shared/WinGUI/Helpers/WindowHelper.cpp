////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/WindowHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::WinGUI::Helpers::WindowHelper
// Файл реализации утилитного набора WindowHelper
//
// содержит функции для работы с окнами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Helpers/WindowHelper.h"

namespace WinGUI {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// ищет окно среди детей from, у которого кэпшн совпадает с caption, а имя класса окна с class_name
// один из параметров не задан поиск осуществляется только по тому, который задан
HWND find_window (HWND from, const std::string& caption, const std::string& class_name) {
	//#UC START# *46923013036B*
	class Finder {
	public:
		static BOOL CALLBACK EnumChildProc (HWND hwnd, LPARAM lparam) {
			Finder* functor = reinterpret_cast<Finder*> (lparam);
			if (functor && functor->operator () (hwnd) == true) {
				functor->m_founded_wnd = hwnd;
			}
			if (functor->is_found () == true) {
				return FALSE;
			}
			return TRUE;
		}

		static BOOL CALLBACK EnumWinProc (HWND hwnd, LPARAM lparam) {
			Finder* functor = reinterpret_cast<Finder*> (lparam);
			if (functor && functor->operator () (hwnd) == true) {
				functor->m_founded_wnd = hwnd;
				return FALSE;
			}
			EnumChildWindows (hwnd, EnumChildProc, lparam);
			if (functor->is_found () == true) {
				return FALSE;
			}
			return TRUE;
		}
	public:
		Finder (const std::string& caption, const std::string& class_name) 
			: m_founded_wnd (NULL)
			, m_caption (caption)
			, m_cls_name (class_name)
		{		
		}
		bool operator () (HWND hwnd) {
			bool res = false;
			if (hwnd) {
				bool finded_by_caption = false;
				CWnd* wnd = CWnd::FromHandle (hwnd);
				if (m_caption.empty () == false) {
				   CString wnd_caption;
				   wnd->GetWindowText (wnd_caption);
				   finded_by_caption = (wnd_caption.Find (m_caption.c_str ()) != -1);
				} else {
					finded_by_caption = true;
				}
				bool finded_by_class_name = false;
				if (m_cls_name.empty () == false) {
					TCHAR cls_name [1024];
					::GetClassName(hwnd, cls_name, 1024);
					CString class_name (cls_name);
					finded_by_class_name = (class_name.Find (m_cls_name.c_str ()) != -1);
				} else {
					finded_by_class_name = true;
				}
				res = finded_by_class_name && finded_by_caption;
			}
			return res;
		}
		
		bool is_found () {
			return m_founded_wnd != NULL;
		}

		HWND m_founded_wnd;
	private:
		std::string m_cls_name;
		std::string m_caption;		
	};
	HWND res = NULL;
	if (caption.empty () == false || class_name.empty () == false) {
		Finder fw (caption, class_name);
		if (from == NULL) {
			EnumWindows (Finder::EnumWinProc, reinterpret_cast<LPARAM> (&fw));
		} else {
			EnumChildWindows (from, Finder::EnumChildProc, reinterpret_cast<LPARAM> (&fw));
		}
		res = fw.m_founded_wnd;
	}
	return res;
	//#UC END# *46923013036B*
}

} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

