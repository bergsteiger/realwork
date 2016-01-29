////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemIPAddress.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemIPAddress
//
// контрол отображения/ввода IP-адреса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMIPADDRESS_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMIPADDRESS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B04DB003E_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeIPAddressEdit.h"
//#UC END# *470B04DB003E_CUSTOM_INCLUDES*

namespace WinGUI {

// контрол отображения/ввода IP-адреса
class COptionTreeItemIPAddress : public CIPAddressCtrl, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemIPAddress)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemIPAddress ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemIPAddress)


//#UC START# *470B04DB003E*
// Construction
public:
	COptionTreeItemIPAddress();
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
	//{{AFX_VIRTUAL(COptionTreeItemIPAddress)
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL CreateIPAddressItem(DWORD dwAddStyle);

	// Generated message map functions
protected:
	afx_msg long OnEditLooseFocus(WPARAM wParam, LPARAM lParam);
	afx_msg long OnEditNextEdit(WPARAM wParam, LPARAM lParam);	
	afx_msg long OnEditChanged(WPARAM wParam, LPARAM lParam);	
	BOOL m_bFocus;
	COptionTreeIPAddressEdit m_ctlEdit4;
	COptionTreeIPAddressEdit m_ctlEdit3;
	COptionTreeIPAddressEdit m_ctlEdit2;
	COptionTreeIPAddressEdit m_ctlEdit1;
	//{{AFX_MSG(COptionTreeItemIPAddress)
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnPaint();
	afx_msg void OnDestroy();
	//}}AFX_MSG

//#UC END# *470B04DB003E*
}; // class COptionTreeItemIPAddress

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMIPADDRESS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

