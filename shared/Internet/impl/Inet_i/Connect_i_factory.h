////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Connect_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connect_i
// Заголовк реализации фабрик интерфеса IConnect для серванта Connect_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_I_CONNECT_I_FCTR_H__
#define __SHARED_INTERNET_INET_I_CONNECT_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/Inet/InetFactories.h"

namespace Internet {
namespace Inet_i {

/// Interface-factory implementation for Connect_i
class Connect_i_factory: virtual public ::Core::RefCountObjectBase, virtual public IConnectAbstractFactory {
public:
	Connect_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IConnect* make (const InternetAccessInfo& info);

};

typedef ::Core::Var<Connect_i_factory> Connect_i_factory_var;

} // namespace Inet_i
} // namespace Internet


#endif //__SHARED_INTERNET_INET_I_CONNECT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

