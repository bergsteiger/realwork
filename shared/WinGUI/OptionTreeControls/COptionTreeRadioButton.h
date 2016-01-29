////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeRadioButton.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeRadioButton
//
// кнопка-переключатель
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREERADIOBUTTON_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREERADIOBUTTON_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B06DC0177_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

// Radio Button Node
struct OT_RADIO_NODE
{
	CString m_strText;

	BOOL m_bChecked;

	CRect m_rcHitRect;

	OT_RADIO_NODE *m_nNextNode;
};
//#UC END# *470B06DC0177_CUSTOM_INCLUDES*

namespace WinGUI {

// кнопка-переключатель
class COptionTreeRadioButton : public CWnd, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeRadioButton)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeRadioButton ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeRadioButton)


//#UC START# *470B06DC0177*
// Construction
public:
	COptionTreeRadioButton();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeRadioButton)
	//}}AFX_VIRTUAL

// Implementation
public:
	int Node_GetChecked();
	void Node_UnCheckAll();
	void SetRadioOptionsOwner(COptionTree *otOption);
	OT_RADIO_NODE *Node_FindNode(CString strText);
	OT_RADIO_NODE *Node_FindNode(int nIndex);
	void Node_DeleteAll();
	void Node_Insert(CString strText, BOOL bChecked);
	inline virtual void HasChanged(void){;}
protected:
	

	// Generated message map functions
protected:
	OT_RADIO_NODE *m_nAllNodes;
//	COptionTree *m_otOption;
	//{{AFX_MSG(COptionTreeRadioButton)
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnPaint();
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMove(int x, int y);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	//}}AFX_MSG

//#UC END# *470B06DC0177*
}; // class COptionTreeRadioButton

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREERADIOBUTTON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

