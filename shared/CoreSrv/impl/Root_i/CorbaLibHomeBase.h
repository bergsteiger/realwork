////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/CorbaLibHomeBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::CorbaLibHomeBase
// Заголовок реализации класса серванта для интерфеса CorbaLibHomeLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_I_CORBALIBHOMEBASE_H__
#define __SHARED_CORESRV_ROOT_I_CORBALIBHOMEBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "tao/PortableServer/PortableServerC.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"
#include "shared/CoreSrv/Root/Root.h"
#include "shared/CoreSrv/impl/Root_i/Root_i.h"

namespace CoreSrv {
namespace Root_i {

class CorbaLibHomeBase; // self forward Var
typedef ::Core::Var<CorbaLibHomeBase> CorbaLibHomeBase_var;
typedef ::Core::Var<const CorbaLibHomeBase> CorbaLibHomeBase_cvar;

class CorbaLibHomeBase:
	virtual public CorbaLibHomeLocal
	, virtual public Core::Root_i::StdLibHomeBase
{
	SET_OBJECT_COUNTER (CorbaLibHomeBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:

	CorbaLibHomeBase ();

	virtual ~CorbaLibHomeBase ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	PortableServer::POA_var m_home_poa;

	Root::OrbAcsessor_var m_orb_facet;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Root::CorbaLibHome
	// доступ к объектам инфраструктуры ORB-а
	virtual const Root::OrbAcsessor& get_orb_facet () const;
	virtual Root::OrbAcsessor& get_orb_facet ();

	// implemented method from Root::CorbaLibHome
	// Объект инициализации ORB-а (для регистрации интерцепторов)
	virtual PortableInterceptor::ORBInitializer* get_orb_initializer () const;

	// implemented method from CorbaLibHomeLocal
	// доступ к объектам инфраструктуры ORB-а
	virtual void set_orb_facet (Root::OrbAcsessor* orb_facet);

	// implemented method from CorbaLibHomeLocal
	// в этом кал-бек методе дожны быть зарегистрированны в NS все каналы событий, определяемых
	// библиотекой
	virtual void publish_all_event_channel ();

	// implemented method from CorbaLibHomeLocal
	// в этом кал-бек методе дожны быть заоегистрированны в NS все импортируемые серверные фабрики
	virtual void publish_all_servers_factories () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Core::Root_i::LibHomeLocal
	// вызывается фреймворком для освобождения всех ресурсов билиотеки и выполнения де-
	// инициализационных действий, перед удалением билиотеки
	virtual void finalize ();

}; // class CorbaLibHomeBase

} // namespace Root_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_I_CORBALIBHOMEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
