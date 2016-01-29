////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/ComplexTypesSmallTest/NewUtilityPack.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> TestModel::BasicTests::ComplexTypesSmallTest::NewUtilityPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWUTILITYPACK_H__
#define __TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWUTILITYPACK_H__

#include "shared/Core/sys/std_inc.h"
#include "boost/function.hpp"
#include "TestModel/BasicTests/ComplexTypesSmallTest/NewSimpleClass.h"
#include "TestModel/BasicTests/ComplexTypesSmallTest/NewSimpleClass1.h"

namespace BasicTests {

class NewBitMask : public Core::BitMaskType<short, NewBitMask> {
	friend class Core::BitMaskType<short, NewBitMask>;
	NewBitMask (short val) : Core::BitMaskType<short, NewBitMask> (val) {
	}
public:
	NewBitMask () : Core::BitMaskType<short, NewBitMask> (0) {
	}

	static const NewBitMask A3 () {
		return 1 << 1;
	}
	static const NewBitMask A7 () {
		return 1 << 2;
	}
};

class DerivedBitMask : public Core::BitMaskType<long, DerivedBitMask> {
	friend class Core::BitMaskType<long, DerivedBitMask>;
	DerivedBitMask (long val) : Core::BitMaskType<long, DerivedBitMask> (val) {
	}
public:
	DerivedBitMask () : Core::BitMaskType<long, DerivedBitMask> (0) {
	}

	static const DerivedBitMask A9 () {
		return 1 << 1;
	}
};

typedef boost::function<DerivedBitMask (long, char&)> NewFunction;

class NewSimpleClass;
template <class T1, class T2> class NewSimpleClass1;
typedef NewSimpleClass1< long, NewSimpleClass > NewInstanceDef;


} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWUTILITYPACK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
