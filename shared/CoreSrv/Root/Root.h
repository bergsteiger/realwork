////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Root/Root.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Root
//
// Пакет рутовых локальных интерфейсов фремворка GCM2 (серверная версия)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_H__
#define __SHARED_CORESRV_ROOT_H__

#include "shared/Core/sys/std_inc.h"
#include "TAO/orbsvcs/orbsvcs/CosNamingC.h"
#include "TAO/tao/PortableInterceptorC.h"
#include "shared/Core/Root/Root.h"
#include "tao/ORB_Core.h"
#include "tao/PortableServer/PortableServerC.h"

namespace CoreSrv {
namespace Root {

class OrbAcsessor;
typedef ::Core::Var<OrbAcsessor> OrbAcsessor_var;
typedef ::Core::Var<const OrbAcsessor> OrbAcsessor_cvar;
// Интерфейс доступа к данным и объектам ORB-а
class OrbAcsessor
	: virtual public ::Core::IObject
{
public:
	// Основной ORB
	virtual CORBA::ORB& get_main_orb () const = 0;

	// Рутовый объект контекста Name Service-а
	virtual CosNaming::NamingContext& get_ns_root () const = 0;

	// Объект текущего контекста PICurrent
	virtual PortableInterceptor::Current& get_pi_current () const = 0;

	// Рутовый POA
	virtual PortableServer::POA& get_root_poa () const = 0;
};

class CorbaLibHome;
typedef ::Core::Var<CorbaLibHome> CorbaLibHome_var;
typedef ::Core::Var<const CorbaLibHome> CorbaLibHome_cvar;
// Серверный вариант интерфейса библиотеки. Расширяет базовый возможностью доступа к объектами ORB-а
class CorbaLibHome
	: virtual public Core::Root::LibHome
{
public:
	// Объект инициализации ORB-а (для регистрации интерцепторов)
	virtual PortableInterceptor::ORBInitializer* get_orb_initializer () const = 0;

	// доступ к объектам инфраструктуры ORB-а
	virtual const OrbAcsessor& get_orb_facet () const = 0;
	virtual OrbAcsessor& get_orb_facet () = 0;
};

} // namespace Root
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
