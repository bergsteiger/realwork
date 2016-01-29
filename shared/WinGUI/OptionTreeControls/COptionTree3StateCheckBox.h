////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/OptionTreeControls/COptionTree3StateCheckBox.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTree3StateCheckBox
//
// ���-���� � ����� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE3STATECHECKBOX_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE3STATECHECKBOX_H__

#include "shared/Core/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "shared/WinGUI/OptionTreeControls/COptionTreeCheckButton.h"
#include "afxwin.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470CC30A002E_CUSTOM_INCLUDES*
//#UC END# *470CC30A002E_CUSTOM_INCLUDES*

namespace WinGUI {

// ���-���� � ����� �����������
class COptionTree3StateCheckBox : public COptionTreeCheckButton {
	SET_OBJECT_COUNTER (COptionTree3StateCheckBox)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	COptionTree3StateCheckBox ();

public:
	virtual ~COptionTree3StateCheckBox ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTree3StateCheckBox)

public:
	// ����������� ��������
	virtual void CleanDestroyWindow ();

	// ������ �������
	virtual bool CreateCheckBoxItem (boost::tribool state, unsigned long options);

	// ��������� ������ ��������
	virtual void DrawAttribute (CDC* dc, const RECT& rc);

	// ������� �������� �� ���������
	virtual void OnActivate ();

	// ������� �������� �� ���������
	virtual void OnCommit ();

	// ������� �������� �� ������ ���������
	virtual void OnDeSelect ();

	// ������� �������� �� �������� ����
	virtual void OnMove ();

	// ������� �������� �� ����������
	virtual void OnRefresh ();

	// ������� �������� �� ���������
	virtual void OnSelect ();

	// ������� �������� �� �����������/�������
	virtual void OnShow (BOOL bShow);

	// ���������� ���������
	virtual boost::tribool get_state () const;

	// ���������� ���������� � ���� ������
	virtual const std::string get_state_str () const;

	// ��������� ���������
	// \state - ��������� (true, false, undefined)
	// \commit - ����� �� ��������� ���������
	virtual void set_state (boost::tribool state);

	// ������������� ����� ��� �������������� ��������
	virtual void set_undefined_str (const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ����� � �������� ��� ���
	bool m_focus;

	// ���������
	boost::tribool m_state;

	// ����� ��� �������������� ��������� ���-�����
	std::string m_undefined_str;

//#UC START# *470CC30A002E*
protected:
	//{{AFX_MSG(COptionTree3StateCheckBox)
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnPaint();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG
private:
	CRect m_rcCheck;
//#UC END# *470CC30A002E*
}; // class COptionTree3StateCheckBox

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE3STATECHECKBOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

