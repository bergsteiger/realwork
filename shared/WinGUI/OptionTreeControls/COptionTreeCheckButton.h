////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeCheckButton.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeCheckButton
//
// кнопка выбора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREECHECKBUTTON_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREECHECKBUTTON_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFD4802FD_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"

namespace WinGUI {
	class COptionTree;
}
//#UC END# *470AFD4802FD_CUSTOM_INCLUDES*

namespace WinGUI {

// кнопка выбора
class COptionTreeCheckButton : public CWnd, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeCheckButton)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeCheckButton ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeCheckButton)


//#UC START# *470AFD4802FD*
// Construction
public:
	COptionTreeCheckButton();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeCheckButton)
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL GetOption(DWORD dwOption);
	void SetOption(DWORD dwOption, BOOL bSet);
	void SetCheckOptionsOwner(COptionTree *otOption);
	BOOL GetCheck();
	virtual void SetCheck(BOOL bCheck,const bool bcommit=false);
	CString GetCheckedText() const;
	CString GetUnCheckedText() const;
	void SetCheckText(CString strChecked, CString strUnChecked);
	inline CString GetStrCheck(void) const
	{
	return (m_bCheck == TRUE ? m_strChecked :m_strUnChecked);
	}
	// Generated message map functions
protected:
	CString m_strUnChecked;
	CString m_strChecked;
	BOOL m_bShowText;
	BOOL m_bShowCheck;
	BOOL m_bCheck;
	CRect m_rcCheck;
	//COptionTree *m_otOption;
	//{{AFX_MSG(COptionTreeCheckButton)
	afx_msg void OnPaint();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG

protected:
  DWORD m_dwOptions;
//#UC END# *470AFD4802FD*
}; // class COptionTreeCheckButton

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREECHECKBUTTON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

