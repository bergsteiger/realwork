////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppException.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppException
//
// страница для снятия/установки эксепшнов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPEXCEPTION_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPEXCEPTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457417610109_CUSTOM_INCLUDES*
//#UC END# *457417610109_CUSTOM_INCLUDES*


// страница для снятия/установки эксепшнов
class IppException : public IppBase {
	SET_OBJECT_COUNTER (IppException)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_EXCEPTION };

public:
	IppException ();

public:
	virtual ~IppException ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppException)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	RoseHelper::RoseItemMap m_all_get;

	RoseHelper::RoseItemMap m_all_set;

	RoseHelper::RoseItemMap m_get;

	RoseHelper::RoseItemMap m_set;

//#UC START# *457417610109*
	CListBox	m_set_ex;
	CListBox	m_get_ex;
	CListBox	m_all_set_ex;
	CListBox	m_all_get_ex;

// Implementation
protected:
	afx_msg void OnAddGet();
	afx_msg void OnAddSet();
	afx_msg void OnRemoveGet();
	afx_msg void OnRemoveSet();
	virtual bool on_ok(bool& need_colorize);
//#UC END# *457417610109*
}; // class IppException



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPEXCEPTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

