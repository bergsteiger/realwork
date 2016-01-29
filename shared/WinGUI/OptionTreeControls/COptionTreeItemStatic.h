////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemStatic.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemStatic
//
// static
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMSTATIC_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMSTATIC_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"

//#UC START# *470B0C3F0167_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B0C3F0167_CUSTOM_INCLUDES*

namespace WinGUI {

// static
class COptionTreeItemStatic :
	public COptionTreeItem
{
	SET_OBJECT_COUNTER (COptionTreeItemStatic)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemStatic ();


//#UC START# *470B0C3F0167*
public:
	BOOL CreateStaticItem(DWORD dwOptions);
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void OnShow(BOOL bShow){;}
	virtual CString GetAttributeText(void);

	void SetStaticText(CString strStaticText);
	CString GetStaticText();
	COptionTreeItemStatic();
	virtual void AddIcon (HICON hIcon){m_hIcon = hIcon;}; // hb - macro to add icon
	virtual void AddBitmap (CBitmap *pBitmap){m_pBitmap = pBitmap;}; // hb - macro to add icon

protected:
	CString m_strStaticText;
	HICON m_hIcon; // hb - added an icon 
	CBitmap *m_pBitmap; // hb - added a bitmap
//#UC END# *470B0C3F0167*
}; // class COptionTreeItemStatic

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMSTATIC_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

