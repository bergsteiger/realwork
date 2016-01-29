////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewViews/NewPropertySheet.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertySheet::Class>> TestModel::BasicTests::NewViews::NewPropertySheet
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWVIEWS_NEWPROPERTYSHEET_H__
#define __TESTMODEL_BASICTESTS_NEWVIEWS_NEWPROPERTYSHEET_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "TestModel/BasicTests/NewViews/NewResource.h"
namespace BasicTests {

class NewPropertySheet : public CPropertySheet {
	SET_OBJECT_COUNTER (NewPropertySheet)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	NewPropertySheet ();

public:
	virtual ~NewPropertySheet ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(NewPropertySheet)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
}; // class NewPropertySheet

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWVIEWS_NEWPROPERTYSHEET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

