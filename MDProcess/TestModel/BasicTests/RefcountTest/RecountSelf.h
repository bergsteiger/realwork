////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/RefcountTest/RecountSelf.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> TestModel::BasicTests::RefcountTest::RecountSelf
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_REFCOUNTTEST_RECOUNTSELF_H__
#define __TESTMODEL_BASICTESTS_REFCOUNTTEST_RECOUNTSELF_H__

#include "shared/Core/sys/std_inc.h"

namespace BasicTests {

class RecountSelf;
typedef Core::Var<RecountSelf> RecountSelf_var;
typedef Core::Var<const RecountSelf> RecountSelf_cvar;

class RecountSelf {
	SET_OBJECT_COUNTER (RecountSelf)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RecountSelf ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual unsigned long addref () const;
	virtual unsigned long release () const;
	virtual unsigned long ref_count () const;
}; // class RecountSelf

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_REFCOUNTTEST_RECOUNTSELF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

