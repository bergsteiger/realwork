////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/I18N/I18N.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::I18N
//
// Интернационализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/I18N/I18NFactories.h"

namespace GCI {
namespace I18N {


const char* BadFileFormat::uid () const /*throw ()*/ {
	return "E58EA62D-8ED8-4201-8582-5D5634933455";
}

const char* BadFileFormat::what () const throw () {
	//#UC START# *452CC1680157_WHAT_IMPL*
	return "BadFileFormat (Не смогли прочитать файл со строками.)";
	//#UC END# *452CC1680157_WHAT_IMPL*
}


const char* CantFindFile::uid () const /*throw ()*/ {
	return "3CCEBFB7-0551-411C-939A-DFF93A658059";
}

const char* CantFindFile::what () const throw () {
	//#UC START# *452CC1E800CB_WHAT_IMPL*
	return "CantFindFile (Не смогли прочитать файл, содержащий строки)";
	//#UC END# *452CC1E800CB_WHAT_IMPL*
}

// factory interface wrapper for LocaleOperations
LocaleOperations& LocaleOperationsFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return LocaleOperationsFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for Messages
Messages& MessagesFactory::messages () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MessagesFactoryManager::Singleton::instance ()->messages ();
}

} // namespace I18N
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

