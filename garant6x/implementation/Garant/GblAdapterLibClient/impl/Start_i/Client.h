////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibClient::Start_i::Client
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIBCLIENT_START_I_CLIENT_H__
#define __GARANT6X_GBLADAPTERLIBCLIENT_START_I_CLIENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/ComponentManagerBase.h"

//#UC START# *474C10480085_CUSTOM_INCLUDES*
//#UC END# *474C10480085_CUSTOM_INCLUDES*

namespace GblAdapterLibClient {
namespace Start_i {

class Client; // self forward Var
typedef ::Core::Var<Client> Client_var;
typedef ::Core::Var<const Client> Client_cvar;

class Client_factory;

class Client:
	virtual public GblAdapterLib::ComponentManagerBase
{
	SET_OBJECT_COUNTER (Client)
	friend class Client_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Client ();

	virtual ~Client ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GblAdapterLib::ComponentManagerBase
	virtual void run ();

	// implemented method from GblAdapterLib::ComponentManagerBase
	virtual void smart_backend_init () const;

	// implemented method from GblAdapterLib::ComponentManagerBase
	virtual void timestamp_init (GblPilot::FunctionMng* function_manager) const;

//#UC START# *474C10480085*
//#UC END# *474C10480085*
}; // class Client

} // namespace Start_i
} // namespace GblAdapterLibClient


#endif //__GARANT6X_GBLADAPTERLIBCLIENT_START_I_CLIENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
