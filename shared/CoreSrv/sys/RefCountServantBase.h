////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/sys/RefCountServantBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::CoreSrv::sys::RefCountServantBase
//
// класс-примесь для реализации счетчика ссылок на CORBA-сервантах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SYS_REFCOUNTSERVANTBASE_H__
#define __SHARED_CORESRV_SYS_REFCOUNTSERVANTBASE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/sys/RefCountObjectBase.h"
#include "tao/PortableServer/Servant_Base.h"

//#UC START# *4500369F036B_CUSTOM_INCLUDES*
//#UC END# *4500369F036B_CUSTOM_INCLUDES*

namespace CoreSrv {

// класс-примесь для реализации счетчика ссылок на CORBA-сервантах
class RefCountServantBase :
	virtual public Core::RefCountObjectBase
	, virtual public TAO_ServantBase
{
// virtual void destructor
public:
	virtual ~RefCountServantBase () {};

//#UC START# *4500369F036B*
	virtual void _add_ref () {
		this->addref ();
	}
	
	virtual void _remove_ref () {
		this->release ();
	}

	virtual CORBA::ULong _refcount_value () const {
		return this->ref_count ();
	}
//#UC END# *4500369F036B*
}; // class RefCountServantBase

} // namespace CoreSrv


#endif //__SHARED_CORESRV_SYS_REFCOUNTSERVANTBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

