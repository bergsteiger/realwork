////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeFontSelFontCombo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeFontSelFontCombo
//
// комбо-бокс для выбора шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELFONTCOMBO_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELFONTCOMBO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFF50030D_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

// Structures
struct OT_FONTSEL_ITEM
{
	DWORD dwFontType;
	LOGFONT lf;
};
//#UC END# *470AFF50030D_CUSTOM_INCLUDES*

namespace WinGUI {

// комбо-бокс для выбора шрифта
class COptionTreeFontSelFontCombo : public CComboBox {
	SET_OBJECT_COUNTER (COptionTreeFontSelFontCombo)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeFontSelFontCombo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeFontSelFontCombo)


//#UC START# *470AFF50030D*
// Construction
public:
	COptionTreeFontSelFontCombo();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeFontSelFontCombo)
	public:
	virtual void DrawItem(LPDRAWITEMSTRUCT lpDIS);
	virtual void DeleteItem(LPDELETEITEMSTRUCT lpDIS);
	//}}AFX_VIRTUAL

// Implementation
public:
	int AddFont(LOGFONT *pLF, DWORD FontType);
	CString GetCurrentName();

	OT_FONTSEL_ITEM* GetFontItem(int nSel = -1);
	LPLOGFONT GetLogFont(int nSel = -1);
	DWORD GetFontType(int nSel = -1);

public:
	BOOL SelectFontName(CString strName);


protected:
	CBitmap m_bmpTrueType;
	CBitmap m_bmpMask;
//#UC END# *470AFF50030D*
}; // class COptionTreeFontSelFontCombo

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELFONTCOMBO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

