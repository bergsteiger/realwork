////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemFont.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemFont
//
// контрол выбора шрифта для отображения в дереве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMFONT_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMFONT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B03AC01A5_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

class CDefFont : public LOGFONT
{
  public:
    CDefFont(const CString& sFaceName="Arial",const LONG height=12);
};
//#UC END# *470B03AC01A5_CUSTOM_INCLUDES*

namespace WinGUI {

// контрол выбора шрифта для отображения в дереве
class COptionTreeItemFont : public CWnd, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemFont)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemFont ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemFont)


//#UC START# *470B03AC01A5*
protected:
	static CDefFont __lfDefault;

public:
	COptionTreeItemFont();
	void SetApplyWindow(CWnd *pWnd);
	void SetCustomSample(const CString& strSample);
	COLORREF GetDefaultTextColor();
	COLORREF GetTextColor();
	void SetTextColor(COLORREF crColor);
	void SetCurFont(LOGFONT* plf);
	BOOL CreateFontItem(LOGFONT* plfFont, COLORREF crFontColor, DWORD dwOptions=OT_FS_USEDEFAULT);

	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void OnShow(BOOL bShow){;}

	void  GetCurFont(LOGFONT& lf);

protected:
	COLORREF m_crDefTextColor;
	COLORREF m_crTextColor;
	LOGFONT m_lfFont;
	CFont   _Font;
	CString m_strCustomSample;
	CWnd *m_pApplyWindow;
	long m_lDefaultHeight;
//#UC END# *470B03AC01A5*
}; // class COptionTreeItemFont

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMFONT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

