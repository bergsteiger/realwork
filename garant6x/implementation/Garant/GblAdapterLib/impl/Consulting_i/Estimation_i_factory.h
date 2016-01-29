////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Estimation_i
// Заголовк реализации фабрик интерфеса Estimation для серванта Estimation_i
//
// реализация интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_I_ESTIMATION_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_I_ESTIMATION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/ConsultingFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Estimation_i
class Estimation_i_factory: virtual public ::Core::RefCountObjectBase, virtual public EstimationAbstractFactory {
public:
	Estimation_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Estimation* make ();

};

typedef ::Core::Var<Estimation_i_factory> Estimation_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_I_ESTIMATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

