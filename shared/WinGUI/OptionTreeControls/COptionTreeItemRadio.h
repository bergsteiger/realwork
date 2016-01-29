////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemRadio.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemRadio
//
// radio item
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMRADIO_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMRADIO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeRadioButton.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B286E01F4_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B286E01F4_CUSTOM_INCLUDES*

namespace WinGUI {

// radio item
class COptionTreeItemRadio : public COptionTreeRadioButton {
	SET_OBJECT_COUNTER (COptionTreeItemRadio)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemRadio ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemRadio)


//#UC START# *470B286E01F4*
// Construction
public:
	COptionTreeItemRadio();
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void HasChanged(void);
	virtual void OnShow(BOOL bShow){;}

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemRadio)
	//}}AFX_VIRTUAL

// Implementation
public:
	int GetCheckedRadio();
	BOOL GetMultiline();
	void InsertNewRadio(CString strText, BOOL bChecked);
	BOOL CreateRadioItem();

protected:
	void ReCalculateHeight();

	// Generated message map functions
protected:
	BOOL m_bFocus;
	//{{AFX_MSG(COptionTreeItemRadio)
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	//}}AFX_MSG

//#UC END# *470B286E01F4*
}; // class COptionTreeItemRadio

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMRADIO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

