////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewViews/NewPropertyPage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> TestModel::BasicTests::NewViews::NewPropertyPage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWVIEWS_NEWPROPERTYPAGE_H__
#define __TESTMODEL_BASICTESTS_NEWVIEWS_NEWPROPERTYPAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "TestModel/BasicTests/NewViews/NewResource.h"
namespace BasicTests {

class NewPropertyPage : public CPropertyPage {
	SET_OBJECT_COUNTER (NewPropertyPage)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_NEW_PROPERTY_PAGE };

public:
	NewPropertyPage ();

public:
	virtual ~NewPropertyPage ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(NewPropertyPage)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
}; // class NewPropertyPage

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWVIEWS_NEWPROPERTYPAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

