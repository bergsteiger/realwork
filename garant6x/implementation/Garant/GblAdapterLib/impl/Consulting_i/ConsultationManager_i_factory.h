////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::ConsultationManager_i
// Заголовк реализации фабрик интерфеса ConsultationManager для серванта ConsultationManager_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATIONMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATIONMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/ConsultingFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ConsultationManager_i
class ConsultationManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ConsultationManagerAbstractFactory
{
public:
	ConsultationManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ConsultationManager* make ();

};

typedef ::Core::Var<ConsultationManager_i_factory> ConsultationManager_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATIONMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

