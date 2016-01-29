////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::SplashScreen_i
// Заголовк реализации фабрик интерфеса SplashScreen для серванта SplashScreen_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_SPLASHSCREEN_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_SPLASHSCREEN_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObjectFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for SplashScreen_i
class SplashScreen_i_factory: virtual public ::Core::RefCountObjectBase, virtual public SplashScreenAbstractFactory {
public:
	SplashScreen_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	SplashScreen* make (bool is_start, short x, short y, bool flash_available) /*throw (CanNotFindData)*/;

};

typedef ::Core::Var<SplashScreen_i_factory> SplashScreen_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_SPLASHSCREEN_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

