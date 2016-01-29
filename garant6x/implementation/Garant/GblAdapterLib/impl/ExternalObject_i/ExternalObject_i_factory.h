////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalObject_i
// Заголовк реализации фабрик интерфеса ExternalObject для серванта ExternalObject_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObjectFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ExternalObject_i
class ExternalObject_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ExternalObjectAbstractFactory
{
public:
	ExternalObject_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ExternalObject* make ();

	ExternalObject* make (GblPilot::InternalObj* obj);

};

typedef ::Core::Var<ExternalObject_i_factory> ExternalObject_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

