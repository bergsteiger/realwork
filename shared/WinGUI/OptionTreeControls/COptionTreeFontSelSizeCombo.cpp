////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeFontSelSizeCombo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeFontSelSizeCombo
//
// комбо-бокс для выбора размера шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeFontSelSizeCombo.h"

//#UC START# *470AFFC4001F_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeFontSelGlobals.h"
#include "afximpl2005.h"
//#UC END# *470AFFC4001F_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470AFFC4001F*
COptionTreeFontSelSizeCombo::COptionTreeFontSelSizeCombo()
{
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeFontSelSizeCombo message handlers

int COptionTreeFontSelSizeCombo::AddSize(int nPointSize, long lfHeight)
{
	if (lfHeight == 0)
	{
		lfHeight = MulDiv(-afxData.cyPixelsPerInch, nPointSize, 72);
	}

	CString str;
	wsprintf(str.GetBuffer(16), _T("%d"), nPointSize);
	str.ReleaseBuffer();

	int nMaxEntries = GetCount();
	int nEntry;

	// We use positive height values for non-truetype fonts, negitive for true type
	if (lfHeight > 0)
	{
		for (nEntry = 0; nEntry < nMaxEntries; nEntry++)
		{
			int iComp = (int)(lfHeight - GetHeight(nEntry));
			if (!iComp)
				return CB_ERR;
			if (iComp < 0)
				break;
		}
	}
	else
	{
		for (nEntry = 0; nEntry < nMaxEntries; nEntry++)
		{
			int iComp = (int)(lfHeight - GetHeight(nEntry));
			if (!iComp)
				return CB_ERR;
			if (iComp > 0)
				break;
		}
	}

	if (nEntry == nMaxEntries)
		nEntry = -1;
	nEntry = InsertString(nEntry, str);
	if (nEntry != CB_ERR)
		SetItemData(nEntry, (DWORD)lfHeight);

	return nEntry;
}

void COptionTreeFontSelSizeCombo::GetPointSize(CY& cy)
{
	TCHAR szText[20];
	GetWindowText(szText, 20);
	cy.Lo = 0;
	cy.Hi = 0;
	_AfxCyFromString(cy, szText);
}

long COptionTreeFontSelSizeCombo::GetHeight(int nSel)
{
	if (nSel == -1)
		nSel = GetCurSel();

	if (nSel == -1)
	{
		TCHAR szText[20];
		GetWindowText(szText, 20);
		nSel = FindString(-1, szText);
		if (nSel == CB_ERR)
		{
			CY cyTmp;
			cyTmp.Lo = 0;
			cyTmp.Hi = 0;
			_AfxCyFromString(cyTmp, szText);
			int PointSize = (int)((cyTmp.Lo + 5000) / 10000);
			if (PointSize != 0)
				return MulDiv(-afxData.cyPixelsPerInch, PointSize, 72);
			else
				nSel = 0;
		}
	}

	return (long) GetItemData(nSel);
}

void COptionTreeFontSelSizeCombo::UpdateLogFont(LPLOGFONT lpLF, int nSel)
{
	ASSERT(lpLF);

	lpLF->lfHeight = (int)GetHeight(nSel);
	lpLF->lfWidth = 0;
}
//#UC END# *470AFFC4001F*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeFontSelSizeCombo::~COptionTreeFontSelSizeCombo () {
	//#UC START# *470AFFC4001F_DESTR_BODY*
	//#UC END# *470AFFC4001F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeFontSelSizeCombo, CComboBox)
	//#UC START# *470AFFC4001F_MESSAGE_MAP*
	//#UC END# *470AFFC4001F_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeFontSelSizeCombo, CComboBox)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

