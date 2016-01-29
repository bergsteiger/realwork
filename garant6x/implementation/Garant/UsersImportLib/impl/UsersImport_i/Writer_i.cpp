////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Writer_i
//
// передаёт на сервер заданные данные для создания пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/LibHome.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i.h"
// by <<uses>> dependencies
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"

namespace UsersImport_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Writer_i::Writer_i ()
//#UC START# *481D707501DC_481D70BA00FF_481D7A0B00D7_BASE_INIT*
: GCM::GCMSimpleServer ()
//#UC END# *481D707501DC_481D70BA00FF_481D7A0B00D7_BASE_INIT*
{
	//#UC START# *481D707501DC_481D70BA00FF_481D7A0B00D7_BODY*
	register_receptacles (Defines::FN_USER_MANAGER);
	register_receptacles (Defines::FN_GROUP_MANAGER);
	register_receptacles (Defines::FN_FUNCTION_MNG);
	//#UC END# *481D707501DC_481D70BA00FF_481D7A0B00D7_BODY*
}

Writer_i::~Writer_i () {
	//#UC START# *481D7A0B00D7_DESTR_BODY*
	//#UC END# *481D7A0B00D7_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает булево значение - можно ли платить за консультации.
bool Writer_i::convert_consulting_status_to_boolean (boost::tribool value) const {
	//#UC START# *482046AE012D*
	if (boost::indeterminate (value)) {
		static bool consulting_policy = m_user_manager->get_consulting_payment_policy ();

		return consulting_policy;
	}

	return value;
	//#UC END# *482046AE012D*
}

// метод запуска компоненты
void Writer_i::execute () {
	//#UC START# *481EB7040260*
	CORBA::Object_var obj = provide (Defines::FN_USER_MANAGER);
	m_user_manager = GslUserManager::UserManager::_narrow (obj.in ());

	obj = provide (Defines::FN_GROUP_MANAGER);
	m_group_manager = GslUserManager::GroupManager::_narrow (obj.in ());

	obj = provide (Defines::FN_FUNCTION_MNG);
	m_function_manager = GblPilot::FunctionMng::_narrow (obj.in ());

	if (CORBA::is_nil (m_user_manager) || CORBA::is_nil (m_group_manager) || CORBA::is_nil (m_function_manager)) {
		status (GCM::cs_exit_requested);
		throw CantFindUserManager ();
	}

	GCMSimpleServer::execute ();
	//#UC END# *481EB7040260*
}

// получить список групп с сервера
void Writer_i::get_groups_info () {
	//#UC START# *49EC68D303BE*
	try {
		GCD::UidList_var groups (m_group_manager->get_groups_list ());

		for (size_t i = 0; i < groups->length (); ++i) {
			GslUserManager::GroupInfo_var group_info (m_group_manager->get_group_info (groups[i]));
			m_groups_data[group_info->m_name.in ()] = groups[i];
		}
	} catch (CORBA::Exception& ex) {
		GDS_ASSERT (false);
		LOG_CEXD ((ex, "can't get groups list"));
	}
	//#UC END# *49EC68D303BE*
}

// залогиниться на сервере
void Writer_i::login () {
	//#UC START# *49EC5DE40247*
	if (!m_auto_login.get ()) {
		try {
			m_auto_login.reset (new AutoLoginAdmin (GslUserManager::UserManager::_duplicate (m_user_manager)));
		} catch (GslUserManager::LoginDuplicate&) {
			throw AdminAlreadyLogged ();
		}
	}
	//#UC END# *49EC5DE40247*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UsersImport::DataWriter
// записать данные
void Writer_i::add_user (const UsersImport::UserData& user_data) {
	//#UC START# *481D77ED00CE_481D7A0B00D7*
	this->login ();

	m_user_manager->create_user_with_rights (
		user_data.name.c_str ()
		, user_data.login.c_str ()
		, user_data.password.c_str ()
		, user_data.email.c_str ()
		, this->convert_consulting_status_to_boolean (user_data.consulting_value)
		, user_data.privileged_status
		, user_data.group_id
	);
	//#UC END# *481D77ED00CE_481D7A0B00D7*
}

// implemented method from UsersImport::DataWriter
// сменить данные пользователя
void Writer_i::change_user (const UsersImport::UserData& user_data, CORBA::ULong fields_count) {
	//#UC START# *4C2DD34902EE_481D7A0B00D7*
	GDS_ASSERT (fields_count > 1);

	this->login ();

	GCD::Uid uid = m_user_manager->login_to_uid (user_data.login.c_str ());

	--fields_count; // login нам не нужен

	switch (fields_count) {
		case 6:		// group
			try {
				m_group_manager->change_group_for_user (uid, user_data.group_id);
			} catch (...) {
				GDS_ASSERT (false && "can't set group for user");
			}
		case 5:		// privileged
			try {
				GCD::UidList uid_list;
				uid_list.length (1);
				uid_list[0] = uid;
				m_user_manager->set_user_list_permanent_property (uid_list, user_data.privileged_status);
			} catch (GslUserManager::NoMorePersistentUsers&) {
				throw;
			} catch (...) {
				GDS_ASSERT (false && "can't set permanent flag for user");
			}
		case 4:		// consulting
			if (!boost::indeterminate (user_data.consulting_value)) {
				try {
					m_user_manager->set_user_payment_rights (uid, user_data.consulting_value);
				} catch (...) {
					GDS_ASSERT (false && "can't set consulting rights for user");
				}
			}
		case 3:		// e-mail
			try {
				m_user_manager->change_user_info (uid, user_data.name.c_str (), user_data.email.c_str ());
			} catch (...) {
				GDS_ASSERT (false && "can't set user name and email");
			}
		case 2:		// passwd
			try {
				m_user_manager->change_user_password (uid, user_data.password.c_str ());
			} catch (...) {
				GDS_ASSERT (false && "can't set user password");
			}
		case 1:		// ФИО
			if (fields_count < 3) { // если не установили ФИО ранее
				try {
					GslUserManager::UserInfo_var user_info (m_user_manager->get_user_info (uid));
					if (!user_info.ptr ()) {
						GDS_ASSERT (user_info.ptr () && "can't get user info");
						return;
					}

					m_user_manager->change_user_info (uid, user_data.name.c_str (), user_info->m_mail);
				} catch (...) {
					GDS_ASSERT (false && "can't set user name");
				}
			}
			break;
		default:
			GDS_ASSERT (false && "fields count too big");
	}
	//#UC END# *4C2DD34902EE_481D7A0B00D7*
}

// implemented method from UsersImport::DataWriter
// удалить пользователя
void Writer_i::erase_user (const UsersImport::UserData& user_data) {
	//#UC START# *4C2DD3100050_481D7A0B00D7*
	this->login ();

	GCD::Uid uid = m_user_manager->login_to_uid (user_data.login.c_str ());
	m_function_manager->delete_user (uid);
	//#UC END# *4C2DD3100050_481D7A0B00D7*
}

// implemented method from UsersImport::DataWriter
// получить идентификатор группы по её имени
GCD::Uid Writer_i::get_group_id (const std::string& name) {
	//#UC START# *49EC5A5C00C4_481D7A0B00D7*
	this->login ();

	if (m_groups_data.empty ()) {
		this->get_groups_info ();
	}
	GroupsWithNames::iterator result = m_groups_data.find (name);
	if (result != m_groups_data.end ()) {
		return result->second;
	}

	try {
		GCD::Uid group_id = m_group_manager->create_group (name.c_str ());
		m_groups_data[name] = group_id;
		return group_id;
	}
	catch (CORBA::Exception& ex) {
		GDS_ASSERT (false);
		LOG_CEXD ((ex, "can't create group %s, using default group", name.c_str ()));
	}

	return GCD::BaseUsersGroup;
	//#UC END# *49EC5A5C00C4_481D7A0B00D7*
}
} // namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

