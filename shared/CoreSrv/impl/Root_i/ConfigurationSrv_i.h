////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/ConfigurationSrv_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::ConfigurationSrv_i
// Заголовок реализации класса серванта для интерфеса 
//
// Серверный вариант (пере определяет серверные переменные)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_I_CONFIGURATIONSRV_I_H__
#define __SHARED_CORESRV_ROOT_I_CONFIGURATIONSRV_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/Configuration_i.h"

namespace CoreSrv {
namespace Root_i {

class ConfigurationSrv_i; // self forward Var
typedef ::Core::Var<ConfigurationSrv_i> ConfigurationSrv_i_var;
typedef ::Core::Var<const ConfigurationSrv_i> ConfigurationSrv_i_cvar;

class ConfigurationSrv_i_factory;

// Серверный вариант (пере определяет серверные переменные)
class ConfigurationSrv_i:
	virtual public Core::Root_i::Configuration_i
{
	SET_OBJECT_COUNTER (ConfigurationSrv_i)
	friend class ConfigurationSrv_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConfigurationSrv_i ();

	virtual ~ConfigurationSrv_i ();
}; // class ConfigurationSrv_i

} // namespace Root_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_I_CONFIGURATIONSRV_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
