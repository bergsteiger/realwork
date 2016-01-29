////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/CreateReport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::CreateReport
//
// дилог для создания новго отчета, созданные отчет добавляется в общий список.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_CREATEREPORT_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_CREATEREPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// дилог для создания новго отчета, созданные отчет добавляется в общий список.
class CreateReport : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (CreateReport)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_CREATE_REPORT };

public:
	CreateReport ();

public:
	virtual ~CreateReport ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(CreateReport)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
private:
	// обработчик нажатия кнопки OK
	virtual void on_ok ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Edit-контрол для ввода имени
	CEdit m_name_edit;

	// Edit-контрол для ввода запроса
	CEdit m_query;

	// имя нового отчета
	std::string m_report_name;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_report_name () const;

	void set_report_name (const std::string& report_name);
}; // class CreateReport



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_CREATEREPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

