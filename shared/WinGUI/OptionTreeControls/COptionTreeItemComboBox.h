////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemComboBox.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemComboBox
//
// комбо-бокс для отображения в дереве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCOMBOBOX_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCOMBOBOX_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B01340261_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B01340261_CUSTOM_INCLUDES*

namespace WinGUI {

// комбо-бокс для отображения в дереве
class COptionTreeItemComboBox : public CComboBox, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemComboBox)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemComboBox ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemComboBox)


//#UC START# *470B01340261*
// Construction
public:
	COptionTreeItemComboBox();
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
  virtual void OnShow(BOOL bShow);
  virtual CString GetAttributeText(void);
// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemComboBox)
	//}}AFX_VIRTUAL

// Implementation
public:
	long GetDropDownHeight();
	void SetDropDownHeight(long lHeight);
	BOOL PrepareComboItem(const CString& sWindowText="",
                              DWORD dwAddStyle = 0);

	BOOL CreateComboItem(DWORD dwAddStyle = 0);

	// Generated message map functions
protected:
	BOOL m_bFocus;
	long m_lDropDownHeight;
	//{{AFX_MSG(COptionTreeItemComboBox)
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	//}}AFX_MSG

	virtual LRESULT DefWindowProc(UINT nMsg, WPARAM wParam, LPARAM lParam);

public:
  afx_msg void OnCbnSelchange();
protected:
  // these members store creation params
  DWORD   _dwExStyleBuffer;
  CString _InputMaskBuffer;
  CString _WindowTextBuffer;
//#UC END# *470B01340261*
}; // class COptionTreeItemComboBox

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCOMBOBOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

