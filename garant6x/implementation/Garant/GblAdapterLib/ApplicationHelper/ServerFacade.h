////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ServerFacade.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::ApplicationHelper::ServerFacade
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_SERVERFACADE_H__
#define __GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_SERVERFACADE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "tao/ORB_Core.h"

namespace GblAdapterLib {

class ServerFacade;
typedef Core::Var<ServerFacade> ServerFacade_var;
typedef Core::Var<const ServerFacade> ServerFacade_cvar;

class ServerFacade :
	virtual public Core::RefCountObjectBase
{
// virtual void destructor
public:
	virtual ~ServerFacade () {};

//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	virtual CORBA::Object* get_server_interface (const char* facet) const = 0;

}; // class ServerFacade

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_SERVERFACADE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

