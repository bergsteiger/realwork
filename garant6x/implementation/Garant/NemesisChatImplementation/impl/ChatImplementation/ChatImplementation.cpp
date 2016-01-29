////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> garant6x::NemesisChatImplementation::ChatImplementation
//
// реализация чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include <typeinfo>
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementationFactories.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"


namespace NemesisChatImplementation {
namespace ChatImplementation {

// factory interface wrapper for LocalChatManager
LocalChatManager& LocalChatManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	try {
		PortableServer::ServantBase_var serv = LibHomeFactory::get().get_orb_facet().get_root_poa().reference_to_servant (
			&ChatLibrary::ChatService::ChatManagerFactory::make ()
		);
		return dynamic_cast<LocalChatManager&> (*serv.in ());
	} catch (std::bad_cast&) {
		throw Core::Root::NoActiveFactory ("NemesisChatImplementation::ChatImplementation::LocalChatManagerFactory");
	}
}



} //namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

