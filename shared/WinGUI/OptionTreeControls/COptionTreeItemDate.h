////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemDate.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemDate
//
// элемент выбора даты для отображения в дереве контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMDATE_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMDATE_H__

#include "shared/Core/sys/std_inc.h"
#include "afxdtctl.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B01B302BF_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeCheckButton.h"
//#UC END# *470B01B302BF_CUSTOM_INCLUDES*

namespace WinGUI {

// элемент выбора даты для отображения в дереве контролов
class COptionTreeItemDate : public CDateTimeCtrl, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemDate)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemDate ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemDate)


//#UC START# *470B01B302BF*
// Construction
public:
	COptionTreeItemDate();
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
	//{{AFX_VIRTUAL(COptionTreeItemDate)
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL CreateDateItem(CString strFormat, DWORD dwDateStyle);

	// Generated message map functions
protected:
	BOOL m_bFocus;
	//{{AFX_MSG(COptionTreeItemDate)
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	//}}AFX_MSG
public:
  afx_msg void OnDtnDatetimechange(NMHDR *pNMHDR, LRESULT *pResult);
//#UC END# *470B01B302BF*
}; // class COptionTreeItemDate

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMDATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

