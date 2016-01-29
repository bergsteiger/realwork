////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeFileDlg.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::COptionTreeFileDlg
//
// диалог выбора файла/папки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFILEDLG_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFILEDLG_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *470AFE2C01E4_CUSTOM_INCLUDES*
#include "shlobj.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"

// Structures
struct OT_OPENFILENAMEEX : public OPENFILENAME 
{ 
	void*	m_pvReserved;
	DWORD	m_dwReserved;
	DWORD	m_dwFlagsEx;
};
//#UC END# *470AFE2C01E4_CUSTOM_INCLUDES*

namespace WinGUI {

// диалог выбора файла/папки
class COptionTreeFileDlg {
	SET_OBJECT_COUNTER (COptionTreeFileDlg)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeFileDlg ();


//#UC START# *470AFE2C01E4*
public:
	int SelectFolder(LPCTSTR lpszTitle = NULL, LPCTSTR lpszStartPath = NULL, UINT ulFlags = BIF_RETURNFSANCESTORS | BIF_RETURNONLYFSDIRS, CWnd* pParentWnd = NULL);
	POSITION GetStartPosition() const;
	CString GetNextPathName(POSITION& pos) const;
	CString GetPathName() const;
	CString GetFileName() const;
	CString GetFileTitle() const;
	CString GetFileExt() const;
	CString GetFileDir() const;
	CString GetFileDrive() const;
	CString GetSelectedFolder() const;
	virtual int DoModal();
	void SetDialog(BOOL bOpenFileDialog, LPCTSTR lpszDefExt = NULL, LPCTSTR lpszFileName = NULL, DWORD dwFlags = OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, LPCTSTR lpszFilter = NULL, CWnd* pParentWnd = NULL);
	COptionTreeFileDlg(BOOL bOpenFileDialog, LPCTSTR lpszDefExt = NULL, LPCTSTR lpszFileName = NULL, DWORD dwFlags = OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, LPCTSTR lpszFilter = NULL, CWnd* pParentWnd = NULL);
	COptionTreeFileDlg();

protected:
	static int __stdcall BrowseCtrlCallback(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData);

	OT_OPENFILENAMEEX	m_ofn;
	BOOL m_bOpenFileDialog;
	TCHAR m_szFile[MAX_PATH];
	TCHAR m_szFileTitle[MAX_PATH];
	TCHAR m_szSelectedFolder[MAX_PATH];
	CString m_strFilter;
//#UC END# *470AFE2C01E4*
}; // class COptionTreeFileDlg

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFILEDLG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

