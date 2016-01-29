////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/ComplexTypesSmallTest/NewSettings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> TestModel::BasicTests::ComplexTypesSmallTest::NewSettings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWSETTINGS_H__
#define __TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWSETTINGS_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NativeTypesSmallTest/NativeTypesSmallTest.h"

namespace BasicTests {

class NewSettings {

// static member methods and data
public:
	static const bool get_my_bool () /* throw (Core::ParameterIsMissing) */;
	static void set_my_bool (bool value);
	static const char* my_bool_param_name ();

	static const NativeTypesSmallTest::NewEnum get_my_enum () /* throw (Core::ParameterIsMissing) */;
	static void set_my_enum (NativeTypesSmallTest::NewEnum value);
	static const char* my_enum_param_name ();

	static const long get_my_long () /* throw (Core::ParameterIsMissing) */;
	static void set_my_long (long value);
	static const char* my_long_param_name ();

}; // class NewSettings

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWSETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

