////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> garant6x::NemesisChatImplementation
//
// реализация чата для немезис
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/NemesisChatImplementation/ServerLibHome.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i_factory.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i_factory.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatManager_i_factory.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i_factory.h"

namespace NemesisChatImplementation {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *4A30E8E402C2_ENVIRONMENTS_CONFIG*
	//#UC END# *4A30E8E402C2_ENVIRONMENTS_CONFIG*

	//#UC START# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A30A4B300FB_MessageManager_i*
	//#UC END# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A30A4B300FB_MessageManager_i*
	
	//#UC START# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A2E3A060102_UsersListManager_i*
	//#UC END# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A2E3A060102_UsersListManager_i*
	
	//#UC START# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A2E39DA02B7_ChatManager_i*
	//#UC END# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A2E39DA02B7_ChatManager_i*
	
	//#UC START# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A4B3C240198_Session_i*
	//#UC END# *4A30E8E402C2_CUSTOM_REGISTRATE_FOR_4A4B3C240198_Session_i*
	
}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
