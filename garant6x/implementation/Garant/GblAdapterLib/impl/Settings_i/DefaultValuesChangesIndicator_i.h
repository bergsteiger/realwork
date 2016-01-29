////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::DefaultValuesChangesIndicator_i
// Заголовок реализации класса серванта для интерфеса DefaultValuesChangesIndicator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_DEFAULTVALUESCHANGESINDICATOR_I_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_DEFAULTVALUESCHANGESINDICATOR_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"

namespace GblAdapterLib {

class DefaultValuesChangesIndicator_i; // self forward Var
typedef ::Core::Var<DefaultValuesChangesIndicator_i> DefaultValuesChangesIndicator_i_var;
typedef ::Core::Var<const DefaultValuesChangesIndicator_i> DefaultValuesChangesIndicator_i_cvar;

class DefaultValuesChangesIndicator_i_factory;

class DefaultValuesChangesIndicator_i:
	virtual public DefaultValuesChangesIndicator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DefaultValuesChangesIndicator_i)
	friend class DefaultValuesChangesIndicator_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DefaultValuesChangesIndicator_i (DefaultValuesChangesState state, const Configuration* configuration);

	virtual ~DefaultValuesChangesIndicator_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Configuration_var m_configuration;

	DefaultValuesChangesState m_state;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual const Configuration* get_configuration () const;

	virtual DefaultValuesChangesState get_state () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DefaultValuesChangesIndicator
	virtual Configuration* get_configuration ();
}; // class DefaultValuesChangesIndicator_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_DEFAULTVALUESCHANGESINDICATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
