////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/ListCtrlWithCopy.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> MDProcess::MDAAddinLib::MDAGui::ListCtrlWithCopy
//
// список с поддержкой копирования
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_LISTCTRLWITHCOPY_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_LISTCTRLWITHCOPY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "afxwin.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// список с поддержкой копирования
class ListCtrlWithCopy : public CListCtrl {
	SET_OBJECT_COUNTER (ListCtrlWithCopy)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ListCtrlWithCopy ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ListCtrlWithCopy)

private:
	// реализация копирования в буфер выделенного текста
	virtual void on_copy ();

	virtual void on_key_down (unsigned int key, unsigned int rep_cnt, unsigned int flags);

	// поддержка операции копирования в буфер
	virtual void on_update_copy (CCmdUI* cmd);

}; // class ListCtrlWithCopy



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_LISTCTRLWITHCOPY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

