////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Settings/Settings_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"

namespace GblAdapterLib {

class PropertyStringIDList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (PropertyStringIDList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	PropertyStringIDList_tie ();

	typedef ::Core::PoolObjectManager<PropertyStringIDList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PropertyStringIDList_tie> Pool;
	friend class ::Core::PoolObjectManager<PropertyStringIDList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const PropertyStringIDList_tie* obj, PropertyStringIDList*& ret_);

	static void make_tie (PropertyStringIDList* obj, PropertyStringIDList_tie*& ret_);
	
	static void make_tie (const PropertyStringIDList& obj, PropertyStringIDList_tie*& ret_);

	static void make_tie (const PropertyStringIDList& obj, PropertyStringIDList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (PropertyStringIDList* obj, PropertyStringIDList_tie*& ret_);

	PropertyStringIDList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const GCI::IO::IString_tie* item);
	virtual size_t __stdcall add (const GCI::IO::IString_tie* item);
	virtual size_t __stdcall insert (size_t index, const GCI::IO::IString_tie* item);
};

class IBaseSettingsManager_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall get_bool_4AC4990B0238 (
		const PropertyStringID id
		, bool& value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual bool __stdcall get_int64_4AC4990F037A (
		const PropertyStringID id
		, long long& value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual bool __stdcall get_long_4AC49912024A (
		const PropertyStringID id
		, long& value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual bool __stdcall get_string_4AC499150301 (
		const PropertyStringID id
		, GCI::IO::IString_tie*& value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual bool __stdcall get_ulong_4AC49919002B (
		const PropertyStringID id
		, unsigned long& value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual bool __stdcall is_exist_4AC4993302A8 (
		const PropertyStringID id
	) const = 0;

	virtual void __stdcall set_bool_4AC4991C01E1 (
		const PropertyStringID id
		, bool value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual void __stdcall set_int64_4AC4991F02F1 (
		const PropertyStringID id
		, long long value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual void __stdcall set_long_4AC499220301 (
		const PropertyStringID id
		, long value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual void __stdcall set_string_4AC4992601BC (
		const PropertyStringID id
		, const char* value
	) /*throw (InvalidValueType_tie)*/ = 0;

	virtual void __stdcall set_ulong_4AC499290308 (
		const PropertyStringID id
		, unsigned long value
	) /*throw (InvalidValueType_tie)*/ = 0;
};

class __declspec (dllexport) BaseSettingsManager_tie: public IBaseSettingsManager_tie {
	SET_OBJECT_COUNTER (BaseSettingsManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	BaseSettingsManager_tie ();

	typedef ::Core::PoolObjectManager<BaseSettingsManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<BaseSettingsManager_tie> Pool;
	friend class ::Core::PoolObjectManager<BaseSettingsManager_tie>;
	typedef ::Core::IidMapRegistrator<BaseSettingsManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBaseSettingsManager_tie* obj, BaseSettingsManager*& ret_, bool interface_addref = false);

	static void make_tie (const BaseSettingsManager* obj, IBaseSettingsManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const BaseSettingsManager& obj, IBaseSettingsManager_tie*& ret_, const Core::TIEBase* owner);

	BaseSettingsManager* m_impl;

protected:
	virtual bool __stdcall get_bool_4AC4990B0238 (
		const PropertyStringID id
		, bool& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_int64_4AC4990F037A (
		const PropertyStringID id
		, long long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_long_4AC49912024A (
		const PropertyStringID id
		, long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_string_4AC499150301 (
		const PropertyStringID id
		, GCI::IO::IString_tie*& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_ulong_4AC49919002B (
		const PropertyStringID id
		, unsigned long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall is_exist_4AC4993302A8 (
		const PropertyStringID id
	) const;

	virtual void __stdcall set_bool_4AC4991C01E1 (
		const PropertyStringID id
		, bool value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_int64_4AC4991F02F1 (
		const PropertyStringID id
		, long long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_long_4AC499220301 (
		const PropertyStringID id
		, long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_string_4AC4992601BC (
		const PropertyStringID id
		, const char* value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_ulong_4AC499290308 (
		const PropertyStringID id
		, unsigned long value
	) /*throw (InvalidValueType_tie)*/;
};

class ISettingsManager_tie: public IBaseSettingsManager_tie {
public:
	virtual bool __stdcall get_definition_45EEDBE3011E (
		const PropertyStringID id
		, PropertyDefinition& definition
	) const = 0;

	virtual bool __stdcall is_changed_45EEDBE3013F (
		const PropertyStringID id
	) const = 0;

	virtual bool __stdcall is_changed_set_4979D8CA0243 (
		const PropertyStringIDList_tie* id_list
	) const = 0;

	virtual void __stdcall restore_default_45EEDBE3011A (
		const PropertyStringID id
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall save_as_default_45EEDBE3011C (
		const PropertyStringID id
	) const /*throw (CanNotFindData_tie)*/ = 0;
};

class __declspec (dllexport) SettingsManager_tie: public ISettingsManager_tie {
	SET_OBJECT_COUNTER (SettingsManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	SettingsManager_tie ();

	typedef ::Core::PoolObjectManager<SettingsManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SettingsManager_tie> Pool;
	friend class ::Core::PoolObjectManager<SettingsManager_tie>;
	typedef ::Core::IidMapRegistrator<SettingsManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISettingsManager_tie* obj, SettingsManager*& ret_, bool interface_addref = false);

	static void make_tie (const SettingsManager* obj, ISettingsManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const SettingsManager& obj, ISettingsManager_tie*& ret_, const Core::TIEBase* owner);

	SettingsManager* m_impl;

protected:
	virtual bool __stdcall get_bool_4AC4990B0238 (
		const PropertyStringID id
		, bool& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_int64_4AC4990F037A (
		const PropertyStringID id
		, long long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_long_4AC49912024A (
		const PropertyStringID id
		, long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_string_4AC499150301 (
		const PropertyStringID id
		, GCI::IO::IString_tie*& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_ulong_4AC49919002B (
		const PropertyStringID id
		, unsigned long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_bool_4AC4991C01E1 (
		const PropertyStringID id
		, bool value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_int64_4AC4991F02F1 (
		const PropertyStringID id
		, long long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_long_4AC499220301 (
		const PropertyStringID id
		, long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_string_4AC4992601BC (
		const PropertyStringID id
		, const char* value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_ulong_4AC499290308 (
		const PropertyStringID id
		, unsigned long value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall is_exist_4AC4993302A8 (
		const PropertyStringID id
	) const;
	virtual bool __stdcall get_definition_45EEDBE3011E (
		const PropertyStringID id
		, PropertyDefinition& definition
	) const;

	virtual bool __stdcall is_changed_45EEDBE3013F (
		const PropertyStringID id
	) const;

	virtual bool __stdcall is_changed_set_4979D8CA0243 (
		const PropertyStringIDList_tie* id_list
	) const;

	virtual void __stdcall restore_default_45EEDBE3011A (
		const PropertyStringID id
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall save_as_default_45EEDBE3011C (
		const PropertyStringID id
	) const /*throw (CanNotFindData_tie)*/;
};

class IConfiguration_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall copy_45EEDBE3014F (
		IConfiguration_tie*& ret_
	) const = 0;

	virtual void __stdcall get_settings_45EEDBE30150 (
		ISettingsManager_tie*& ret_
	) const = 0;


	virtual void __stdcall get_hint (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_hint (GCI::IO::IString_tie* hint) = 0;


	virtual unsigned long __stdcall get_id () const = 0;


	virtual bool __stdcall get_is_readonly () const = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_name (GCI::IO::IString_tie* name) = 0;

	virtual void __stdcall restore_default_values_45EEDBE3014D () const = 0;

	virtual void __stdcall save_values_as_default_45EEDBE3014E () const = 0;


	virtual ConfigurationType __stdcall get_type () const = 0;
};

class __declspec (dllexport) Configuration_tie: public IConfiguration_tie {
	SET_OBJECT_COUNTER (Configuration_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Configuration_tie ();

	typedef ::Core::PoolObjectManager<Configuration_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Configuration_tie> Pool;
	friend class ::Core::PoolObjectManager<Configuration_tie>;
	typedef ::Core::IidMapRegistrator<Configuration_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IConfiguration_tie* obj, Configuration*& ret_, bool interface_addref = false);

	static void make_tie (const Configuration* obj, IConfiguration_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Configuration& obj, IConfiguration_tie*& ret_, const Core::TIEBase* owner);

	Configuration* m_impl;

protected:
	virtual void __stdcall copy_45EEDBE3014F (
		IConfiguration_tie*& ret_
	) const;

	virtual void __stdcall get_settings_45EEDBE30150 (
		ISettingsManager_tie*& ret_
	) const;


	virtual void __stdcall get_hint (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_hint (GCI::IO::IString_tie* hint);


	virtual unsigned long __stdcall get_id () const;


	virtual bool __stdcall get_is_readonly () const;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);

	virtual void __stdcall restore_default_values_45EEDBE3014D () const;

	virtual void __stdcall save_values_as_default_45EEDBE3014E () const;


	virtual ConfigurationType __stdcall get_type () const;
};

class IDefaultValuesChangesIndicator_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_configuration (IConfiguration_tie*& ret_) = 0;


	virtual DefaultValuesChangesState __stdcall get_state () const = 0;
};

class __declspec (dllexport) DefaultValuesChangesIndicator_tie: public IDefaultValuesChangesIndicator_tie {
	SET_OBJECT_COUNTER (DefaultValuesChangesIndicator_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	DefaultValuesChangesIndicator_tie ();

	typedef ::Core::PoolObjectManager<DefaultValuesChangesIndicator_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DefaultValuesChangesIndicator_tie> Pool;
	friend class ::Core::PoolObjectManager<DefaultValuesChangesIndicator_tie>;
	typedef ::Core::IidMapRegistrator<DefaultValuesChangesIndicator_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDefaultValuesChangesIndicator_tie* obj, DefaultValuesChangesIndicator*& ret_, bool interface_addref = false);

	static void make_tie (const DefaultValuesChangesIndicator* obj, IDefaultValuesChangesIndicator_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DefaultValuesChangesIndicator& obj, IDefaultValuesChangesIndicator_tie*& ret_, const Core::TIEBase* owner);

	DefaultValuesChangesIndicator* m_impl;

protected:

	virtual void __stdcall get_configuration (IConfiguration_tie*& ret_);


	virtual DefaultValuesChangesState __stdcall get_state () const;
};

class Configurations_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (Configurations_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Configurations_tie ();

	typedef ::Core::PoolObjectManager<Configurations_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Configurations_tie> Pool;
	friend class ::Core::PoolObjectManager<Configurations_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const Configurations_tie* obj, Configurations*& ret_);

	static void make_tie (Configurations* obj, Configurations_tie*& ret_);
	
	static void make_tie (const Configurations& obj, Configurations_tie*& ret_);

	static void make_tie (const Configurations& obj, Configurations_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (Configurations* obj, Configurations_tie*& ret_);

	Configurations* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IConfiguration_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IConfiguration_tie* item);
	virtual size_t __stdcall add (const IConfiguration_tie* item);
	virtual size_t __stdcall insert (size_t index, const IConfiguration_tie* item);
};

class IConfigurationManager_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_configurations (Configurations_tie*& ret_) const = 0;

	virtual void __stdcall default_values_update_check_45EEDBE3014A (
		IDefaultValuesChangesIndicator_tie*& ret_
	) = 0;

	virtual void __stdcall get_active_45EEDBE30149 (
		IConfiguration_tie*& ret_
	) = 0;

	virtual void __stdcall remove_45EEDBE30147 (
		const IConfiguration_tie* configuration
	) /*throw (ConstantModify_tie, ConfigurationIsActiveNow_tie)*/ = 0;

	virtual void __stdcall set_active_45EEDBE30145 (
		const IConfiguration_tie* configuration
	) = 0;
};

class __declspec (dllexport) ConfigurationManager_tie: public IConfigurationManager_tie {
	SET_OBJECT_COUNTER (ConfigurationManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ConfigurationManager_tie ();

	typedef ::Core::PoolObjectManager<ConfigurationManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ConfigurationManager_tie> Pool;
	friend class ::Core::PoolObjectManager<ConfigurationManager_tie>;
	typedef ::Core::IidMapRegistrator<ConfigurationManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IConfigurationManager_tie* obj, ConfigurationManager*& ret_, bool interface_addref = false);

	static void make_tie (const ConfigurationManager* obj, IConfigurationManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ConfigurationManager& obj, IConfigurationManager_tie*& ret_, const Core::TIEBase* owner);

	ConfigurationManager* m_impl;

protected:

	virtual void __stdcall get_configurations (Configurations_tie*& ret_) const;

	virtual void __stdcall default_values_update_check_45EEDBE3014A (
		IDefaultValuesChangesIndicator_tie*& ret_
	);

	virtual void __stdcall get_active_45EEDBE30149 (
		IConfiguration_tie*& ret_
	);

	virtual void __stdcall remove_45EEDBE30147 (
		const IConfiguration_tie* configuration
	) /*throw (ConstantModify_tie, ConfigurationIsActiveNow_tie)*/;

	virtual void __stdcall set_active_45EEDBE30145 (
		const IConfiguration_tie* configuration
	);
};

class IPermanentSettingsManager_tie: public IBaseSettingsManager_tie {
public:

};

class __declspec (dllexport) PermanentSettingsManager_tie: public IPermanentSettingsManager_tie {
	SET_OBJECT_COUNTER (PermanentSettingsManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	PermanentSettingsManager_tie ();

	typedef ::Core::PoolObjectManager<PermanentSettingsManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PermanentSettingsManager_tie> Pool;
	friend class ::Core::PoolObjectManager<PermanentSettingsManager_tie>;
	typedef ::Core::IidMapRegistrator<PermanentSettingsManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IPermanentSettingsManager_tie* obj, PermanentSettingsManager*& ret_, bool interface_addref = false);

	static void make_tie (const PermanentSettingsManager* obj, IPermanentSettingsManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const PermanentSettingsManager& obj, IPermanentSettingsManager_tie*& ret_, const Core::TIEBase* owner);

	PermanentSettingsManager* m_impl;

protected:
	virtual bool __stdcall get_bool_4AC4990B0238 (
		const PropertyStringID id
		, bool& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_int64_4AC4990F037A (
		const PropertyStringID id
		, long long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_long_4AC49912024A (
		const PropertyStringID id
		, long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_string_4AC499150301 (
		const PropertyStringID id
		, GCI::IO::IString_tie*& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_ulong_4AC49919002B (
		const PropertyStringID id
		, unsigned long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_bool_4AC4991C01E1 (
		const PropertyStringID id
		, bool value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_int64_4AC4991F02F1 (
		const PropertyStringID id
		, long long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_long_4AC499220301 (
		const PropertyStringID id
		, long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_string_4AC4992601BC (
		const PropertyStringID id
		, const char* value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_ulong_4AC499290308 (
		const PropertyStringID id
		, unsigned long value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall is_exist_4AC4993302A8 (
		const PropertyStringID id
	) const;

};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

