////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/Contents.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::PropertyViews::Contents
//
// дилог, показывающий содержмое элемента -  атрибуты элемента, операции и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_CONTENTS_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_CONTENTS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4573E7D70290_CUSTOM_INCLUDES*
#include "afxwin.h"
#include "afxcmn.h"
//#UC END# *4573E7D70290_CUSTOM_INCLUDES*


// дилог, показывающий содержмое элемента -  атрибуты элемента, операции и т.д
class Contents : public CDialog {
	SET_OBJECT_COUNTER (Contents)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_CONTENTS };

public:
	explicit Contents (IRoseItemPtr item);

public:
	virtual ~Contents ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(Contents)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

//#UC START# *4573E7D70290*
protected:
	IRoseItemPtr m_item;

public:
	void fill_dlg ();
	CListCtrl m_contents_list;
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton1();
	afx_msg void OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult);
//#UC END# *4573E7D70290*
}; // class Contents



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_CONTENTS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

