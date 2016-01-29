////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::InternetSupport_i
// Заголовк реализации фабрик интерфеса InternetSupport для серванта InternetSupport_i
//
// поддержка работы пользователей через internet
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_INTERNETSUPPORT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_INTERNETSUPPORT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupportFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for InternetSupport_i
class InternetSupport_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public InternetSupportAbstractFactory
{
public:
	InternetSupport_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	InternetSupport* make ();

};

typedef ::Core::Var<InternetSupport_i_factory> InternetSupport_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_INTERNETSUPPORT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

