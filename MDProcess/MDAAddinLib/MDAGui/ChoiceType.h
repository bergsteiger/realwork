////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/ChoiceType.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::ChoiceType
//
// дилог для выбора типа в слчае его неоднозначности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_CHOICETYPE_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_CHOICETYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457415BB033C_CUSTOM_INCLUDES*
//#UC END# *457415BB033C_CUSTOM_INCLUDES*


// дилог для выбора типа в слчае его неоднозначности
class ChoiceType : public WinGUI::ETSLayoutDialog, public RoseAbstractDumper::IChoiceDlg {
	SET_OBJECT_COUNTER (ChoiceType)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_CHOICE_TYPE };

public:
	ChoiceType ();

public:
	virtual ~ChoiceType ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ChoiceType)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

		// implemented method from RoseAbstractDumper::IChoiceDlg
		// выполнить выбор конкретного элемента
		virtual const std::string make_choice (const GCL::StrSet& ch_list, const std::string& for_item_name);

//#UC START# *457415BB033C*
	CEdit	m_for_item_name;
	CListBox	m_list;
	CString	m_list_value;

	GCL::StrSet m_data;
	std::string m_for_item_name_str;

protected:
	afx_msg void OnDblclkList1();
	virtual void OnOK();

public:
	afx_msg void OnBnClickedCancel();
//#UC END# *457415BB033C*
}; // class ChoiceType



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_CHOICETYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

