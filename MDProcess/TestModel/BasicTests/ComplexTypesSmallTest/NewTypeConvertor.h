////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/ComplexTypesSmallTest/NewTypeConvertor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> TestModel::BasicTests::ComplexTypesSmallTest::NewTypeConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWTYPECONVERTOR_H__
#define __TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWTYPECONVERTOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace BasicTests {

class NewTypeConvertor : 
	public Core::UnsortedTypeConverter<long, std::string> {
	protected:
		void fill_array () {
			//#UC START# *49AEE436020A_FILL_ARRAY_IMPLEMENTATION*
			//#UC END# *49AEE436020A_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class NewTypeConvertor

typedef ACE_Singleton<NewTypeConvertor, ACE_SYNCH_NULL_MUTEX> NewTypeConvertorSingleton;

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_COMPLEXTYPESSMALLTEST_NEWTYPECONVERTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

