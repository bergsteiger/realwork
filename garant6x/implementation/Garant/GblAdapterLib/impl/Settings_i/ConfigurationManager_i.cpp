////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::ConfigurationManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i_factory.h"
#include "garantServer/src/Business/GblSettings/GblSettingsC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i_factory.h"
#include "garantServer/src/Business/GblLogging/Home/Client.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/SessionHelper.h"

//#UC START# *46076D82026B_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"
//#UC END# *46076D82026B_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *46076D82026B*
ConfigurationManager_i::LocalSettingsCheckResult ConfigurationManager_i::local_settings_check (
	long configuration_id
	, PropertyStringID_const property_id
	, KeysMap::const_iterator it
) const {
	if (it == m_keys.end ()) {
		return LSCR_UNCHANGED;
	}

	if (this->property_used_by_server (property_id)) {
		return LSCR_UNKNOWN;
	}

	switch (m_save_strategy) {
		case SSS_NOTSAVE:
			try {
				GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
				SettingsStorage::PropertyValue_var value = srv->get_property_value (
					configuration_id
					, (*it).second.id
					);	
				ValueID vid (configuration_id, (*it).second.id);
				ValuesMap::const_iterator vit = m_values.find (vid);
				if (vit != m_values.end ()) {
					return this->is_property_equal ((*vit).second, value.in ()) ? LSCR_UNCHANGED : LSCR_CHANGED;
				}
			} catch (GblSettings::PropertyValueNotDefined&) {
				return LSCR_UNCHANGED;
			} catch (GblSettings::DataBaseError&) {
				// Вообще-то не очень понятно чё тут делать.
				return LSCR_CHANGED;
			}
			GDS_ASSERT (false);
		case SSS_CACHE:
		{
			READ_GUARD (m_cached_settings_guard);
			if (
				m_data_for_server.find (ServerSettingData (configuration_id, (*it).second.id)) 
				!= m_data_for_server.end ()
			) {
				return LSCR_CHANGED;
			}
			return LSCR_UNKNOWN; // значение настройки может уже быть сброшено на сервер
		}
	}
	return LSCR_UNKNOWN;
}
//#UC END# *46076D82026B*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
size_t ConfigurationManager_i::Hasher::operator () (const ValueID& x) const {
	//#UC START# *46079B6002F7_4607BF6102C8_HASH*
	return x.configuration_id * 10000000 + x.property_id; 
	//#UC END# *46079B6002F7_4607BF6102C8_HASH*
}



bool ConfigurationManager_i::ValueID::operator < (const ValueID& y) const {
	//#UC START# *46079D150096_LESS*
	if (configuration_id < y.configuration_id) {
		return true;
	}
	if (configuration_id > y.configuration_id) {
		return false;
	}
	if (property_id < y.property_id) {
		return true;
	}
	return false;
	//#UC END# *46079D150096_LESS*
}

ConfigurationManager_i::ValueID::ValueID (long configuration_id_, long property_id_)
//#UC START# *46079D150096_INIT_CTOR_BASE_INIT*
	: configuration_id (configuration_id_)
	, property_id (property_id_)
//#UC END# *46079D150096_INIT_CTOR_BASE_INIT*
{
	//#UC START# *46079D150096_INIT_CTOR*
	//#UC END# *46079D150096_INIT_CTOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// настройка используется сервером, поэтому она должна быть передана на него.
bool ConfigurationManager_i::property_used_by_server (PropertyStringID_const property_id) {
	//#UC START# *48A946C201FD*
	// Настройки, которые должны быть прописаны на сервер сразу
	const std::string order_property_id = "Работа со списком/Начальная сортировка/Порядок";
	const std::string type_property_id = "Работа со списком/Начальная сортировка/Тип сортировки";

	if ((order_property_id == property_id) || (type_property_id == property_id)) {
		return true;
	}

	return false;
	//#UC END# *48A946C201FD*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConfigurationManager_i::ConfigurationManager_i ()
//#UC START# *45EEDBE30144_45F11C04001F_46076D82026B_BASE_INIT*
	: m_values_on_demand (false), m_reactor (0)
//#UC END# *45EEDBE30144_45F11C04001F_46076D82026B_BASE_INIT*
{
	//#UC START# *45EEDBE30144_45F11C04001F_46076D82026B_BODY*
	GDS_ASSERT (SessionHelper::instance()->get_is_session_active());
	
	// load key map from server
	try {
		GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
		GblSettings::DefinitionList_var list = srv->load_definitions ();
		CORBA::ULong length = list->length ();
		for (CORBA::ULong i = 0; i < length; ++i) {
			Property property_ (
				list[i].id
				, (list[i].definition.is_unique ? true : false)
				, (list[i].definition.is_constant ? true : false)
				, PropertyTypeTranslatorSingleton::instance ()->get (list[i].definition.type)
			);
			m_keys [list[i].definition.string_id.in ()] = property_;
		}
	} catch (GblSettings::DataBaseError&) {
		LOG_E (("%s: DataBaseError while retrieve definitions", GDS_CURRENT_FUNCTION));
	}

	GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
	try {
		m_active_configuration_id = srv->get_active_configuration ();
	} catch (GblSettings::ConfigurationsNotDefined&) {
		throw ConfigurationsNotDefined ();
	} catch (GblSettings::DataBaseError&) {
		LOG_E (("%s: DataBaseError while retrieve active configuration", GDS_CURRENT_FUNCTION));
	}

	// load configurations from server
	try {
		GblSettings::Configurations_var configurations = srv->get_configurations_list ();
		CORBA::ULong length = configurations->length ();
		m_configurations = new Configurations ();
		m_configurations.ptr ()->reserve (length);
		for (CORBA::ULong i = 0; i < length; ++i) {
			// Записываем в лог имя текущей конфигурации
			if (configurations [i].id == m_active_configuration_id) {
				try {	
					::GblLogging::add_event_with_any_data <const char*>(
							::GblLogging::LE_ACTIVE_CONFIGURATION
							, configurations [i].name.in ()
					);
				} catch (...) {
					GDS_ASSERT_MSG (false, (GDS_CURRENT_FUNCTION))
				}
			}

			GCI::IO::String_var name (GCI::IO::StringFactory::make (configurations [i].name.in ()));
			GCI::IO::String_var hint (GCI::IO::StringFactory::make (configurations [i].hint.in ()));
			Configuration_var configuration = 
				ConfigurationFactory::make (
					configurations [i].id
					, name.in ()
					, hint.in ()
					, (configurations [i].is_readonly ? true : false)
				);
			m_configurations->push_back (configuration);
		}
	} catch (GblSettings::DataBaseError&) {
		LOG_E (("%s: DataBaseError while retrieve configuration list", GDS_CURRENT_FUNCTION));
	}

	this->update_cache ();

	long delta = Core::ParamManagerFactory::get ().get_long (DELTA_OPTION_NAME.c_str (), DELTA_OPTION_VALUE);
	if (delta > 0) {
		m_store_timer.reset (new StoreSettingsToServer ());

		m_reactor = TAO_ORB_Core_instance ()->reactor ();
		GDS_ASSERT (m_reactor);

		m_reactor->schedule_timer (
			m_store_timer.get ()
			, this
			, ACE_Time_Value (delta) // через какое время стартовать
			, ACE_Time_Value (delta) // с какой дельтой отрабатывать
		);
	}

	if (delta > 0) {
		m_save_strategy = SSS_CACHE;
	} else if (!delta) {
		m_save_strategy = SSS_INTIME;
	} else {
		m_save_strategy = SSS_NOTSAVE;
	}
	//#UC END# *45EEDBE30144_45F11C04001F_46076D82026B_BODY*
}

ConfigurationManager_i::~ConfigurationManager_i () {
	//#UC START# *46076D82026B_DESTR_BODY*
	if (m_store_timer.get () && m_reactor) {
		m_reactor->cancel_timer ((ACE_Event_Handler*) m_store_timer.get ());
	}
	//#UC END# *46076D82026B_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить данные в кеш для отправки на сервер
void ConfigurationManager_i::add_data_to_server (
	GblSettings::Settings* srv
	, long configuration_id
	, long property_id
	, const SettingsStorage::PropertyValue& value
	, long long time
) {
	//#UC START# *488DD8380346*
	switch (m_save_strategy) {
		case SSS_NOTSAVE:
			return;
		case SSS_INTIME:
			srv->set_property_value (configuration_id, property_id, value, time);
			return;
		case SSS_CACHE:
		{
			ServerSettingData data (configuration_id, property_id, value, time);
			WRITE_GUARD (m_cached_settings_guard);
			CachedDataForServer::iterator it = m_data_for_server.find (data);
			if (it != m_data_for_server.end ()) {
				m_data_for_server.erase (it);
			}			
			m_data_for_server.insert (data);
			return;
		}
	}
	GDS_ASSERT (false && "not reached");
	//#UC END# *488DD8380346*
}

Configuration* ConfigurationManager_i::copy_configuration (long id) {
	//#UC START# *4607751E01A0*
	GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
	SettingsStorage::ConfigurationDescription_var description = srv->copy_configuration (id);
	GCI::IO::String_var description_name (GCI::IO::StringFactory::make (description->name.in ()));
	GCI::IO::String_var description_hint (GCI::IO::StringFactory::make (description->hint.in ()));

	Configuration_var configuration = ConfigurationFactory::make (
		description->id
		, description_name.in ()
		, description_hint.in ()
		, (description->is_readonly ? true : false)
	);
	m_configurations->push_back (configuration);	
	return configuration._retn ();
	//#UC END# *4607751E01A0*
}

// сбрасывает изменённые кешированные настройки на сервер
void ConfigurationManager_i::flush_settings_to_server () {
	//#UC START# *488DCBBF027C*
	WRITE_GUARD (m_cached_settings_guard);
	if (!m_data_for_server.empty ()) {
		GblSettings::PropertyItemsList list;
		size_t list_size = m_data_for_server.size (); 
		list.length (list_size);
		LOG_D (("%s: flushing settings to server (count is %d)", GDS_CURRENT_FUNCTION, list_size));
		GblSettings::PropertyItem item;
		size_t index = 0;
		for (
			CachedDataForServer::const_iterator it = m_data_for_server.begin ()
			; it != m_data_for_server.end ()
			; ++it
		) {
			item.configuration_id = it->conf_id;
			item.property_id = it->prop_id;
			item.value = it->prop_value;
			item.time = it->time;
			GDS_ASSERT (index < list_size);
			list[index++] = item;
		}
		ApplicationHelper::instance ()->get_cached_settings ()->set_property_value_list (list);

		m_data_for_server.clear ();
	}
	//#UC END# *488DCBBF027C*
}

bool ConfigurationManager_i::get_definition (PropertyStringID_const property_id, PropertyDefinition& definition) {
	//#UC START# *4607975C0123*
	KeysMap::const_iterator it = m_keys.find (property_id);
	if (it == m_keys.end ()) {
		return false;
	}
	definition = (*it).second.definition;
	return true;
	//#UC END# *4607975C0123*
}

SettingsStorage::PropertyValue* ConfigurationManager_i::get_property_value (
	long configuration_id
	, PropertyStringID_const property_id
	, PropertyType type
) {
	//#UC START# *4607974400A6*
	KeysMap::const_iterator kit = m_keys.find (property_id);
	
	if (kit == m_keys.end ()) {
		return 0;
	}
	
	if (type != (*kit).second.definition.type) {
		throw InvalidValueType ();
	}

	ValueID vid (configuration_id, (*kit).second.id);
	ValuesMap::const_iterator vit = m_values.find (vid);
	if (vit != m_values.end ()) {
		return &(m_values [vid]);
	}
	
	if (m_values_on_demand || configuration_id != this->get_active_id ()) {
		try {
			GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
			SettingsStorage::PropertyValue_var value = srv->get_property_value (configuration_id, (*kit).second.id);	
			return &(m_values [vid] = value.in ());
		} catch (GblSettings::PropertyValueNotDefined&) {
		} catch (GblSettings::DataBaseError&) {
			LOG_E ((
				"%s: DataBaseError while retrieve property [%s] for configuration [%d]"
				, GDS_CURRENT_FUNCTION
				, property_id
				, configuration_id
			));
		}
	}
	return 0;
	//#UC END# *4607974400A6*
}

bool ConfigurationManager_i::is_changed (long configuration_id, PropertyStringID_const property_id) const {
	//#UC START# *4607976D02A9*
	KeysMap::const_iterator it = m_keys.find (property_id);
	LocalSettingsCheckResult local_check_result = this->local_settings_check (configuration_id, property_id, it);

	switch (local_check_result) {
		case LSCR_CHANGED:
			return true;
		case LSCR_UNCHANGED:
			return false;
		case LSCR_UNKNOWN:
		{
			GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
			return srv->is_changed (configuration_id, (*it).second.id) ? true : false;
		}
		default:
			GDS_ASSERT (false && "unknown value of LocalSettingsCheckResult");
	}
	GDS_ASSERT (false && "unreachable point");
	return true;
	//#UC END# *4607976D02A9*
}

bool ConfigurationManager_i::is_changed_set (
	long configuration_id
	, const PropertyStringIDList& property_id_list
) const {
	//#UC START# *497D70F9003F*
	std::vector <SettingsStorage::PropertyID>	list;
	list.reserve (property_id_list.size ());
	for (size_t i = 0; i < property_id_list.size (); ++i) {
		KeysMap::const_iterator it = m_keys.find (property_id_list [i]->get_data ());
		LocalSettingsCheckResult local_check_result = 
			this->local_settings_check (
				configuration_id
				, property_id_list [i]->get_data ()
				, it
			);

		switch (local_check_result) {
			case LSCR_CHANGED:
				return true;
			case LSCR_UNCHANGED:
				break;
			case LSCR_UNKNOWN:
				list.push_back ((*it).second.id);
				break;
			default:
				GDS_ASSERT (false && "unknown value of LocalSettingsCheckResult");
		}
	}
		
	if (list.empty ()) {
		return false;
	}
	SettingsStorage::PropertyID* buf = GblSettings::ExplicitProperties::allocbuf (list.size ());
	memcpy (buf, &*(list.begin ()), list.size () * sizeof (SettingsStorage::PropertyID));
	GblSettings::ExplicitProperties property_list (list.size (), list.size (), buf, 1);

	GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
	return srv->is_changed_set (configuration_id, property_list) ? true : false;
	//#UC END# *497D70F9003F*
}

bool ConfigurationManager_i::is_exist (long configuration_id, PropertyStringID_const property_id) const {
	//#UC START# *4898566902BB*
	KeysMap::const_iterator it = m_keys.find (property_id);
	return (it != m_keys.end ());
	//#UC END# *4898566902BB*
}

bool ConfigurationManager_i::is_property_equal (
	const SettingsStorage::PropertyValue& first
	, const SettingsStorage::PropertyValue& second
) const {
	//#UC START# *46079A7703B3*
	if (first._d () != second._d ()) {
		return false;
	}

	switch (first._d ()) {
		case SettingsStorage::VT_LONG    : return first.long_value () == second.long_value ();
		case SettingsStorage::VT_ULONG   : return first.ulong_value () == second.ulong_value ();
		case SettingsStorage::VT_BOOLEAN : return first.bool_value () == second.bool_value ();
		case SettingsStorage::VT_INT64   : return first.int64_value () == second.int64_value ();
		case SettingsStorage::VT_STRING  : return !strcmp (first.string_value (), second.string_value ());
	}
	return false;
	//#UC END# *46079A7703B3*
}

void ConfigurationManager_i::restore_default (long configuration_id, PropertyStringID_const property_id) {
	//#UC START# *4607978E0355*
	KeysMap::const_iterator it = m_keys.find (property_id);
	if (it == m_keys.end ()) {
		throw CanNotFindData ();
	}
	this->flush_settings_to_server ();
	
	ApplicationHelper::instance ()->get_cached_settings ()->restore_default_value (configuration_id, (*it).second.id);
	this->update_cache (configuration_id, (*it).second.id);
	//#UC END# *4607978E0355*
}

void ConfigurationManager_i::save_as_default (long configuration_id, PropertyStringID_const property_id) {
	//#UC START# *4607977D0067*
	KeysMap::const_iterator it = m_keys.find (property_id);
	if (it == m_keys.end ()) {
		throw CanNotFindData ();
	}
	this->flush_settings_to_server (); // $121161577
	
	ApplicationHelper::instance ()->get_cached_settings ()->save_as_default_value (configuration_id, (*it).second.id);
	this->update_cache (configuration_id, (*it).second.id);
	//#UC END# *4607977D0067*
}

void ConfigurationManager_i::set_property_value (
	long configuration_id
	, PropertyStringID_const property_id
	, const SettingsStorage::PropertyValue& value
) {
	//#UC START# *460783EB02C8*
	LARGE_INTEGER time;
	::QueryPerformanceCounter (&time);
	bool write_to_server_intime =  ConfigurationManager_i::property_used_by_server (property_id);

	KeysMap::const_iterator it = m_keys.find (property_id);

	if (it == m_keys.end ()) {
		GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
		Property property;
		property.definition.type = PropertyTypeTranslatorSingleton::instance ()->get (value._d ());
		property.id = srv->create (property_id, value._d ());
		if (write_to_server_intime) {
			srv->set_property_value (configuration_id, property.id, value, time.QuadPart);
		} else {
			this->add_data_to_server (srv, configuration_id, property.id, value, time.QuadPart);
		}
		m_keys [property_id] = property;
		m_values [ValueID (configuration_id, property.id)] = value;
		return;
	} 
	
	if ((*it).second.definition.is_constant) {
		throw ConstantModify ();
	}

	if (PropertyTypeTranslatorSingleton::instance ()->get (value._d ()) != (*it).second.definition.type) {
		throw InvalidValueType ();
	}

	ValuesMap::const_iterator vit = m_values.find (ValueID (configuration_id, (*it).second.id));
	if (vit != m_values.end () && this->is_property_equal ((*vit).second, value)) {
		return;
	}

	m_values [ValueID (configuration_id, (*it).second.id)] = value;

	GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
	
	if ((*it).second.definition.is_unique) {
		for (size_t i = 0; i < m_configurations->size(); ++i) {
			Configuration_var conf = (*m_configurations) [i];
			if (write_to_server_intime) {
				srv->set_property_value (conf->get_id (), (*it).second.id, value, time.QuadPart);
			} else {
				this->add_data_to_server (srv, conf->get_id (), (*it).second.id, value, time.QuadPart);
			}
		}
	} else {
		if (write_to_server_intime) {
			srv->set_property_value (configuration_id, (*it).second.id, value, time.QuadPart);
		} else {
			this->add_data_to_server (srv, configuration_id, (*it).second.id, value, time.QuadPart);
		}
	}
	//#UC END# *460783EB02C8*
}

void ConfigurationManager_i::update_cache () {
	//#UC START# *4607979A0132*
	m_values.clear ();
	this->flush_settings_to_server ();
	
	if (m_values_on_demand) {
		return;
	}
	
	GDS_ASSERT (m_active_configuration_id);
	
	try {
		GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
		GblSettings::ValueList_var list = srv->load_values (m_active_configuration_id);
		CORBA::ULong length = list->length ();
		for (CORBA::ULong i = 0; i < length; ++i) {
			m_values [ValueID (m_active_configuration_id, list[i].id)] = list[i].value;
		}	
	} catch (GblSettings::DataBaseError&) {
		LOG_E (("%s: DataBaseError while retrieve value list", GDS_CURRENT_FUNCTION));
	}
	//#UC END# *4607979A0132*
}

void ConfigurationManager_i::update_cache (long configuration_id, long property_id) {
	//#UC START# *4614E3CD031C*
	ValueID vid (configuration_id, property_id);
	ValuesMap::iterator vit = m_values.find (vid);
	if (vit != m_values.end ()) {
		m_values.erase (vit);
	}
	this->flush_settings_to_server ();
	
	if (m_values_on_demand) {
		return;
	}

	try {
		GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
		SettingsStorage::PropertyValue_var value = srv->get_property_value (configuration_id, property_id);
		m_values [vid] = value.in ();
	} catch (GblSettings::PropertyValueNotDefined&) {
	} catch (GblSettings::DataBaseError&) {
		LOG_E (("%s: DataBaseError while retrieve value list", GDS_CURRENT_FUNCTION));
	}
	//#UC END# *4614E3CD031C*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const ConfigurationManager_i::KeysMap& ConfigurationManager_i::get_keys () const {
	//#UC START# *46079C6F020D_GET_ACCESSOR*
	return m_keys;
	//#UC END# *46079C6F020D_GET_ACCESSOR*
}

const ConfigurationManager_i::ValuesMap& ConfigurationManager_i::get_values () const {
	//#UC START# *4607BF370161_GET_ACCESSOR*
	return m_values;
	//#UC END# *4607BF370161_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ConfigurationManager
const Configurations& ConfigurationManager_i::get_configurations () const {
	//#UC START# *45EEDCA2033C_46076D82026B_GET*
	return *m_configurations;
	//#UC END# *45EEDCA2033C_46076D82026B_GET*
}

// implemented method from ConfigurationManager
DefaultValuesChangesIndicator* ConfigurationManager_i::default_values_update_check () {
	//#UC START# *45EEDBE3014A_46076D82026B*
	try {
		
		GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
		GblSettings::DefaultValuesChangesIndicator_var indicator = srv->default_values_update_check ();

		GCI::IO::String_var configuration_name (GCI::IO::StringFactory::make (indicator->configuration.name.in ()));
		GCI::IO::String_var configuration_hint (GCI::IO::StringFactory::make (indicator->configuration.hint.in ()));
		Configuration_var configuration = ConfigurationFactory::make (
			indicator->configuration.id
			, configuration_name.in ()
			, configuration_hint.in ()
			, (indicator->configuration.is_readonly ? true : false)
		);

		switch (indicator->state) {
			case NO_CHANGES                                     : configuration.release ();
			                                                      break;
			case UPDATED_WITH_COPY_ACTIVE_CONFIGURATION         : m_configurations->push_back (configuration);
			                                                      this->update_cache ();
			                                                      break;
			case UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION : this->set_active (configuration.in ());
			                                                      configuration = this->get_active ();
 			                                                      break;
			default: GDS_ASSERT (false);
		}

		return DefaultValuesChangesIndicatorFactory::make (
				DefaultValuesChangesStateTranslatorSingleton::instance ()->get (indicator->state)
				, configuration.in ()
		);

	} catch (GblSettings::DataBaseError&) {
		LOG_E (("%s: DataBaseError while check update of default values", GDS_CURRENT_FUNCTION));
	}
	return 0;
	//#UC END# *45EEDBE3014A_46076D82026B*
}

// implemented method from ConfigurationManager
// возвращает активную конфигурацию
Configuration* ConfigurationManager_i::get_active () {
	//#UC START# *45EEDBE30149_46076D82026B*
	for (size_t i = 0; i < m_configurations->size (); ++i) {
		Configuration_var conf = (*m_configurations) [i];
		if (conf->get_id () == m_active_configuration_id) {			
			return conf._sretn ();
		}
	}			
	GDS_ASSERT (false);
	return 0; // NOT REACHED!
	//#UC END# *45EEDBE30149_46076D82026B*
}

// implemented method from ConfigurationManager
// возвращает идентификатор активной конфигурации
long ConfigurationManager_i::get_active_id () const {
	//#UC START# *47875651024E_46076D82026B*
	return m_active_configuration_id;
	//#UC END# *47875651024E_46076D82026B*
}

// implemented method from ConfigurationManager
// метод дёргается при выходе из системы
void ConfigurationManager_i::logout () {
	//#UC START# *488EFAE7008A_46076D82026B*
	this->flush_settings_to_server ();
	//#UC END# *488EFAE7008A_46076D82026B*
}

// implemented method from ConfigurationManager
// Удаляет заданную конфигурацию. В случае попытки удалить активную конфигурацию возбуждает
// исключение ConfigurationIsActiveNow
void ConfigurationManager_i::remove (
	const Configuration* configuration
) /*throw (
	ConstantModify
	, ConfigurationIsActiveNow
)*/ {
	//#UC START# *45EEDBE30147_46076D82026B*
	unsigned long id = configuration->get_id ();

	if (id == m_active_configuration_id) {
		throw ConfigurationIsActiveNow ();
	}
	
	if (configuration->get_is_readonly ()) {
		throw ConstantModify ();
	}
	
	// сбрасываем на сервер несохранённые настройки
	this->flush_settings_to_server ();

	for (Configurations::iterator i = m_configurations->begin (); i != m_configurations->end (); ++i) {
		if ((*i)->get_id () == id) {
			m_configurations->erase (i); 
			break;	
		}
	}			

	GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
	srv->remove_configuration (id);
	//#UC END# *45EEDBE30147_46076D82026B*
}

// implemented method from ConfigurationManager
// Устанавливает заданную конфигурацией активной (текущей для интерфейса Settings, полученного
// через Common)
void ConfigurationManager_i::set_active (const Configuration* configuration) {
	//#UC START# *45EEDBE30145_46076D82026B*
	m_active_configuration_id = configuration->get_id ();
	GblSettings::Settings_ptr srv = ApplicationHelper::instance ()->get_cached_settings ();
	srv->set_active_configuration (m_active_configuration_id);
	try {
		Configuration_var active_configuration = this->get_active ();
		GCI::IO::String_var name = active_configuration->get_name ();
		::GblLogging::add_event_with_any_data <const char*>(
				::GblLogging::LE_ACTIVE_CONFIGURATION
				, name->get_data ()
		);
	} catch (...) {
		GDS_ASSERT_MSG (false, (GDS_CURRENT_FUNCTION))
	}

	this->update_cache ();
	//#UC END# *45EEDBE30145_46076D82026B*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

