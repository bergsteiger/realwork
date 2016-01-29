////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Connection_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connection_i
// Заголовк реализации фабрик интерфеса IConnection для серванта Connection_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_I_CONNECTION_I_FCTR_H__
#define __SHARED_INTERNET_INET_I_CONNECTION_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/Inet/InetFactories.h"

namespace Internet {
namespace Inet_i {

/// Interface-factory implementation for Connection_i
class Connection_i_factory: virtual public ::Core::RefCountObjectBase, virtual public IConnectionAbstractFactory {
public:
	Connection_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IConnection* make (void* data, unsigned long flags);

};

typedef ::Core::Var<Connection_i_factory> Connection_i_factory_var;

} // namespace Inet_i
} // namespace Internet


#endif //__SHARED_INTERNET_INET_I_CONNECTION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

