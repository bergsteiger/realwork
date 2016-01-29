////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/DeleteQuestion.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::DeleteQuestion
//
// дилог-вопрос об удалении элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_DELETEQUESTION_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_DELETEQUESTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseItemList.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// дилог-вопрос об удалении элемента
class DeleteQuestion : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (DeleteQuestion)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_DELETE_QUESTION };

public:
	// элемент, подлежащий удалению.
	explicit DeleteQuestion (IRoseElementPtr elem);

public:
	virtual ~DeleteQuestion ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(DeleteQuestion)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
private:
	// заполнит список дополнительных элементов.
	void fill_additional ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// список дополнительных элементов, подлежащих удалению
	RoseItemList m_additional;

	// элемент, подлежащий удалению.
	IRoseElementPtr m_elem;
}; // class DeleteQuestion



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_DELETEQUESTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

