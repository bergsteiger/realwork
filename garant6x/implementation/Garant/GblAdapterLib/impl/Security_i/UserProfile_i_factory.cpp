////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserProfile_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i.h"
//#UC START# *4608CCA80119CUSTOM_INLUDE*
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
//#UC END# *4608CCA80119CUSTOM_INLUDE*

namespace GblAdapterLib {

UserProfile_i_factory::UserProfile_i_factory () {
}

void UserProfile_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UserProfileFactoryManager::register_factory (this, priority);
}

const char* UserProfile_i_factory::key () const {
	return "UserProfile_i";
}

UserProfile* UserProfile_i_factory::make (
	Uid uid
	, const char* login
	, const char* name
	, const char* mail
	, bool is_system
	, bool has_password
	, bool can_buy_consulting
	, bool is_permanent
) {
	//#UC START# *45EED78501B54608CCA80119_4607D7390157_IMPL*
	return new UserProfile_i (
		uid
		, login
		, name
		, mail
		, is_system
		, has_password
		, can_buy_consulting
		, is_permanent
	);
	//#UC END# *45EED78501B54608CCA80119_4607D7390157_IMPL*
}

UserProfile* UserProfile_i_factory::make () {
	//#UC START# *45EED78501B54608CCA80119_4608D6F501F4_IMPL*
	// XXX: method must use new struct UserProfileInfo!
	
	// static UserProfile_var user_profile;
	static Core::Mutex profile_mutex;

	// if (!user_profile.ptr ()) {
	//	GUARD (profile_mutex);
	//	if (!user_profile.ptr ()) {
			
			GCD::Uid current_uid = ApplicationHelper::instance ()->get_cached_user_manager ()->get_current_user_id ();
			GslUserManager::UserInfo_var server_user_info = ApplicationHelper::instance ()->get_cached_user_manager ()->get_user_info (current_uid);
			if (!server_user_info.ptr ()) {
				return 0;
			}
			
			bool is_system = false;
			try {
				is_system = ApplicationHelper::instance ()->get_cached_user_manager ()->is_system (current_uid);
			} catch (...) {
				is_system = false;
			}

			bool has_payment_rights = false;
			try {
				has_payment_rights = 
					ApplicationHelper::instance ()->get_cached_user_manager ()->has_payment_rights (current_uid);
			} catch (...) {
				has_payment_rights = false;
			}

			bool is_permanent = false;
			try {
				is_permanent = ApplicationHelper::instance ()->get_cached_user_manager ()->is_permanent (current_uid);
			} catch (...) {
				is_permanent = false;
			}
			bool has_nonsearchable_blocks = false;
			try {
				GCD::ObjectIDList_var blocks = ApplicationHelper::instance ()->get_cached_user_manager ()->
					get_nonsearchable_blocks_for_user (current_uid);
				has_nonsearchable_blocks = blocks->length () ? true : false;
			} catch (...) {
				has_nonsearchable_blocks = false;
			}
			
			//user_profile = this->make (
			return this->make (
				current_uid
				, server_user_info->m_login.in ()
				, server_user_info->m_name.in ()
				, server_user_info->m_mail.in ()
				, is_system
				, std::strlen (server_user_info->m_password)
				, has_payment_rights
				, is_permanent
			);
	//	}
	// }

	// return user_profile._sretn ();
	//#UC END# *45EED78501B54608CCA80119_4608D6F501F4_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

