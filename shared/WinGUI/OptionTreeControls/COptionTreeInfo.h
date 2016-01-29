////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeInfo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeInfo
//
// поле информации о дереве контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEINFO_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEINFO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B002D00FA_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

namespace WinGUI {
	class COptionTree;
	class COptionTreeItem;
}
//#UC END# *470B002D00FA_CUSTOM_INCLUDES*

namespace WinGUI {

// поле информации о дереве контролов
class COptionTreeInfo : public CEdit {
	SET_OBJECT_COUNTER (COptionTreeInfo)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeInfo)


//#UC START# *470B002D00FA*
// Construction
public:
	COptionTreeInfo();

// Attributes
public:

// Operations
public:

  void  SetText(COptionTreeItem* pItem,const bool label);
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeInfo)
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetOptionsOwner(COptionTree *otOption);

protected:
	COptionTree *m_otOption;
//#UC END# *470B002D00FA*
}; // class COptionTreeInfo

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

