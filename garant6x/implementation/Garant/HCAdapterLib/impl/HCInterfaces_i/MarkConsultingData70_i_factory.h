////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::MarkConsultingData70_i
// Заголовк реализации фабрик интерфеса  для серванта MarkConsultingData70_i
//
// оценка для СК версии 7.0
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_MARKCONSULTINGDATA70_I_FCTR_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_MARKCONSULTINGDATA70_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

/// Interface-factory implementation for MarkConsultingData70_i
class MarkConsultingData70_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public HCInterfaces::OnlineDataAbstractFactory
{
public:
	MarkConsultingData70_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	HCInterfaces::OnlineData* make (GCI::IO::Stream* xml_stream, const GblConsultingDef::ConsultationID& consultation_id);

};

typedef ::Core::Var<MarkConsultingData70_i_factory> MarkConsultingData70_i_factory_var;

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_MARKCONSULTINGDATA70_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

