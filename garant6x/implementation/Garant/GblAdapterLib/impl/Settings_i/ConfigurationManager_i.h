////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::ConfigurationManager_i
// Заголовок реализации класса серванта для интерфеса ConfigurationManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATIONMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATIONMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "shared/Core/data/unsorted_containers.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"
#include "garantServer/src/Business/GblSettings/SettingsStorageC.h"
#include "garantServer/src/Business/GblSettings/GblSettingsC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/StoreSettingsToServer.h"
#include "ace/Reactor.h"

//#UC START# *46076D82026B_CUSTOM_INCLUDES*
//#UC END# *46076D82026B_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class StoreSettingsToServer;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ConfigurationManager_i; // self forward Var
typedef ::Core::Var<ConfigurationManager_i> ConfigurationManager_i_var;
typedef ::Core::Var<const ConfigurationManager_i> ConfigurationManager_i_cvar;

class ConfigurationManager_i_factory;

class ConfigurationManager_i:
	virtual public ConfigurationManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ConfigurationManager_i)
	friend class ConfigurationManager_i_factory; // self factory
	friend class StoreSettingsToServer; // defined friend

	// singleton declaration
	typedef ACE_Singleton <ConfigurationManager_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConfigurationManager_i, ACE_SYNCH_RECURSIVE_MUTEX>;


//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	struct ValueID;
	struct Hasher {
		size_t operator () (const ValueID& x) const;

	};

	struct Property {
		long id;
		PropertyDefinition definition;
		//#UC START# *46079C9A01A0*
		Property () : id (0) {
			definition.is_unique = false;
			definition.is_constant = false;
			definition.type = PT_LONG;
		}
		Property (long id__, bool is_unique, bool is_constant, PropertyType type) 
			: id (id__) {
			definition.is_unique = is_unique;
			definition.is_constant = is_constant;
			definition.type = type;
		}
		//#UC END# *46079C9A01A0*
	};

	struct ValueID {
		long configuration_id;
		long property_id;

		ValueID (long configuration_id_, long property_id_);
		bool operator < (const ValueID& y) const;
		//#UC START# *46079D150096*
		bool operator == (const ValueID& id) const {
			return configuration_id == id.configuration_id && property_id == id.property_id;
		}
		//#UC END# *46079D150096*
	};

	typedef boost::unordered_map <std::string
		, Property> KeysMap;

	typedef boost::unordered_map <const ValueID
		, SettingsStorage::PropertyValue
		, Hasher> ValuesMap;


	class PropertyTypeTranslator : 
		public Core::UnsortedTypeConverter<SettingsStorage::TypeOfValue, PropertyType> {
		protected:
			void fill_array () {
				//#UC START# *4608D64E00E4_FILL_ARRAY_IMPLEMENTATION*
				this->add (SettingsStorage::VT_LONG, PT_LONG);
				this->add (SettingsStorage::VT_BOOLEAN, PT_BOOLEAN);
				this->add (SettingsStorage::VT_INT64, PT_INT64);
				this->add (SettingsStorage::VT_ULONG, PT_ULONG);
				this->add (SettingsStorage::VT_STRING, PT_STRING);
				//#UC END# *4608D64E00E4_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class PropertyTypeTranslator

	typedef ACE_Singleton<PropertyTypeTranslator, ACE_SYNCH_NULL_MUTEX> PropertyTypeTranslatorSingleton;


	class DefaultValuesChangesStateTranslator : 
		public Core::UnsortedTypeConverter<GblSettings::DefaultValuesChangesState, DefaultValuesChangesState> {
		protected:
			void fill_array () {
				//#UC START# *4608DA14025B_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblSettings::NO_CHANGES, NO_CHANGES);
			this->add (GblSettings::UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, UPDATED_WITH_COPY_ACTIVE_CONFIGURATION);
			this->add (
				GblSettings::UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION
				, UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION
				);
				//#UC END# *4608DA14025B_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class DefaultValuesChangesStateTranslator

	typedef ACE_Singleton<DefaultValuesChangesStateTranslator, ACE_SYNCH_NULL_MUTEX> DefaultValuesChangesStateTranslatorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// настройка используется сервером, поэтому она должна быть передана на него.
	static bool property_used_by_server (PropertyStringID_const property_id);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConfigurationManager_i ();

	virtual ~ConfigurationManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual Configuration* copy_configuration (long id);

	// сбрасывает изменённые кешированные настройки на сервер
	virtual void flush_settings_to_server ();

	virtual bool get_definition (PropertyStringID_const property_id, PropertyDefinition& definition);

	virtual SettingsStorage::PropertyValue* get_property_value (
		long configuration_id
		, PropertyStringID_const property_id
		, PropertyType type
	);

	virtual bool is_changed (long configuration_id, PropertyStringID_const property_id) const;

	virtual bool is_changed_set (long configuration_id, const PropertyStringIDList& property_id_list) const;

	virtual bool is_exist (long configuration_id, PropertyStringID_const property_id) const;

	virtual void restore_default (long configuration_id, PropertyStringID_const property_id);

	virtual void save_as_default (long configuration_id, PropertyStringID_const property_id);

	virtual void set_property_value (
		long configuration_id
		, PropertyStringID_const property_id
		, const SettingsStorage::PropertyValue& value
	);

	virtual void update_cache ();

	virtual void update_cache (long configuration_id, long property_id);

private:
	// добавить данные в кеш для отправки на сервер
	virtual void add_data_to_server (
		GblSettings::Settings* srv
		, long configuration_id
		, long property_id
		, const SettingsStorage::PropertyValue& value
		, long long time
	);

	virtual bool is_property_equal (
		const SettingsStorage::PropertyValue& first
		, const SettingsStorage::PropertyValue& second
	) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	long m_active_configuration_id;

	Core::Box<Configurations> m_configurations;

	// изменённые настройки
	CachedDataForServer m_data_for_server;

	KeysMap m_keys;

	ACE_Reactor* m_reactor;

	// cтратегия сохранения настроек на сервер
	SettingsSaveStrategy m_save_strategy;

	std::auto_ptr<StoreSettingsToServer> m_store_timer;

	ValuesMap m_values;

	bool m_values_on_demand;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const KeysMap& get_keys () const;

	virtual const ValuesMap& get_values () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ConfigurationManager
	virtual const Configurations& get_configurations () const;

	// implemented method from ConfigurationManager
	virtual DefaultValuesChangesIndicator* default_values_update_check ();

	// implemented method from ConfigurationManager
	// возвращает активную конфигурацию
	virtual Configuration* get_active ();

	// implemented method from ConfigurationManager
	// возвращает идентификатор активной конфигурации
	virtual long get_active_id () const;

	// implemented method from ConfigurationManager
	// метод дёргается при выходе из системы
	virtual void logout ();

	// implemented method from ConfigurationManager
	// Удаляет заданную конфигурацию. В случае попытки удалить активную конфигурацию возбуждает
	// исключение ConfigurationIsActiveNow
	virtual void remove (const Configuration* configuration) /*throw (ConstantModify, ConfigurationIsActiveNow)*/;

	// implemented method from ConfigurationManager
	// Устанавливает заданную конфигурацией активной (текущей для интерфейса Settings, полученного
	// через Common)
	virtual void set_active (const Configuration* configuration);

//#UC START# *46076D82026B*
	mutable Core::RWMutex m_cached_settings_guard;

	enum LocalSettingsCheckResult {
		LSCR_UNKNOWN,
		LSCR_CHANGED,
		LSCR_UNCHANGED
	};

	LocalSettingsCheckResult local_settings_check (
		long configuration_id
		, PropertyStringID_const property_id
		, KeysMap::const_iterator it
	) const;
//#UC END# *46076D82026B*
}; // class ConfigurationManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATIONMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
