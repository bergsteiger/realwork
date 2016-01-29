////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageListener_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"

namespace GblAdapterLib {
namespace ChatService_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MessageListener_i::MessageListener_i ()
//#UC START# *4A2E213E025E_4A2E34A00253_4A2E3A1802B8_BASE_INIT*
//#UC END# *4A2E213E025E_4A2E34A00253_4A2E3A1802B8_BASE_INIT*
{
	//#UC START# *4A2E213E025E_4A2E34A00253_4A2E3A1802B8_BODY*
	//#UC END# *4A2E213E025E_4A2E34A00253_4A2E3A1802B8_BODY*
}

MessageListener_i::~MessageListener_i () {
	//#UC START# *4A2E3A1802B8_DESTR_BODY*
	//#UC END# *4A2E3A1802B8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ChatLibrary::ChatService::MessageListener
// получить сообщение
void MessageListener_i::receive_message (
	const ChatLibrary::ChatService::Message& data
) throw (
	CORBA::SystemException
) {
	//#UC START# *4A2E232102EB_4A2E3A1802B8*
	LOG_D (("%s: message received", GDS_CURRENT_FUNCTION));

	ChatInterfaces::ChatManagerFactory::make ().receive_message (data);
	//#UC END# *4A2E232102EB_4A2E3A1802B8*
}
} // namespace ChatService_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

