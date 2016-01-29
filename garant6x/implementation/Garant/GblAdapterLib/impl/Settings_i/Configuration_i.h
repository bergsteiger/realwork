////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::Configuration_i
// Заголовок реализации класса серванта для интерфеса Configuration
//
// Реализация интерфейса, обеспечивающего работу с конкретной конфигурацией, является элементом
// списка конфигураций.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATION_I_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"

namespace GblAdapterLib {

class Configuration_i; // self forward Var
typedef ::Core::Var<Configuration_i> Configuration_i_var;
typedef ::Core::Var<const Configuration_i> Configuration_i_cvar;

class Configuration_i_factory;

// Реализация интерфейса, обеспечивающего работу с конкретной конфигурацией, является элементом
// списка конфигураций.
class Configuration_i:
	virtual public Configuration
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Configuration_i)
	friend class Configuration_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Configuration_i (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly);

	virtual ~Configuration_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_hint;

	long m_id;

	bool m_is_readonly;

	GCI::IO::String_var m_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Configuration
	// возвращает копию конфигурации
	virtual Configuration* copy () const;

	// implemented method from Configuration
	virtual SettingsManager* get_settings () const;

	// implemented method from Configuration
	// Комментарий или пояснение к конфигурации
	virtual const GCI::IO::String* get_hint () const;
	virtual GCI::IO::String* get_hint ();

	virtual void set_hint (GCI::IO::String* hint);

	// implemented method from Configuration
	virtual unsigned long get_id () const;

	// implemented method from Configuration
	// определяет возможность изменения значений по умолчанию для конфигурации
	virtual bool get_is_readonly () const;

	// implemented method from Configuration
	// Имя конфигурации
	virtual const GCI::IO::String* get_name () const;
	virtual GCI::IO::String* get_name ();

	virtual void set_name (GCI::IO::String* name);

	// implemented method from Configuration
	// устанавливает для всех свойств конфигурации начальные значения
	virtual void restore_default_values () const;

	// implemented method from Configuration
	// записывает текущие значения для всех свойств в качестве значений по умолчанию
	virtual void save_values_as_default () const;

	// implemented method from Configuration
	virtual ConfigurationType get_type () const;
}; // class Configuration_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
