////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Start/Start_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_START_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner_tie.h"

namespace GblAdapterLib {

class IAuthorization_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_administrator_email (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_administrator_email (GCI::IO::IString_tie* administrator_email) = 0;


	virtual void __stdcall get_administrator_phone (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_administrator_phone (GCI::IO::IString_tie* administrator_phone) = 0;

	virtual void __stdcall autoregistration_45EEE3D303D0 (
		const char* name
		, const char* login
		, const char* password
		, const char* email
	) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, LicenceViolation_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, NoMoreConnections_tie, AutoregistrationDisabled_tie)*/ = 0;


	virtual bool __stdcall get_autoregistration_status () const = 0;
	virtual void __stdcall set_autoregistration_status (bool autoregistration_status) /*throw (AccessDenied_tie)*/ = 0;

	virtual void __stdcall guest_login_45EEE3D303CD () const /*throw (NoMoreProfiles_tie, LicenceViolation_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, NoMoreConnections_tie)*/ = 0;

	virtual bool __stdcall is_server_alive_45EEE3D303D9 () const = 0;

	virtual void __stdcall login_45EEE3D303C9 (
		const char* login
		, const char* password
	) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, AlreadyLogged_tie, AccountDisabled_tie, NoMoreConnections_tie)*/ = 0;

	virtual void __stdcall logout_45EEE3D303CF () const = 0;

	virtual void __stdcall logout_without_xml_backup_4E23D8250328 () const = 0;


	virtual long __stdcall get_protection_error () const = 0;


	virtual long __stdcall get_rest_trial_days_count () const = 0;

	virtual void __stdcall send_user_info_by_email_45EEE3D303D6 (
		const char* email
	) const /*throw (SMTPServerAddressNotDefined_tie, SMTPServerNotFound_tie, UserNotFound_tie, BadSMTPReply_tie, SMTPAuthorizationFailed_tie)*/ = 0;
};

class __declspec (dllexport) Authorization_tie: public IAuthorization_tie {
	SET_OBJECT_COUNTER (Authorization_tie)
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
	Authorization_tie ();

	typedef ::Core::PoolObjectManager<Authorization_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Authorization_tie> Pool;
	friend class ::Core::PoolObjectManager<Authorization_tie>;
	typedef ::Core::IidMapRegistrator<Authorization_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IAuthorization_tie* obj, Authorization*& ret_, bool interface_addref = false);

	static void make_tie (const Authorization* obj, IAuthorization_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Authorization& obj, IAuthorization_tie*& ret_, const Core::TIEBase* owner);

	Authorization* m_impl;

protected:

	virtual void __stdcall get_administrator_email (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_administrator_email (GCI::IO::IString_tie* administrator_email);


	virtual void __stdcall get_administrator_phone (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_administrator_phone (GCI::IO::IString_tie* administrator_phone);

	virtual void __stdcall autoregistration_45EEE3D303D0 (
		const char* name
		, const char* login
		, const char* password
		, const char* email
	) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, LicenceViolation_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, NoMoreConnections_tie, AutoregistrationDisabled_tie)*/;


	virtual bool __stdcall get_autoregistration_status () const;
	virtual void __stdcall set_autoregistration_status (bool autoregistration_status) /*throw (AccessDenied_tie)*/;

	virtual void __stdcall guest_login_45EEE3D303CD () const /*throw (NoMoreProfiles_tie, LicenceViolation_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, NoMoreConnections_tie)*/;

	virtual bool __stdcall is_server_alive_45EEE3D303D9 () const;

	virtual void __stdcall login_45EEE3D303C9 (
		const char* login
		, const char* password
	) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, AlreadyLogged_tie, AccountDisabled_tie, NoMoreConnections_tie)*/;

	virtual void __stdcall logout_45EEE3D303CF () const;

	virtual void __stdcall logout_without_xml_backup_4E23D8250328 () const;


	virtual long __stdcall get_protection_error () const;


	virtual long __stdcall get_rest_trial_days_count () const;

	virtual void __stdcall send_user_info_by_email_45EEE3D303D6 (
		const char* email
	) const /*throw (SMTPServerAddressNotDefined_tie, SMTPServerNotFound_tie, UserNotFound_tie, BadSMTPReply_tie, SMTPAuthorizationFailed_tie)*/;
};

class ICommon_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall auto_show_help_46F22CA50148 () const = 0;


	virtual void __stdcall get_base_date (Date& ret_) const = 0;

	virtual bool __stdcall check_internal_45EEE4730077 () const = 0;

	virtual void __stdcall create_folder_notification_queue_49DEFB6403B8 () = 0;

	virtual void __stdcall get_banner_4ACC7293034A (
		IBanner_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual BaseType __stdcall get_base_type_494B8EB70150 () const = 0;

	virtual void __stdcall get_complect_name_460A4B1C008C (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual bool __stdcall get_document_on_number_45EEE473005E (
		long number
		, IDocument_tie*& document
		, IMissingInfo_tie*& missing_info
	) const = 0;

	virtual void __stdcall get_encrypted_complect_id_51ADE9F9011C (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_picture_4F3CE8840273 (
		long id
		, IExternalObject_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual ProductType __stdcall get_product_type_4715FD8D01C5 () const = 0;

	virtual void __stdcall get_scripts_system_dictionary_4E0C248F0243 (
		GCI::IO::IStream_tie*& ret_
	) const = 0;

	virtual void __stdcall get_settings_manager_47A84BF100A3 (
		ISettingsManager_tie*& ret_
	) const = 0;

	virtual void __stdcall get_splash_screen_47A84A470118 (
		bool is_start
		, short x
		, short y
		, bool flash_available
		, ISplashScreen_tie*& ret_
	) const = 0;

	virtual bool __stdcall is_eo_enabled_489AE01901E0 () const = 0;

	virtual bool __stdcall is_erase_of_inactive_users_enabled_4F547E5602BC () const = 0;

	virtual bool __stdcall is_explanatory_dictionary_exist_45EEE4730067 () const = 0;

	virtual bool __stdcall is_pharm_exist_47D00A9402BF () const = 0;

	virtual bool __stdcall is_trimmed_publish_source_exists_4B4C52210165 () const = 0;


	virtual void __stdcall get_license_restrictions (LicenseRestrictions& ret_) const = 0;

	virtual void __stdcall show_pictures_on_number_45EEE4730078 (
		long number
	) const /*throw (WorkingParamsNotFound_tie, ExternalApplicationError_tie)*/ = 0;

	virtual void __stdcall start_processing_folder_notification_45EEE4730065 (
		IExternalFoldersChangeNotifier_tie* notifier
	) = 0;
};

class __declspec (dllexport) Common_tie: public ICommon_tie {
	SET_OBJECT_COUNTER (Common_tie)
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
	Common_tie ();

	typedef ::Core::PoolObjectManager<Common_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Common_tie> Pool;
	friend class ::Core::PoolObjectManager<Common_tie>;
	typedef ::Core::IidMapRegistrator<Common_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ICommon_tie* obj, Common*& ret_, bool interface_addref = false);

	static void make_tie (const Common* obj, ICommon_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Common& obj, ICommon_tie*& ret_, const Core::TIEBase* owner);

	Common* m_impl;

protected:
	virtual bool __stdcall auto_show_help_46F22CA50148 () const;


	virtual void __stdcall get_base_date (Date& ret_) const;

	virtual bool __stdcall check_internal_45EEE4730077 () const;

	virtual void __stdcall create_folder_notification_queue_49DEFB6403B8 ();

	virtual void __stdcall get_banner_4ACC7293034A (
		IBanner_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual BaseType __stdcall get_base_type_494B8EB70150 () const;

	virtual void __stdcall get_complect_name_460A4B1C008C (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual bool __stdcall get_document_on_number_45EEE473005E (
		long number
		, IDocument_tie*& document
		, IMissingInfo_tie*& missing_info
	) const;

	virtual void __stdcall get_encrypted_complect_id_51ADE9F9011C (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_picture_4F3CE8840273 (
		long id
		, IExternalObject_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual ProductType __stdcall get_product_type_4715FD8D01C5 () const;

	virtual void __stdcall get_scripts_system_dictionary_4E0C248F0243 (
		GCI::IO::IStream_tie*& ret_
	) const;

	virtual void __stdcall get_settings_manager_47A84BF100A3 (
		ISettingsManager_tie*& ret_
	) const;

	virtual void __stdcall get_splash_screen_47A84A470118 (
		bool is_start
		, short x
		, short y
		, bool flash_available
		, ISplashScreen_tie*& ret_
	) const;

	virtual bool __stdcall is_eo_enabled_489AE01901E0 () const;

	virtual bool __stdcall is_erase_of_inactive_users_enabled_4F547E5602BC () const;

	virtual bool __stdcall is_explanatory_dictionary_exist_45EEE4730067 () const;

	virtual bool __stdcall is_pharm_exist_47D00A9402BF () const;

	virtual bool __stdcall is_trimmed_publish_source_exists_4B4C52210165 () const;


	virtual void __stdcall get_license_restrictions (LicenseRestrictions& ret_) const;

	virtual void __stdcall show_pictures_on_number_45EEE4730078 (
		long number
	) const /*throw (WorkingParamsNotFound_tie, ExternalApplicationError_tie)*/;

	virtual void __stdcall start_processing_folder_notification_45EEE4730065 (
		IExternalFoldersChangeNotifier_tie* notifier
	);
};

class IComponentManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall start_474C0E5E0042 () /*throw (StorageLocked_tie, LicenceViolation_tie, ConfigurationsNotDefined_tie, IPAddressNotFound_tie, InvalidBase_tie, NoServer_tie, BadNetworkConfig_tie, ServerVersionNotValid_tie, WorkingParamsNotFound_tie, NoMoreConnections_tie, MorphoNotExists_tie, InternalApplicationError_tie, InvalidUserDatastore_tie, ServerIsStarting_tie)*/ = 0;

	virtual void __stdcall stop_474C0E7501F1 () = 0;
};

class __declspec (dllexport) ComponentManager_tie: public IComponentManager_tie {
	SET_OBJECT_COUNTER (ComponentManager_tie)
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
	ComponentManager_tie ();

	typedef ::Core::PoolObjectManager<ComponentManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ComponentManager_tie> Pool;
	friend class ::Core::PoolObjectManager<ComponentManager_tie>;
	typedef ::Core::IidMapRegistrator<ComponentManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IComponentManager_tie* obj, ComponentManager*& ret_, bool interface_addref = false);

	static void make_tie (const ComponentManager* obj, IComponentManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ComponentManager& obj, IComponentManager_tie*& ret_, const Core::TIEBase* owner);

	ComponentManager* m_impl;

protected:
	virtual void __stdcall start_474C0E5E0042 () /*throw (StorageLocked_tie, LicenceViolation_tie, ConfigurationsNotDefined_tie, IPAddressNotFound_tie, InvalidBase_tie, NoServer_tie, BadNetworkConfig_tie, ServerVersionNotValid_tie, WorkingParamsNotFound_tie, NoMoreConnections_tie, MorphoNotExists_tie, InternalApplicationError_tie, InvalidUserDatastore_tie, ServerIsStarting_tie)*/;

	virtual void __stdcall stop_474C0E7501F1 ();
};

class IAssemblyInfo_tie: public ::Core::IIObject_tie {
public:

	virtual bool __stdcall get_first_start () const = 0;
	virtual void __stdcall set_first_start (bool first_start) = 0;


	virtual bool __stdcall get_is_commerce () const = 0;


	virtual bool __stdcall get_is_debug () const = 0;


	virtual bool __stdcall get_is_desktop () const = 0;


	virtual const Capacity __stdcall get_server_capacity () const = 0;
};

class __declspec (dllexport) AssemblyInfo_tie: public IAssemblyInfo_tie {
	SET_OBJECT_COUNTER (AssemblyInfo_tie)
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
	AssemblyInfo_tie ();

	typedef ::Core::PoolObjectManager<AssemblyInfo_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<AssemblyInfo_tie> Pool;
	friend class ::Core::PoolObjectManager<AssemblyInfo_tie>;
	typedef ::Core::IidMapRegistrator<AssemblyInfo_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IAssemblyInfo_tie* obj, AssemblyInfo*& ret_, bool interface_addref = false);

	static void make_tie (const AssemblyInfo* obj, IAssemblyInfo_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const AssemblyInfo& obj, IAssemblyInfo_tie*& ret_, const Core::TIEBase* owner);

	AssemblyInfo* m_impl;

protected:

	virtual bool __stdcall get_first_start () const;
	virtual void __stdcall set_first_start (bool first_start);


	virtual bool __stdcall get_is_commerce () const;


	virtual bool __stdcall get_is_debug () const;


	virtual bool __stdcall get_is_desktop () const;


	virtual const Capacity __stdcall get_server_capacity () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_START_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

