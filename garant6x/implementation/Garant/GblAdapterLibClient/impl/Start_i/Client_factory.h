////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibClient::Start_i::Client
// Заголовк реализации фабрик интерфеса  для серванта Client
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIBCLIENT_START_I_CLIENT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIBCLIENT_START_I_CLIENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"

namespace GblAdapterLibClient {
namespace Start_i {

/// Interface-factory implementation for Client
class Client_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public GblAdapterLib::ComponentManagerAbstractFactory
{
public:
	Client_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	GblAdapterLib::ComponentManager* make ();

};

typedef ::Core::Var<Client_factory> Client_factory_var;

} // namespace Start_i
} // namespace GblAdapterLibClient


#endif //__GARANT6X_GBLADAPTERLIBCLIENT_START_I_CLIENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

