////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/ArgType/ArgType.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::ArgType
//
// пакет для тестирования различных способов передачи интерфейсов в параметры метода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_ARGTYPE_H__
#define __TESTMODEL_BASICTESTS_ARGTYPE_H__

#include "shared/Core/sys/std_inc.h"

namespace BasicTests {
namespace ArgType {

class TestFacet;
typedef ::Core::Var<TestFacet> TestFacet_var;
typedef ::Core::Var<const TestFacet> TestFacet_cvar;
class TestFacet
	: virtual public ::Core::IObject
{
public:
	virtual void in_param (const TestFacet* a) const = 0;

	/*oneway*/ Core::ThreadHandle inout_param (TestFacet* a) const;

	virtual void inoutref_operation (TestFacet& a) const = 0;

	/*oneway*/ Core::ThreadHandle inref_param (const TestFacet& a);

	virtual void out_param (TestFacet*& a) = 0;

// oneway methods impl
private:
	static void thr_inout_param_ (void* arg);

	static void thr_inref_param_ (void* arg);

protected:
	virtual void inout_param_ (TestFacet* a) const = 0;

	virtual void inref_param_ (const TestFacet& a) = 0;
};

} // namespace ArgType
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_ARGTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
