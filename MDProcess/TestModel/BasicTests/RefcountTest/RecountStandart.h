////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/RefcountTest/RecountStandart.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> TestModel::BasicTests::RefcountTest::RecountStandart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_REFCOUNTTEST_RECOUNTSTANDART_H__
#define __TESTMODEL_BASICTESTS_REFCOUNTTEST_RECOUNTSTANDART_H__

#include "shared/Core/sys/std_inc.h"

namespace BasicTests {

class RecountStandart;
typedef Core::Var<RecountStandart> RecountStandart_var;
typedef Core::Var<const RecountStandart> RecountStandart_cvar;

class RecountStandart :
	virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (RecountStandart)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RecountStandart ();

}; // class RecountStandart

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_REFCOUNTTEST_RECOUNTSTANDART_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

