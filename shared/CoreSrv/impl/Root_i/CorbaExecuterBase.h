////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/CorbaExecuterBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::CorbaExecuterBase
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_I_CORBAEXECUTERBASE_H__
#define __SHARED_CORESRV_ROOT_I_CORBAEXECUTERBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"

namespace CoreSrv {
namespace Root_i {

class CorbaExecuterBase; // self forward Var
typedef ::Core::Var<CorbaExecuterBase> CorbaExecuterBase_var;
typedef ::Core::Var<const CorbaExecuterBase> CorbaExecuterBase_cvar;

class CorbaExecuterBase:
	virtual public Core::Root_i::ExecutorBase
{
	SET_OBJECT_COUNTER (CorbaExecuterBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CorbaExecuterBase ();

	virtual ~CorbaExecuterBase ();
}; // class CorbaExecuterBase

} // namespace Root_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_I_CORBAEXECUTERBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
