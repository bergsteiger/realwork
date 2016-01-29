////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/SimpleTypeContainers/SimpleTypeContainers.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::SimpleTypeContainers
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_SIMPLETYPECONTAINERS_H__
#define __TESTMODEL_BASICTESTS_SIMPLETYPECONTAINERS_H__

#include "shared/Core/sys/std_inc.h"
#include "boost/array.hpp"
#include "shared/Core/data/Array.h"
#include "TestModel/BasicTests/NativeTypesSmallTest/NativeTypesSmallTest.h"

namespace BasicTests {
namespace SimpleTypeContainers {

typedef Core::Array < long > LongArray;

typedef Core::Array < NativeTypesSmallTest::FullCharStruct > SimpleArray;

typedef boost::array < long, 100 > LongFixedArray100;

} // namespace SimpleTypeContainers
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_SIMPLETYPECONTAINERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
