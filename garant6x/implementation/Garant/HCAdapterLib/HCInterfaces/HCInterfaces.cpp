////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// Интерфейсы для взаимодействия с отделом Пащака
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapterLib {
namespace HCInterfaces {


const char* CantFindXerces::uid () const /*throw ()*/ {
	return "55D0E5EB-A193-459C-B12C-8C926D673910";
}

const char* CantFindXerces::what () const throw () {
	//#UC START# *44870AB700BB_WHAT_IMPL*
	return "CantFindXerces (Не смогли загрузить библиотеку для работы с XML)";
	//#UC END# *44870AB700BB_WHAT_IMPL*
}

// factory interface wrapper for OnlineData
OnlineData* OnlineDataFactory::make (
	GCI::IO::Stream* xml_stream
	, const GblConsultingDef::ConsultationID& consultation_id
	, const char* key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return OnlineDataFactoryManager::Singleton::instance ()->make (xml_stream, consultation_id, key);
}


OnlineDataFactory::KeySet* OnlineDataFactory::keys () {
	return OnlineDataFactoryManager::keys ();
}

// factory interface wrapper for BusinessLogicLifeCycle
BusinessLogicLifeCycle* BusinessLogicLifeCycleFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return BusinessLogicLifeCycleFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for ConsultingRequests
ConsultingRequests* ConsultingRequestsFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConsultingRequestsFactoryManager::Singleton::instance ()->make ();
}

} // namespace HCInterfaces
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

