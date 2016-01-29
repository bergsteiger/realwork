////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeFontSelSizeCombo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeFontSelSizeCombo
//
// комбо-бокс для выбора размера шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELSIZECOMBO_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELSIZECOMBO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFFC4001F_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470AFFC4001F_CUSTOM_INCLUDES*

namespace WinGUI {

// комбо-бокс для выбора размера шрифта
class COptionTreeFontSelSizeCombo : public CComboBox {
	SET_OBJECT_COUNTER (COptionTreeFontSelSizeCombo)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeFontSelSizeCombo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeFontSelSizeCombo)


//#UC START# *470AFFC4001F*
	// Construction
public:
	COptionTreeFontSelSizeCombo();
	int AddSize(int nPointSize, long lfHeight);
	void GetPointSize(CY& cy);
	long GetHeight(int nSel = -1);
	void UpdateLogFont(LPLOGFONT lpLF, int nSel = -1);
//#UC END# *470AFFC4001F*
}; // class COptionTreeFontSelSizeCombo

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSELSIZECOMBO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

