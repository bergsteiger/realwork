////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::Configuration_i
//
// Реализация интерфейса, обеспечивающего работу с конкретной конфигурацией, является элементом
// списка конфигураций.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Configuration_i::Configuration_i (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly)
//#UC START# *45EEDBE3014C_45F11C98009C_45F11B3D03EC_BASE_INIT*
	: m_id (id)
	, m_is_readonly (readonly)																				  
//#UC END# *45EEDBE3014C_45F11C98009C_45F11B3D03EC_BASE_INIT*
{
	//#UC START# *45EEDBE3014C_45F11C98009C_45F11B3D03EC_BODY*
	m_name = const_cast<GCI::IO::String*> (Core::IObject::_duplicate (name));
	m_hint = const_cast<GCI::IO::String*> (Core::IObject::_duplicate (hint));
	//#UC END# *45EEDBE3014C_45F11C98009C_45F11B3D03EC_BODY*
}

Configuration_i::~Configuration_i () {
	//#UC START# *45F11B3D03EC_DESTR_BODY*
	//#UC END# *45F11B3D03EC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Configuration
// возвращает копию конфигурации
Configuration* Configuration_i::copy () const {
	//#UC START# *45EEDBE3014F_45F11B3D03EC*
	return ConfigurationManager_iServantFactory::make ()->copy_configuration (m_id);
	//#UC END# *45EEDBE3014F_45F11B3D03EC*
}

// implemented method from Configuration
SettingsManager* Configuration_i::get_settings () const {
	//#UC START# *45EEDBE30150_45F11B3D03EC*
	return SettingsManager_iServantFactory::make (new SettingsManager_i::FixedConfigurationSelector (m_id));
	//#UC END# *45EEDBE30150_45F11B3D03EC*
}

// implemented method from Configuration
// Комментарий или пояснение к конфигурации
const GCI::IO::String* Configuration_i::get_hint () const {
	//#UC START# *45EEDBE30152_45F11B3D03EC_GET*
	return m_hint._sretn ();
	//#UC END# *45EEDBE30152_45F11B3D03EC_GET*
}

GCI::IO::String* Configuration_i::get_hint () {
	return const_cast<GCI::IO::String*>(((const Configuration_i*)this)->get_hint ());
}

void Configuration_i::set_hint (GCI::IO::String* hint) {
	//#UC START# *45EEDBE30152_45F11B3D03EC_SET*
	m_hint->reset (hint->get_data());
	ApplicationHelper::instance ()->get_cached_settings ()->set_configuration_hint (m_id, m_hint->get_data ());
	//#UC END# *45EEDBE30152_45F11B3D03EC_SET*
}

// implemented method from Configuration
unsigned long Configuration_i::get_id () const {
	//#UC START# *45EEDBE30155_45F11B3D03EC_GET*
	return m_id;
	//#UC END# *45EEDBE30155_45F11B3D03EC_GET*
}

// implemented method from Configuration
// определяет возможность изменения значений по умолчанию для конфигурации
bool Configuration_i::get_is_readonly () const {
	//#UC START# *45EEDBE30154_45F11B3D03EC_GET*
	return m_is_readonly;
	//#UC END# *45EEDBE30154_45F11B3D03EC_GET*
}

// implemented method from Configuration
// Имя конфигурации
const GCI::IO::String* Configuration_i::get_name () const {
	//#UC START# *45EEDBE30151_45F11B3D03EC_GET*
	return m_name._sretn ();
	//#UC END# *45EEDBE30151_45F11B3D03EC_GET*
}

GCI::IO::String* Configuration_i::get_name () {
	return const_cast<GCI::IO::String*>(((const Configuration_i*)this)->get_name ());
}

void Configuration_i::set_name (GCI::IO::String* name) {
	//#UC START# *45EEDBE30151_45F11B3D03EC_SET*
	m_name->reset (name->get_data ());
	ApplicationHelper::instance ()->get_cached_settings ()->set_configuration_name (m_id, m_name->get_data ());
	//#UC END# *45EEDBE30151_45F11B3D03EC_SET*
}

// implemented method from Configuration
// устанавливает для всех свойств конфигурации начальные значения
void Configuration_i::restore_default_values () const {
	//#UC START# *45EEDBE3014D_45F11B3D03EC*
	ConfigurationManager_iServantFactory::make ()->flush_settings_to_server ();
	ApplicationHelper::instance ()->get_cached_settings ()->restore_configuration (m_id);
	ConfigurationManager_iServantFactory::make ()->update_cache ();
	//#UC END# *45EEDBE3014D_45F11B3D03EC*
}

// implemented method from Configuration
// записывает текущие значения для всех свойств в качестве значений по умолчанию
void Configuration_i::save_values_as_default () const {
	//#UC START# *45EEDBE3014E_45F11B3D03EC*
	ApplicationHelper::instance ()->get_cached_settings ()->save_values_as_default (m_id);
	ConfigurationManager_iServantFactory::make ()->update_cache ();
	//#UC END# *45EEDBE3014E_45F11B3D03EC*
}

// implemented method from Configuration
ConfigurationType Configuration_i::get_type () const {
	//#UC START# *45EEDBE30153_45F11B3D03EC_GET*
	switch (this->get_id ()) {
		case 1 : 
		case 2 : return CT_STANDARD;
		default: return CT_USER;
	};
	//#UC END# *45EEDBE30153_45F11B3D03EC_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

