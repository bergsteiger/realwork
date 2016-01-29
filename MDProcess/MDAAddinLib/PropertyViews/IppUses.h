////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppUses.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppUses
//
// страница показывает список элементов, которые используют данный
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPUSES_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPUSES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *45741774008C_CUSTOM_INCLUDES*
//#UC END# *45741774008C_CUSTOM_INCLUDES*


// страница показывает список элементов, которые используют данный
class IppUses : public IppBase {
	SET_OBJECT_COUNTER (IppUses)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_USES };

public:
	IppUses ();

public:
	virtual ~IppUses ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppUses)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ObjectTreeResolver::Consumer_set m_consumers;

//#UC START# *45741774008C*
public:
	virtual bool on_ok(bool& need_colorize);
	virtual BOOL OnSetActive();

protected:
	bool m_initialized;

public:
	CListCtrl m_used_in_list;
	afx_msg void OnLvnColumnclickList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult);
//#UC END# *45741774008C*
}; // class IppUses



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPUSES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

