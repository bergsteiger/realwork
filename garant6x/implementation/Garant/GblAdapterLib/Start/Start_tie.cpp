////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Start/Start_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID Authorization_tie::s_com_iid = {0xA49B3BF6, 0xB27F, 0x4D79, {0xA6, 0x7E, 0xC5, 0x1A, 0xF7, 0xF6, 0x78, 0x55}};

Authorization_tie::IidRegistrator Authorization_tie::s_iid_registrator;

Authorization_tie::Authorization_tie () : m_impl(NULL) {
}

unsigned long __stdcall Authorization_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall Authorization_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Authorization_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Authorization_tie* const>(this));
	}
	return counter;
}

void Authorization_tie::init () {
		m_counter = 1;
	}

void Authorization_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Authorization_tie::cast (::Core::IObject* obj) {
	Authorization* ret = dynamic_cast<Authorization*>(obj);
	if (ret) {
		ret->addref();
	}
	IAuthorization_tie* ret_ = NULL;
	Authorization_tie::make_tie (ret, ret_);
	return ret_;
}

void Authorization_tie::make_cpp (const IAuthorization_tie* obj, Authorization*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Authorization*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Authorization_tie::make_tie (const Authorization* obj, IAuthorization_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Authorization_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Authorization*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Authorization_tie::make_tie (const Authorization& obj, IAuthorization_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Authorization_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Authorization*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Authorization_tie::get_impl () const {
	return m_impl;
}


void __stdcall Authorization_tie::get_administrator_email (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_administrator_email(), ret_, this);
_DLL_CATCH
}
void __stdcall Authorization_tie::set_administrator_email (GCI::IO::IString_tie* administrator_email) {
_DLL_TRY
	GCI::IO::String* administrator_email_;
	GCI::IO::String_tie::make_cpp(administrator_email, administrator_email_);
	m_impl->set_administrator_email(administrator_email_);
_DLL_CATCH
}


void __stdcall Authorization_tie::get_administrator_phone (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_administrator_phone(), ret_, this);
_DLL_CATCH
}
void __stdcall Authorization_tie::set_administrator_phone (GCI::IO::IString_tie* administrator_phone) {
_DLL_TRY
	GCI::IO::String* administrator_phone_;
	GCI::IO::String_tie::make_cpp(administrator_phone, administrator_phone_);
	m_impl->set_administrator_phone(administrator_phone_);
_DLL_CATCH
}

void __stdcall Authorization_tie::autoregistration_45EEE3D303D0 (
	const char* name
	, const char* login
	, const char* password
	, const char* email
) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, LicenceViolation_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, NoMoreConnections_tie, AutoregistrationDisabled_tie)*/ {
_DLL_TRY

	m_impl->autoregistration(name, login, password, email);
_DLL_CATCH
}


bool __stdcall Authorization_tie::get_autoregistration_status () const {
_DLL_TRY
	return m_impl->get_autoregistration_status();
_DLL_CATCH
}
void __stdcall Authorization_tie::set_autoregistration_status (bool autoregistration_status) /*throw (AccessDenied_tie)*/ {
_DLL_TRY
	m_impl->set_autoregistration_status(autoregistration_status);
_DLL_CATCH
}

void __stdcall Authorization_tie::guest_login_45EEE3D303CD () const /*throw (NoMoreProfiles_tie, LicenceViolation_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, NoMoreConnections_tie)*/ {
_DLL_TRY

	m_impl->guest_login();
_DLL_CATCH
}

bool __stdcall Authorization_tie::is_server_alive_45EEE3D303D9 () const {
_DLL_TRY
	return m_impl->is_server_alive ();
_DLL_CATCH
}

void __stdcall Authorization_tie::login_45EEE3D303C9 (
	const char* login
	, const char* password
) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, XMLImportRunning_tie, ShutdownInited_tie, TrialPeriodExpired_tie, AlreadyLogged_tie, AccountDisabled_tie, NoMoreConnections_tie)*/ {
_DLL_TRY

	m_impl->login(login, password);
_DLL_CATCH
}

void __stdcall Authorization_tie::logout_45EEE3D303CF () const {
_DLL_TRY

	m_impl->logout();
_DLL_CATCH
}

void __stdcall Authorization_tie::logout_without_xml_backup_4E23D8250328 () const {
_DLL_TRY

	m_impl->logout_without_xml_backup();
_DLL_CATCH
}


long __stdcall Authorization_tie::get_protection_error () const {
_DLL_TRY
	return m_impl->get_protection_error();
_DLL_CATCH
}


long __stdcall Authorization_tie::get_rest_trial_days_count () const {
_DLL_TRY
	return m_impl->get_rest_trial_days_count();
_DLL_CATCH
}

void __stdcall Authorization_tie::send_user_info_by_email_45EEE3D303D6 (
	const char* email
) const /*throw (SMTPServerAddressNotDefined_tie, SMTPServerNotFound_tie, UserNotFound_tie, BadSMTPReply_tie, SMTPAuthorizationFailed_tie)*/ {
_DLL_TRY

	m_impl->send_user_info_by_email(email);
_DLL_CATCH
}



const ::Core::ComIID Common_tie::s_com_iid = {0xE07B0F92, 0xC20B, 0x4AB2, {0x84, 0xA3, 0x33, 0xBC, 0x2A, 0xF4, 0x65, 0x9C}};

Common_tie::IidRegistrator Common_tie::s_iid_registrator;

Common_tie::Common_tie () : m_impl(NULL) {
}

unsigned long __stdcall Common_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall Common_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Common_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Common_tie* const>(this));
	}
	return counter;
}

void Common_tie::init () {
		m_counter = 1;
	}

void Common_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Common_tie::cast (::Core::IObject* obj) {
	Common* ret = dynamic_cast<Common*>(obj);
	if (ret) {
		ret->addref();
	}
	ICommon_tie* ret_ = NULL;
	Common_tie::make_tie (ret, ret_);
	return ret_;
}

void Common_tie::make_cpp (const ICommon_tie* obj, Common*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Common*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Common_tie::make_tie (const Common* obj, ICommon_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Common_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Common*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Common_tie::make_tie (const Common& obj, ICommon_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Common_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Common*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Common_tie::get_impl () const {
	return m_impl;
}

bool __stdcall Common_tie::auto_show_help_46F22CA50148 () const {
_DLL_TRY
	return m_impl->auto_show_help ();
_DLL_CATCH
}


void __stdcall Common_tie::get_base_date (Date& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_base_date();
_DLL_CATCH
}

bool __stdcall Common_tie::check_internal_45EEE4730077 () const {
_DLL_TRY
	return m_impl->check_internal ();
_DLL_CATCH
}

void __stdcall Common_tie::create_folder_notification_queue_49DEFB6403B8 () {
_DLL_TRY

	m_impl->create_folder_notification_queue();
_DLL_CATCH
}

void __stdcall Common_tie::get_banner_4ACC7293034A (
	IBanner_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	Banner* ret = m_impl->get_banner();
	Banner_tie::make_tie(ret, ret_);
_DLL_CATCH
}

BaseType __stdcall Common_tie::get_base_type_494B8EB70150 () const {
_DLL_TRY
	return m_impl->get_base_type ();
_DLL_CATCH
}

void __stdcall Common_tie::get_complect_name_460A4B1C008C (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_complect_name();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall Common_tie::get_document_on_number_45EEE473005E (
	long number
	, IDocument_tie*& document
	, IMissingInfo_tie*& missing_info
) const {
_DLL_TRY
	Document* document_ = 0;
	MissingInfo* missing_info_ = 0;

	bool ret = m_impl->get_document_on_number(number, document_, missing_info_);
	Document_tie::make_tie(document_, document);
	MissingInfo_tie::make_tie(missing_info_, missing_info);
	return ret;
_DLL_CATCH
}

void __stdcall Common_tie::get_encrypted_complect_id_51ADE9F9011C (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_encrypted_complect_id();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Common_tie::get_picture_4F3CE8840273 (
	long id
	, IExternalObject_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	ExternalObject* ret = m_impl->get_picture(id);
	ExternalObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

ProductType __stdcall Common_tie::get_product_type_4715FD8D01C5 () const {
_DLL_TRY
	return m_impl->get_product_type ();
_DLL_CATCH
}

void __stdcall Common_tie::get_scripts_system_dictionary_4E0C248F0243 (
	GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_scripts_system_dictionary();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Common_tie::get_settings_manager_47A84BF100A3 (
	ISettingsManager_tie*& ret_
) const {
_DLL_TRY

	SettingsManager* ret = m_impl->get_settings_manager();
	SettingsManager_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Common_tie::get_splash_screen_47A84A470118 (
	bool is_start
	, short x
	, short y
	, bool flash_available
	, ISplashScreen_tie*& ret_
) const {
_DLL_TRY

	SplashScreen* ret = m_impl->get_splash_screen(is_start, x, y, flash_available);
	SplashScreen_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall Common_tie::is_eo_enabled_489AE01901E0 () const {
_DLL_TRY
	return m_impl->is_eo_enabled ();
_DLL_CATCH
}

bool __stdcall Common_tie::is_erase_of_inactive_users_enabled_4F547E5602BC () const {
_DLL_TRY
	return m_impl->is_erase_of_inactive_users_enabled ();
_DLL_CATCH
}

bool __stdcall Common_tie::is_explanatory_dictionary_exist_45EEE4730067 () const {
_DLL_TRY
	return m_impl->is_explanatory_dictionary_exist ();
_DLL_CATCH
}

bool __stdcall Common_tie::is_pharm_exist_47D00A9402BF () const {
_DLL_TRY
	return m_impl->is_pharm_exist ();
_DLL_CATCH
}

bool __stdcall Common_tie::is_trimmed_publish_source_exists_4B4C52210165 () const {
_DLL_TRY
	return m_impl->is_trimmed_publish_source_exists ();
_DLL_CATCH
}


void __stdcall Common_tie::get_license_restrictions (LicenseRestrictions& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_license_restrictions();
_DLL_CATCH
}

void __stdcall Common_tie::show_pictures_on_number_45EEE4730078 (
	long number
) const /*throw (WorkingParamsNotFound_tie, ExternalApplicationError_tie)*/ {
_DLL_TRY

	m_impl->show_pictures_on_number(number);
_DLL_CATCH
}

void __stdcall Common_tie::start_processing_folder_notification_45EEE4730065 (
	IExternalFoldersChangeNotifier_tie* notifier
) {
_DLL_TRY
	ExternalFoldersChangeNotifier_var notifier_;
	IExternalFoldersChangeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->start_processing_folder_notification(notifier_.in ());
_DLL_CATCH
}



const ::Core::ComIID ComponentManager_tie::s_com_iid = {0xC92D07EF, 0xD91F, 0x4CDD, {0xBD, 0x8E, 0xFC, 0x8D, 0xF1, 0x8C, 0xC4, 0x2C}};

ComponentManager_tie::IidRegistrator ComponentManager_tie::s_iid_registrator;

ComponentManager_tie::ComponentManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall ComponentManager_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall ComponentManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ComponentManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ComponentManager_tie* const>(this));
	}
	return counter;
}

void ComponentManager_tie::init () {
		m_counter = 1;
	}

void ComponentManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ComponentManager_tie::cast (::Core::IObject* obj) {
	ComponentManager* ret = dynamic_cast<ComponentManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IComponentManager_tie* ret_ = NULL;
	ComponentManager_tie::make_tie (ret, ret_);
	return ret_;
}

void ComponentManager_tie::make_cpp (const IComponentManager_tie* obj, ComponentManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ComponentManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ComponentManager_tie::make_tie (const ComponentManager* obj, IComponentManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ComponentManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ComponentManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ComponentManager_tie::make_tie (const ComponentManager& obj, IComponentManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ComponentManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ComponentManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ComponentManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall ComponentManager_tie::start_474C0E5E0042 () /*throw (StorageLocked_tie, LicenceViolation_tie, ConfigurationsNotDefined_tie, IPAddressNotFound_tie, InvalidBase_tie, NoServer_tie, BadNetworkConfig_tie, ServerVersionNotValid_tie, WorkingParamsNotFound_tie, NoMoreConnections_tie, MorphoNotExists_tie, InternalApplicationError_tie, InvalidUserDatastore_tie, ServerIsStarting_tie)*/ {
_DLL_TRY

	m_impl->start();
_DLL_CATCH
}

void __stdcall ComponentManager_tie::stop_474C0E7501F1 () {
_DLL_TRY

	m_impl->stop();
_DLL_CATCH
}



const ::Core::ComIID AssemblyInfo_tie::s_com_iid = {0xD5DBA4D0, 0xD3CD, 0x43ED, {0x9E, 0x01, 0xCC, 0x85, 0x4B, 0x44, 0x2D, 0xA1}};

AssemblyInfo_tie::IidRegistrator AssemblyInfo_tie::s_iid_registrator;

AssemblyInfo_tie::AssemblyInfo_tie () : m_impl(NULL) {
}

unsigned long __stdcall AssemblyInfo_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall AssemblyInfo_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall AssemblyInfo_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<AssemblyInfo_tie* const>(this));
	}
	return counter;
}

void AssemblyInfo_tie::init () {
		m_counter = 1;
	}

void AssemblyInfo_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* AssemblyInfo_tie::cast (::Core::IObject* obj) {
	AssemblyInfo* ret = dynamic_cast<AssemblyInfo*>(obj);
	if (ret) {
		ret->addref();
	}
	IAssemblyInfo_tie* ret_ = NULL;
	AssemblyInfo_tie::make_tie (ret, ret_);
	return ret_;
}

void AssemblyInfo_tie::make_cpp (const IAssemblyInfo_tie* obj, AssemblyInfo*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<AssemblyInfo*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void AssemblyInfo_tie::make_tie (const AssemblyInfo* obj, IAssemblyInfo_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		AssemblyInfo_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<AssemblyInfo*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void AssemblyInfo_tie::make_tie (const AssemblyInfo& obj, IAssemblyInfo_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	AssemblyInfo_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<AssemblyInfo*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* AssemblyInfo_tie::get_impl () const {
	return m_impl;
}


bool __stdcall AssemblyInfo_tie::get_first_start () const {
_DLL_TRY
	return m_impl->get_first_start();
_DLL_CATCH
}
void __stdcall AssemblyInfo_tie::set_first_start (bool first_start) {
_DLL_TRY
	m_impl->set_first_start(first_start);
_DLL_CATCH
}


bool __stdcall AssemblyInfo_tie::get_is_commerce () const {
_DLL_TRY
	return m_impl->get_is_commerce();
_DLL_CATCH
}


bool __stdcall AssemblyInfo_tie::get_is_debug () const {
_DLL_TRY
	return m_impl->get_is_debug();
_DLL_CATCH
}


bool __stdcall AssemblyInfo_tie::get_is_desktop () const {
_DLL_TRY
	return m_impl->get_is_desktop();
_DLL_CATCH
}


const Capacity __stdcall AssemblyInfo_tie::get_server_capacity () const {
_DLL_TRY
	return m_impl->get_server_capacity();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

