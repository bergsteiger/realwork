////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/CEditMask.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::CEditMask
//
// контрол ввода с возможность фильтрации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_CEDITMASK_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_CEDITMASK_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFDEC0203_CUSTOM_INCLUDES*
#define FLOAT_MASK					        "^(-?)([0-9]*)[.,]?([0-9]*)$"
#define INT_MASK                    "^(-?)([0-9]*)([0-9]*)$"
#define FLOAT_MASK_POSITIVE					"^([0-9]*)[.,]?([0-9]*)$"
#define INT_MASK_POSITIVE           "^([0-9]*)([0-9]*)$"

typedef int (*EDITINPUTCALLBACK)(CString&) ;
//#UC END# *470AFDEC0203_CUSTOM_INCLUDES*

namespace WinGUI {

// контрол ввода с возможность фильтрации
class CEditMask : public CEdit {
	SET_OBJECT_COUNTER (CEditMask)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~CEditMask ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(CEditMask)


//#UC START# *470AFDEC0203*
// Konstruktion
public:
	CEditMask();
// Attribute
public:

// Operationen
public:

// Ьberschreibungen
	// Vom Klassen-Assistenten generierte virtuelle Funktionsьberschreibungen
	//{{AFX_VIRTUAL(CEditMask)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	//}}AFX_VIRTUAL

// Implementierung
public:
	bool SetMaxLenght(int iMaxLength);
	int ValidateInput(char *pInputText);
	CString m_stInputMask;
	int SetInputMask(const CString &stInputMask);
	
	int SetCallback(EDITINPUTCALLBACK EditInputMask) ;
	int CallCallback(CString& stText) ;
	
	EDITINPUTCALLBACK pEditInputCallback ;

	// Generierte Nachrichtenzuordnungsfunktionen
protected:
  int m_iMaxLength ;
//#UC END# *470AFDEC0203*
}; // class CEditMask

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_CEDITMASK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

