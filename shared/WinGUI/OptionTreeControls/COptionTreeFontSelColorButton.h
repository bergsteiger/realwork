////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeFontSelColorButton.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeFontSelColorButton
//
// кнопка выбора шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELCOLORBUTTON_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELCOLORBUTTON_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFF120290_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

#ifndef OT_COLORPOPUP
	#include "shared/WinGUI/OptionTreeControls/COptionTreeColorPopUp.h"
#endif

void AFXAPI DDX_FontSelColorButton(CDataExchange *pDX, int nIDC, COLORREF& crColor);
//#UC END# *470AFF120290_CUSTOM_INCLUDES*

namespace WinGUI {

// кнопка выбора шрифта
class COptionTreeFontSelColorButton : public CButton {
	SET_OBJECT_COUNTER (COptionTreeFontSelColorButton)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeFontSelColorButton ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeFontSelColorButton)


//#UC START# *470AFF120290*
public:
	COptionTreeFontSelColorButton();	
	COLORREF GetColor() const;
	void SetColor(COLORREF crColor);
	COLORREF GetDefaultColor() const;
	void SetDefaultColor(COLORREF crColor);
	void SetCustomText(LPCTSTR tszText);
	void SetDefaultText(LPCTSTR tszText);
	void SetTrackSelection(BOOL bTrack);
	BOOL GetTrackSelection() const;

	//{{AFX_VIRTUAL(COptionTreeFontSelColorButton)
    public:
    virtual void DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);
    protected:
    virtual void PreSubclassWindow();
    //}}AFX_VIRTUAL

protected:
	//{{AFX_MSG(COptionTreeFontSelColorButton)
    afx_msg BOOL OnClicked();
    afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
    //}}AFX_MSG
	afx_msg long OnSelEndOK(UINT lParam, long wParam);
    afx_msg long OnSelEndCancel(UINT lParam, long wParam);
    afx_msg long OnSelChange(UINT lParam, long wParam);
	static void DrawArrow(CDC* pDC, RECT* pRect, int nDirection = 0, COLORREF crArrow = RGB(0, 0, 0));


	COLORREF m_crColor;
	COLORREF m_crDefaultColor;
	CString m_strDefaultText;
	CString m_strCustomText;
	BOOL m_bPopupActive;
	BOOL m_bTrackSelection;

private:

	typedef CButton _Inherited;
//#UC END# *470AFF120290*
}; // class COptionTreeFontSelColorButton

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELCOLORBUTTON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

