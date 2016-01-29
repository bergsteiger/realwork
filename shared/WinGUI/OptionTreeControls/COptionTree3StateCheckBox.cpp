////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTree3StateCheckBox.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTree3StateCheckBox
//
// чек-бокс с тремя состояниями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree3StateCheckBox.h"

//#UC START# *470CC30A002E_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470CC30A002E_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470CC30A002E*
void COptionTree3StateCheckBox::OnSetFocus(CWnd* pOldWnd) 
{
	// Mark focus
	m_focus = true;	
	
	COptionTreeCheckButton::OnSetFocus(pOldWnd);	
}

void COptionTree3StateCheckBox::OnKillFocus(CWnd* pNewWnd) 
{	
	// Validate
	if (m_otOption == NULL)
	{
		COptionTreeCheckButton::OnKillFocus(pNewWnd);
		return;
	}

	// See if new window is tree of list
	if (m_otOption->IsChild (pNewWnd) == TRUE)
	{
		// -- Mark focus
		m_focus = true;

		// -- Commit changes
		//CommitChanges();
	}

	COptionTreeCheckButton::OnKillFocus(pNewWnd);	
}

void COptionTree3StateCheckBox::OnPaint() 
{
	// Make sure options aren't NULL
	if (m_otOption == NULL)
	{
		return;
	}

	// Declare variables
	CPaintDC dc(this);
	CDC* pDCMem = new CDC;
	CBitmap bpMem;
	CBitmap *bmOld;
	COLORREF crOld;
	HGDIOBJ hOldBrush;
	int nOldBack;
	CRect rcText, rcCheck, rcClient;
	CString strText;
	HGDIOBJ hOld;

	// Get client rectangle
	GetClientRect(rcClient);

	// Create DC
	pDCMem->CreateCompatibleDC(&dc);
	
	// Create bitmap
	bpMem.CreateCompatibleBitmap(&dc, rcClient.Width(), rcClient.Height());

	// Select bitmap
	bmOld = pDCMem->SelectObject(&bpMem);
	
	// Set background mode
	nOldBack = pDCMem->SetBkMode(TRANSPARENT);

	// Set text color
	//crOld = pDCMem->SetTextColor(GetSysColor(COLOR_WINDOWTEXT));
  // ce
	if (get_state () == true) {
		crOld = pDCMem->SetTextColor(_CLR_CHECKED);
	} else if (get_state () == false) {
		crOld = pDCMem->SetTextColor(_CLR_UNCHECKED);
	} else {
		crOld = pDCMem->SetTextColor(RGB (100,100,100));
	}

	// Select font
	hOld = pDCMem->SelectObject(m_otOption->GetNormalFont());

	// Draw control background
	if (m_otOption->IsWindowEnabled() == FALSE) {
		hOldBrush = pDCMem->SelectObject(GetSysColorBrush(COLOR_BTNFACE));
	} else {
		hOldBrush = pDCMem->SelectObject(GetSysColorBrush(COLOR_WINDOW));
	}
	pDCMem->PatBlt(rcClient.left, rcClient.top, rcClient.Width(), rcClient.Height(), PATCOPY);

	if(GetOption(OT_CHECKBOX_SHOWCHECK) == TRUE) {
		// Get rectangle
		rcCheck.left  = rcClient.left + 1;
		rcCheck.right = rcCheck.left + (long) OT_CHECKBOX_SIZE;
		rcCheck.top = rcClient.top + ATTRIB_OFFSET - 1;
		rcCheck.bottom = rcCheck.top + (long) OT_CHECKBOX_SIZE;
  		
		// Draw check
		if (get_state () == true) {
			pDCMem->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTONCHECK | DFCS_CHECKED);
		} else if (get_state () == false) {
			pDCMem->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTONCHECK);
		} else {
			//undefined
			pDCMem->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTON3STATE | DFCS_INACTIVE);
		}
	} else {
		rcCheck.left  = rcClient.left + 1;
		rcCheck.right = rcCheck.left;
		rcCheck.top = rcClient.top + ATTRIB_OFFSET - 1;
		rcCheck.bottom = rcCheck.top + (long) OT_CHECKBOX_SIZE;
	}
	// Draw text
	if (GetOption(OT_CHECKBOX_SHOWTEXT) == TRUE) {
		// -- Get text
		CString strText = get_state_str ().c_str ();

		// -- Get rectangle
		rcText.left  = rcCheck.right + ATTRIB_OFFSET;
		rcText.right = rcClient.right;
		rcText.top = rcClient.top;
		rcText.bottom = rcClient.bottom;

		// -- Draw text
		pDCMem->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER);
	}

	// Save check rectangle
	m_rcCheck = rcCheck;
	if (GetOption(OT_CHECKBOX_SHOWTEXT) == TRUE) {
		m_rcCheck.right = rcText.right;
	}

	// Copy to screen
	dc.BitBlt(0, 0, rcClient.Width(), rcClient.Height(), pDCMem, 0, 0, SRCCOPY);

	// Restore GDI ojects
	pDCMem->SelectObject(bmOld);
	pDCMem->SelectObject(hOldBrush);
	pDCMem->SetBkMode(nOldBack);
	pDCMem->SelectObject(hOld);
	pDCMem->SetTextColor(crOld);	
	
	// Delete objects
	if (pDCMem->GetSafeHdc() != NULL) {
		pDCMem->DeleteDC();
	}
	delete pDCMem;
	if (bpMem.GetSafeHandle() != NULL) {
		bpMem.DeleteObject();
	}
}

BOOL COptionTree3StateCheckBox::OnEraseBkgnd(CDC* pDC) {
	// Naa, we like flicker free better
	return FALSE;
}

void COptionTree3StateCheckBox::OnLButtonUp(UINT nFlags, CPoint point) {
	// See if check was pressed
	if (m_rcCheck.PtInRect(point) == TRUE)
	{
		// -- Reverse check
		if (get_state () == true) {
			set_state (false);
		} else if (get_state () == false) {
			set_state (boost::indeterminate);
		} else {
			set_state (true);
		}
		// -- Force redraw
		Invalidate();

		// -- Update window
		UpdateWindow();
	}
	
	CWnd::OnLButtonUp(nFlags, point);
}
//#UC END# *470CC30A002E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
COptionTree3StateCheckBox::COptionTree3StateCheckBox ()
//#UC START# *470CC3420167_BASE_INIT*
: m_state (boost::indeterminate), m_focus (false), m_rcCheck (0, 0, 0, 0)
//#UC END# *470CC3420167_BASE_INIT*
{
	//#UC START# *470CC3420167_BODY*
	// Set item type
	SetItemType(OT_ITEM_3STATECHECKBOX);
	//#UC END# *470CC3420167_BODY*
}

COptionTree3StateCheckBox::~COptionTree3StateCheckBox () {
	//#UC START# *470CC30A002E_DESTR_BODY*
	//#UC END# *470CC30A002E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTree3StateCheckBox, COptionTreeCheckButton)
	//#UC START# *470CC30A002E_MESSAGE_MAP*
	ON_WM_KILLFOCUS()
	ON_WM_SETFOCUS()
	ON_WM_PAINT()
	ON_WM_ERASEBKGND()
	ON_WM_LBUTTONUP()
	//#UC END# *470CC30A002E_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTree3StateCheckBox, COptionTreeCheckButton)



// уничтожение контрола
void COptionTree3StateCheckBox::CleanDestroyWindow () {
	//#UC START# *470CC3F8038A*
	// Destroy window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Destroy window
		DestroyWindow();
	}
	//#UC END# *470CC3F8038A*
}

// создаёт элемент
bool COptionTree3StateCheckBox::CreateCheckBoxItem (boost::tribool state, unsigned long options) {
	//#UC START# *470CC552002E*
	DWORD dwStyle = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;
	BOOL bRet = FALSE;

	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return false;
	}

	// Create edit control
	if (!IsWindow(GetSafeHwnd())) {
		// -- Create the edit view
		bRet = Create(AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW, ::LoadCursor(NULL, IDC_ARROW)), _T(""), dwStyle, m_rcAttribute, m_otOption->GetCtrlParent(), GetCtrlID());
		// -- Setup window
		if (bRet == TRUE) {
			// -- -- Set font
			SetFont(m_otOption->GetNormalFont(), TRUE);

			// -- -- Save options
			COptionTreeCheckButton::m_dwOptions = options;

			// -- -- Set check
			set_state(state);

			// -- Set check options owner
			SetCheckOptionsOwner(m_otOption);

			// -- -- Set window position
			MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

			// -- -- Hide window
			ShowWindow(SW_HIDE);
		}
	}

	return bRet == TRUE;
	//#UC END# *470CC552002E*
}

// отрисовка данных контрола
void COptionTree3StateCheckBox::DrawAttribute (CDC* dc, const RECT& rc) {
	//#UC START# *470CC401036B*
	// If we don't have focus, text is drawn.
	if (m_focus == true)
	{
		return;
	}

	// Make sure options aren't NULL
	if (m_otOption == NULL)
	{
		return;
	}

	// Make sure there is a window
	if (!IsWindow(GetSafeHwnd()))
	{
		return;
	}

	// Set window position
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}

	// Declare variables
	HGDIOBJ hOld;
	COLORREF crOld;
	int nOldBack;
	CRect rcText, rcCheck;
	CString strText;
	COLORREF crOldBack;

	// Select font
	hOld = dc->SelectObject(m_otOption->GetNormalFont());
	
	// Set text color
	if (IsReadOnly() == TRUE || m_otOption->IsWindowEnabled() == FALSE)
	{
		crOld = dc->SetTextColor(GetSysColor(COLOR_GRAYTEXT));
	}
	else
	{
		crOld = dc->SetTextColor(GetTextColor());
	}

	// Set background mode
	nOldBack = dc->SetBkMode(TRANSPARENT);

	// Set background color
	crOldBack = dc->SetBkColor(GetBackgroundColor());	

	// Draw check box
  if (COptionTreeCheckButton::GetOption(OT_CHECKBOX_SHOWCHECK) == TRUE)
	{
		// -- Get rectangle
		/*rcCheck.left  = rc.left;
		rcCheck.right = rc.left + (long) OT_CHECKBOX_SIZE;
		rcCheck.top = rc.top + ATTRIB_OFFSET - 2;
		rcCheck.bottom = rc.top + (long) OT_CHECKBOX_SIZE;*/
		rcCheck.left  = rc.left + 1;
		rcCheck.right = rc.left + (long) OT_CHECKBOX_SIZE;
		rcCheck.top = rc.top + ATTRIB_OFFSET - 1;
		rcCheck.bottom = rcCheck.top + (long) OT_CHECKBOX_SIZE;
		
		// -- Draw check
		if (get_state () == true) {
			dc->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTONCHECK | DFCS_CHECKED);
		} else if (get_state () == false) {
			dc->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTONCHECK);
		} else {
			//undefined
			dc->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTON3STATE | DFCS_INACTIVE);
		}
	}

	// Draw text
	if (COptionTreeCheckButton::GetOption(OT_CHECKBOX_SHOWTEXT) == TRUE)
	{
		// -- Get text
		strText = get_state_str ().c_str ();
		/*if (GetCheck() == TRUE)
		{
			strText = GetCheckedText();
		}
		else
		{
			strText = GetUnCheckedText();
		}*/

		// -- Get rectangle
    if (COptionTreeCheckButton::GetOption(OT_CHECKBOX_SHOWCHECK) == TRUE)
		{
			rcText.left  = rcCheck.right + ATTRIB_OFFSET;
			rcText.right = rc.right;
			rcText.top = rc.top;
			rcText.bottom = rc.bottom;
		}
		else
		{
			rcText  = rc;
		}

		// -- Draw text
		dc->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER);
	}

	// Restore GDI ojects
	dc->SelectObject(hOld);
	dc->SetTextColor(crOld);
	dc->SetBkMode(nOldBack);
	dc->SetBkColor(crOldBack);
	//#UC END# *470CC401036B*
}

// реакция контрола на активацию
void COptionTree3StateCheckBox::OnActivate () {
	//#UC START# *470CC3EB0119*
	// Make sure window is valid
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_SHOW);

		// -- Set window position
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

		// -- Set focus
		SetFocus();
	}
	//#UC END# *470CC3EB0119*
}

// реакция контрола на изменение
void COptionTree3StateCheckBox::OnCommit () {
	//#UC START# *470CC3DF000F*
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
	//#UC END# *470CC3DF000F*
}

// реакция контрола на снятие выделения
void COptionTree3StateCheckBox::OnDeSelect () {
	//#UC START# *470CC42303C8*
	//#UC END# *470CC42303C8*
}

// реакция контрола на движение мыши
void COptionTree3StateCheckBox::OnMove () {
	//#UC START# *470CC3BD02FD*
	if (IsWindow(GetSafeHwnd())) {
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}


	// Hide window
	if (m_focus == false && IsWindow(GetSafeHwnd())) {
		// -- Show window
		ShowWindow(SW_HIDE);
	}
	//#UC END# *470CC3BD02FD*
}

// реакция контрола на обновление
void COptionTree3StateCheckBox::OnRefresh () {
	//#UC START# *470CC3D602CE*
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}
	//#UC END# *470CC3D602CE*
}

// реакция контрола на выделение
void COptionTree3StateCheckBox::OnSelect () {
	//#UC START# *470CC42B00BB*
	//#UC END# *470CC42B00BB*
}

// реакция контрола на отображение/скрытие
void COptionTree3StateCheckBox::OnShow (BOOL bShow) {
	//#UC START# *470CC43301D4*
	//#UC END# *470CC43301D4*
}

// возвращает состояние
boost::tribool COptionTree3StateCheckBox::get_state () const {
	//#UC START# *470CC90C02BF*
	return m_state;
	//#UC END# *470CC90C02BF*
}

// возвращает стостояние в виде строки
const std::string COptionTree3StateCheckBox::get_state_str () const {
	//#UC START# *470CC9440167*
	std::string text;
	if (get_state() == true)	{
		text = GetCheckedText();
	} else if (get_state() == false) {
		text = GetUnCheckedText();
	} else {
		text = m_undefined_str;
	}
	return text;
	//#UC END# *470CC9440167*
}

// установка состояния
// \state - состояние (true, false, undefined)
// \commit - нужео ли коммитеть изменения
void COptionTree3StateCheckBox::set_state (boost::tribool state) {
	//#UC START# *470CC45E002E*
	m_state = state;
	if (state == true) {
		m_crText = _CLR_CHECKED;
	} else if (state == false) {
		m_crText = _CLR_UNCHECKED;
	} else {
		m_crText = RGB (100, 100, 100);
	}
	//#UC END# *470CC45E002E*
}

// устанавливает текст для неопределённого значения
void COptionTree3StateCheckBox::set_undefined_str (const std::string& str) {
	//#UC START# *470CC9A70280*
	m_undefined_str = str;
	//#UC END# *470CC9A70280*
}

} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

