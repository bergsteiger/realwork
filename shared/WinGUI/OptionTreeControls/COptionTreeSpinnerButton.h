////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeSpinnerButton.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeSpinnerButton
//
// spinner button
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREESPINNERBUTTON_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREESPINNERBUTTON_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B06290251_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeSpinnerEdit.h"

namespace WinGUI {
	class COptionTree;
}
//#UC END# *470B06290251_CUSTOM_INCLUDES*

namespace WinGUI {

// spinner button
class COptionTreeSpinnerButton : public CWnd {
	SET_OBJECT_COUNTER (COptionTreeSpinnerButton)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeSpinnerButton ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeSpinnerButton)


//#UC START# *470B06290251*
// Construction
public:
	COptionTreeSpinnerButton();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeSpinnerButton)
	//}}AFX_VIRTUAL

// Implementation
public:
	CString GetEditText();
	BOOL IsStringNumeric(CString strString);
	CEdit* GetEdit();
	void ResizeEdit();
	BOOL GetEditDword(DWORD &dwReturn);
	BOOL GetEditInt(int &nReturn);
	BOOL GetEditLong(long &lReturn);
	BOOL GetEditDouble(double &dReturn);
	BOOL GetEditFloat(float &fReturn);
	void SetEditLong(long lValue);
	void SetEditDword(DWORD dwValue);
	void SetEditFloat(float fValue);
	void SetEditInt(int nValue);
	void SetEditDouble(double dValue);
	void GetRange(double &dBottom, double &dTop);
	void SetRange(double dBottom, double dTop);
	void SetSpinnerOptionsOwner(COptionTree *otOption);

	virtual BOOL GetOption(DWORD dwOption);
	virtual void SetOption(DWORD dwOption, BOOL bSet);

protected:
	LRESULT WM_ForceRedraw(WPARAM wParam, LPARAM lParam);
	LRESULT WM_EditUp(WPARAM wParam, LPARAM lParam);
	LRESULT WM_EditDown(WPARAM wParam, LPARAM lParam);	
	double _GetValue();
	
	// Generated message map functions
protected:
	void RepeatButton();
	COptionTree *m_otSpinnerOption;
	double m_dRangeTop;
	double m_dRangeBottom;
	CRect m_rcButtonTop;
	CRect m_rcButtonBottom;
	BOOL m_bBottomPressed;
	BOOL m_bTopPressed;
	CPoint m_ptSavePoint;
	BOOL m_bFirstRepeat;
	COptionTreeSpinnerEdit m_ctlEdit;
	int m_nRepeatDelay;
	int m_nRepeatRate;
	DWORD m_dwOptions;
	//{{AFX_MSG(COptionTreeSpinnerButton)
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnPaint();
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnDestroy();
	afx_msg void OnMove(int x, int y);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnTimer(UINT nIDEvent);
	//}}AFX_MSG

//#UC END# *470B06290251*
}; // class COptionTreeSpinnerButton

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREESPINNERBUTTON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

