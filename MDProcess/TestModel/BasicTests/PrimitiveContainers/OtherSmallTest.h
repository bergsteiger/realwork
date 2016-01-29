////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/PrimitiveContainers/OtherSmallTest.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> TestModel::BasicTests::PrimitiveContainers::OtherSmallTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_OTHERSMALLTEST_H__
#define __TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_OTHERSMALLTEST_H__

#include "shared/Core/sys/std_inc.h"
#include <queue>
#include <set>
#include <list>

namespace BasicTests {

struct MultiSupport {
	bool operator () (const char* x, const char* y) const;

};

typedef std::queue < Core::Box<char> > StringRefQueue;

typedef std::set < char*, MultiSupport, MultiSupport > CharLnkSet;

typedef std::list < std::string, MultiSupport > AStringAgrList;


} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_OTHERSMALLTEST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
