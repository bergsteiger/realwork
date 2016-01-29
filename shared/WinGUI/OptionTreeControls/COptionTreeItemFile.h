////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemFile.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemFile
//
// контрол выбора файла, папки для отображения в дереве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMFILE_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMFILE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B034A0232_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeFileDlg.h"
//#UC END# *470B034A0232_CUSTOM_INCLUDES*

namespace WinGUI {

// контрол выбора файла, папки для отображения в дереве
class COptionTreeItemFile : public CWnd, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemFile)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemFile ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemFile)


//#UC START# *470B034A0232*
public:
	COptionTreeItemFile();
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void OnShow(BOOL bShow){;}
	virtual CString GetAttributeText(void);

	CString GetSelectedFolder();
	CString GetFileDrive();
	CString GetFileDir();
	CString GetFileExt();
	CString GetFileTitle();
	CString GetFileName();
	CString GetPathName();
	CString GetNextPathName(POSITION& pos);
	POSITION GetStartPosition();
	CString GetDialogTitle();
	void SetDialogTitle(CString strTitle);
	CString GetFilter();
	void SetFilter(CString strFilter);
	CString GetDefaultExtention();
	void SertDefaultExtention(CString strExt);
	DWORD GetDialogFlags();
	void SetDialogFlags(DWORD dwFlags);
	void AddFileName(CString strFile);
	BOOL CreateFileItem(CString strFile, CString strDefExt, CString strFilter, DWORD dwOptions, DWORD dwDlgFlags);

	// GARANT {
	void SetFileName (const CString& file);
	// } GARANT

protected:
	//обновляет буфер m_strBufferText
	void update_buffer ();
	CString GetFileDrive(CString strFile);
	CString GetFileDirectory(CString strFile);
	CString GetFileName(CString strFile);
	CString GetFileExtention(CString strFile);
	BOOL GetDialogFlag(DWORD dwOption);
	void SetDialogFlag(DWORD dwOption, BOOL bSet);	
	DWORD m_dwDlgFlags;
	long m_lDefaultHeight;
	COptionTreeFileDlg m_dlgFile;
	CStringArray m_strFileNames;
	CString m_strDefExt;
	CString m_strFilter;
	CString m_strDlgTitle;
	CString m_strBufferText;
//#UC END# *470B034A0232*
}; // class COptionTreeItemFile

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMFILE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

