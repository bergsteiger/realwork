////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControlFactories.h"

namespace GblAdapterLib {


const char* NotUnderControl::uid () const /*throw ()*/ {
	return "83248376-504D-462C-888E-F06FF4227EFD";
}

const char* NotUnderControl::what () const throw () {
	//#UC START# *45F119A60051_WHAT_IMPL*
	return "NotUnderControl (Объект не на контроле.)";
	//#UC END# *45F119A60051_WHAT_IMPL*
}


const char* AlreadyControlled::uid () const /*throw ()*/ {
	return "9A1F19D8-42B0-4179-883B-BF031C87BD86";
}

const char* AlreadyControlled::what () const throw () {
	//#UC START# *45F119A60053_WHAT_IMPL*
	return "AlreadyControlled (Объект уже на контроле.)";
	//#UC END# *45F119A60053_WHAT_IMPL*
}

// factory interface wrapper for ControlManager
ControlManager& ControlManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ControlManagerFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

