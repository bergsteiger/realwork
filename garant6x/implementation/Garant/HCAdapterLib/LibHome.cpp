////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garant6x::HCAdapterLib
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i_factory.h"

namespace HCAdapterLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *45E43D74036B_ENVIRONMENTS_CONFIG*
	//#UC END# *45E43D74036B_ENVIRONMENTS_CONFIG*

	{
		HCInterfaces_i::ConsultingRequests_i_factory_var fctr = new HCInterfaces_i::ConsultingRequests_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		HCInterfaces_i::Query70ConsultingData_i_factory_var fctr = new HCInterfaces_i::Query70ConsultingData_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		HCInterfaces_i::MarkConsultingData70_i_factory_var fctr = new HCInterfaces_i::MarkConsultingData70_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		HCInterfaces_i::BusinessLogicLifeCycle_i_factory_var fctr = new HCInterfaces_i::BusinessLogicLifeCycle_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
