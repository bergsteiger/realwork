////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// интерфейсы для поддержки чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfacesFactories.h"

namespace GblAdapterLib {
namespace ChatInterfaces {


const char* UnknownUser::uid () const /*throw ()*/ {
	return "3E91B55D-A586-4966-8C1C-4AC142314949";
}

const char* UnknownUser::what () const throw () {
	//#UC START# *4A409D1F00AA_WHAT_IMPL*
	return "UnknownUser (задан идентификатор неизвестного пользователя)";
	//#UC END# *4A409D1F00AA_WHAT_IMPL*
}

// factory interface wrapper for ChatManager
ChatManager& ChatManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ChatManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for MessagesManager
MessagesManager& MessagesManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MessagesManagerFactoryManager::Singleton::instance ()->make ();
}

} // namespace ChatInterfaces
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

