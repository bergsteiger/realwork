////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeIPAddressEdit.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeIPAddressEdit
//
// ввод IP-адреса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeIPAddressEdit.h"

//#UC START# *470B008500BB_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B008500BB_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B008500BB*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeIPAddressEdit

COptionTreeIPAddressEdit::COptionTreeIPAddressEdit()
{
	// Initialize variables
	m_wndNotify = NULL;
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeIPAddressEdit message handlers

void COptionTreeIPAddressEdit::OnKillFocus(CWnd* pNewWnd) 
{
	// Notify user
	if (IsWindow(m_wndNotify))
	{
		::SendMessage(m_wndNotify, OT_IPADDRESS_KILLFOCUS, (WPARAM) pNewWnd, NULL); 
	}

	CEdit::OnKillFocus(pNewWnd);	
}

void COptionTreeIPAddressEdit::SetNotifyWnd(HWND hWnd)
{
	// Save window
	m_wndNotify = hWnd;
}

void COptionTreeIPAddressEdit::OnMaxText() 
{
	// Notify user
	if (IsWindow(m_wndNotify))
	{
		::SendMessage(m_wndNotify, OT_IPADDRESS_NEXTEDIT, (WPARAM) this, NULL); 
	}	
}

void COptionTreeIPAddressEdit::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	// If return is pressed and not multiline, commit
	if (IsWindow(GetSafeHwnd()))
	{
		if (nChar == _T('.'))
		{
			// -- Notify user
			if (IsWindow(m_wndNotify))
			{
				::SendMessage(m_wndNotify, OT_IPADDRESS_NEXTEDIT, (WPARAM) this, NULL); 
			}
		}
	}
	
	CEdit::OnKeyDown(nChar, nRepCnt, nFlags);
}
BOOL COptionTreeIPAddressEdit::PreTranslateMessage(MSG* pMsg)
{
  if (pMsg->message == WM_KEYDOWN && (pMsg->wParam == VK_RETURN || pMsg->wParam == VK_ESCAPE))
  {
    ::SendMessage(m_wndNotify, OT_IPADDRESS_KILLFOCUS, (WPARAM) 1, NULL); 
  }
  return CEdit::PreTranslateMessage(pMsg);
}

void COptionTreeIPAddressEdit::OnEnChange()
{
  // TODO:  If this is a RICHEDIT control, the control will not
  // send this notification unless you override the CEdit::OnInitDialog()
  // function and call CRichEditCtrl().SetEventMask()
  // with the ENM_CHANGE flag ORed into the mask.
  ::SendMessage(m_wndNotify, OT_TEXTCHANGED, (WPARAM) 1, NULL); 
}

//#UC END# *470B008500BB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeIPAddressEdit::~COptionTreeIPAddressEdit () {
	//#UC START# *470B008500BB_DESTR_BODY*
	//#UC END# *470B008500BB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeIPAddressEdit, CEdit)
	//#UC START# *470B008500BB_MESSAGE_MAP*
	ON_WM_KILLFOCUS()
	ON_CONTROL_REFLECT(EN_MAXTEXT, OnMaxText)
	ON_WM_KEYDOWN()
	ON_CONTROL_REFLECT(EN_CHANGE, OnEnChange)
	//#UC END# *470B008500BB_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeIPAddressEdit, CEdit)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

