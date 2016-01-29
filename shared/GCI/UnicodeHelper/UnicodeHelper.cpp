////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/UnicodeHelper/UnicodeHelper.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::UnicodeHelper
//
// ��������������� ���������� ��� ������ � Unicode
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelper.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"

namespace GCI {
namespace UnicodeHelper {

// factory interface wrapper for ConverterHelper
ConverterHelper* ConverterHelperFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConverterHelperFactoryManager::Singleton::instance ()->make ();
}


ConverterHelperFactory::KeySet* ConverterHelperFactory::keys () {
	return ConverterHelperFactoryManager::keys ();
}

} // namespace UnicodeHelper
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

