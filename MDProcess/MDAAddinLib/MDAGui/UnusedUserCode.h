////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/UnusedUserCode.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::UnusedUserCode
//
// Дилог показывает список изер-секций, которые "пропали" в результате перегенерации модели.
// Позволяет сохранить юзер-секцию в файл
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_UNUSEDUSERCODE_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_UNUSEDUSERCODE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <ostream>
#include "MDProcess/MDAAddinLib/CommonViews/CTooltipListCtrl.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457416890148_CUSTOM_INCLUDES*
//#UC END# *457416890148_CUSTOM_INCLUDES*


// Дилог показывает список изер-секций, которые "пропали" в результате перегенерации модели.
// Позволяет сохранить юзер-секцию в файл
class UnusedUserCode : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (UnusedUserCode)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_UNUSED_USER_CODE };

public:
	UnusedUserCode ();

public:
	virtual ~UnusedUserCode ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(UnusedUserCode)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
protected:
	// сохраняет юзер-секцию с номером index в списке в отдельный файл
	virtual void save (int index);

	// сохраняет все юзер секции из списка в один файл
	virtual void save_all ();

	// записывает юзер-секцию uc в поток
	virtual void save_uc (std::ostream& file, const char* uc);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CTooltipListCtrl m_unused_uc;

//#UC START# *457416890148*
// Dialog Data
	CEdit	m_uc_text;	

// Implementation
protected:	
	afx_msg void OnSelchangeUcList (NMHDR * pNotifyStruct, LRESULT * result);
	afx_msg void OnSaveAll();
	afx_msg void OnSave();
	afx_msg void Discard();
//#UC END# *457416890148*
}; // class UnusedUserCode



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_UNUSEDUSERCODE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

