////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/Configuration_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::Configuration_i
// Заголовок реализации класса серванта для интерфеса Configuration
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_CONFIGURATION_I_H__
#define __SHARED_CORE_ROOT_I_CONFIGURATION_I_H__

#include "ace/ACE.h"
#include "shared/Core/Root/Root.h"

namespace Core {
namespace Root_i {

class Configuration_i; // self forward Var
typedef ::Core::Var<Configuration_i> Configuration_i_var;
typedef ::Core::Var<const Configuration_i> Configuration_i_cvar;

class Configuration_i_factory;

class Configuration_i:
	virtual public Root::Configuration
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Configuration_i)
	friend class Configuration_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Configuration_i ();

	virtual ~Configuration_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// возвращает информацию от текущей конфигурации
	Root::Info& info ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Root::Info m_info;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Root::Configuration
	// данные конфигруации
	virtual const Root::Info& get_info () const;
}; // class Configuration_i

} // namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_CONFIGURATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
