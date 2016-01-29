////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::SplashScreen_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i.h"

namespace GblAdapterLib {

SplashScreen_i_factory::SplashScreen_i_factory () {
}

void SplashScreen_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SplashScreenFactoryManager::register_factory (this, priority);
}

const char* SplashScreen_i_factory::key () const {
	return "SplashScreen_i";
}

SplashScreen* SplashScreen_i_factory::make (
	bool is_start
	, short x
	, short y
	, bool flash_available
) /*throw (
	CanNotFindData
)*/ {
	SplashScreen_i_var ret = new SplashScreen_i (is_start, x, y, flash_available);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

