////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStateStub_i
// Заголовк реализации фабрик интерфеса ConsultingStateStub для серванта ConsultingStateStub_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTATESTUB_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTATESTUB_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ConsultingStateStub_i
class ConsultingStateStub_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ConsultingStateStubAbstractFactory
{
public:
	ConsultingStateStub_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ConsultingStateStub* make_stub ();

};

typedef ::Core::Var<ConsultingStateStub_i_factory> ConsultingStateStub_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTATESTUB_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

