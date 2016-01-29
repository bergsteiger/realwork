////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UsersTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsTree.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserManager_i::UserManager_i ()
//#UC START# *45EED57B0186_4607D6430177_4608BA7800DA_BASE_INIT*
//#UC END# *45EED57B0186_4607D6430177_4608BA7800DA_BASE_INIT*
{
	//#UC START# *45EED57B0186_4607D6430177_4608BA7800DA_BODY*
	m_is_payment_status_cached = false;
	//#UC END# *45EED57B0186_4607D6430177_4608BA7800DA_BODY*
}

UserManager_i::~UserManager_i () {
	//#UC START# *4608BA7800DA_DESTR_BODY*
	//#UC END# *4608BA7800DA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

bool UserManager_i::load_groups_tree () const {
	//#UC START# *49DF33670130*
	GroupsTree_var tree;
	try {
		GTree::Tree_var server_tree (ApplicationHelper::instance ()->get_cached_group_manager ()->get_groups_tree ());
		tree = new GroupsTree (server_tree);
		m_groups_root = dynamic_cast<RealNodeRoot*> (tree->root ());
	} catch (GCD::CanNotFindData&) {
		return false;
	} catch (::TimeStampSync::InvalidTimeStamp&) {
		tree->root_is_dead ();
		throw;
	} catch (CORBA::COMM_FAILURE& ex) {
		LOG_CEX ((ex, GDS_CURRENT_FUNCTION));
		tree->root_is_dead ();
		throw;
	}

	return true;
	//#UC END# *49DF33670130*
}

bool UserManager_i::load_users_tree () const {
	//#UC START# *49DF201E0110*
	GslUserManager::UserManager_ptr user_manager = ApplicationHelper::instance ()->get_cached_user_manager ();
	UsersTree_var tree;
	try {
		GTree::Tree_var server_tree = user_manager->get_users_tree ();
		tree = new UsersTree (server_tree);
		m_users_root = dynamic_cast<RealNodeRoot*> (tree->root ());
	} catch (GCD::CanNotFindData&) {
		return false;
	} catch (::TimeStampSync::InvalidTimeStamp&) {
		tree->root_is_dead ();
		throw;
	} catch (CORBA::COMM_FAILURE& ex) {
		LOG_CEX ((ex, GDS_CURRENT_FUNCTION));
		tree->root_is_dead ();
		throw;
	}

	return true;
	//#UC END# *49DF201E0110*
}

void UserManager_i::set_privileged_rights_i (const UidList& list, bool is_privileged) const {
	//#UC START# *473DD3F00006*
	GCD::UidList users_list;
	size_t list_size = list.size (); 
	users_list.length (list_size);
	for (size_t i = 0; i < list_size; ++i) {
		users_list[i] = list[i];
	}

	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->
			set_user_list_permanent_property (users_list, is_privileged);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	}  catch (GCD::XMLImportRunning&) {
		throw XMLImportRunning ();
	}  catch (GslUserManager::NoMorePersistentUsers&) {
		throw NoMorePrivilegedProfiles ();
	}
	//#UC END# *473DD3F00006*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UserManager
// можно ли зоздавать привилегированных пользователей
bool UserManager_i::can_create_privileged_user () const /*throw (AccessDenied)*/ {
	//#UC START# *473DCD910371_4608BA7800DA*
	try {
		GCD::LicenseSettings_var license_info (ApplicationHelper::instance ()->get_cached_user_manager ()->get_licence_info ());

		return license_info->m_max_perm_count != 0;
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	}
	//#UC END# *473DCD910371_4608BA7800DA*
}

// implemented method from UserManager
// сменить имя группы
void UserManager_i::change_group_name (
	Uid uid
	, const char* name
) const /*throw (
	AccessDenied
	, CanNotFindData
	, LoginDuplicate
)*/ {
	//#UC START# *49EF1F8F02B6_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_group_manager ()->change_group_name (uid, name);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (GCD::InvalidArgs&) {
		throw LoginDuplicate ();
	}
	//#UC END# *49EF1F8F02B6_4608BA7800DA*
}

// implemented method from UserManager
void UserManager_i::change_user_group (Uid user_id, Uid group_id) const /*throw (AccessDenied, CanNotFindData)*/ {
	//#UC START# *49E858400139_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_group_manager ()->change_group_for_user (user_id, group_id);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GslUserManager::BadGUID&) {
		throw CanNotFindData ();
	}
	//#UC END# *49E858400139_4608BA7800DA*
}

// implemented method from UserManager
// Изменение параметров пользователя за исключением
// пароля. Пользователь идентифицируется по uid.
void UserManager_i::change_user_info (
	Uid uid
	, const char* name
	, const char* mail
) const /*throw (
	AccessDenied
	, CanNotFindData
	, LicenceViolation
	, XMLImportRunning
)*/ {
	//#UC START# *45EED57B0195_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->change_user_info (uid, name, mail);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (GslUserManager::BadUserKeyInfo&) {
		throw CanNotFindData ();
	} catch (GslUserManager::LicenceViolation&) {
		throw LicenceViolation ();
	} catch (GCD::XMLImportRunning&) {
		throw XMLImportRunning ();
	}
	//#UC END# *45EED57B0195_4608BA7800DA*
}

// implemented method from UserManager
// Изменение пароля пользователя. Пользователь идентифицируется по uid.
void UserManager_i::change_user_password (
	Uid uid
	, const char* password
) const /*throw (
	AccessDenied
	, CanNotFindData
	, WrongAuthentication
	, LicenceViolation
	, XMLImportRunning
)*/ {
	//#UC START# *45EED57B0199_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->change_user_password (uid, password);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (GslUserManager::BadUserKeyInfo&) {
		throw CanNotFindData ();
	} catch (GslUserManager::LicenceViolation&) {
		throw LicenceViolation ();
	} catch (GCD::XMLImportRunning&) {
		throw XMLImportRunning ();
	} catch (GCD::InvalidArgs&) {
		throw WrongAuthentication ();
	}
	//#UC END# *45EED57B0199_4608BA7800DA*
}

// implemented method from UserManager
void UserManager_i::change_users_group (
	const UidList& id_list
	, Uid group_id
) const /*throw (
	AccessDenied
	, CanNotFindData
)*/ {
	//#UC START# *49F5595000F7_4608BA7800DA*
	size_t list_size = id_list.size ();
	GCD::UidList server_list;
	server_list.length (list_size);
	for (size_t i = 0; i < list_size; ++i) {
		server_list[i] = id_list[i];
	}

	try {
		ApplicationHelper::instance ()->get_cached_group_manager ()->change_users_group (server_list, group_id);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GslUserManager::BadGUID&) {
		throw CanNotFindData ();
	}
	//#UC END# *49F5595000F7_4608BA7800DA*
}

// implemented method from UserManager
// создать группу с заданным именем
void UserManager_i::create_group (
	const char* name
) const /*throw (
	AccessDenied
	, WrongAuthentication
	, XMLImportRunning
	, LoginDuplicate
)*/ {
	//#UC START# *49C8C2AF03D1_4608BA7800DA*
	try {
		if (ApplicationHelper::instance ()->get_cached_user_manager ()->is_public_login_available ()) {
			ApplicationHelper::instance ()->get_cached_group_manager ()->create_group (name);
		}
		else {
			throw XMLImportRunning ();
		}
	} catch (GCD::AccessDenied&) {
		throw  AccessDenied ();
	} catch (GslUserManager::LoginDuplicate&) {
		throw LoginDuplicate ();
	} catch (GCD::InvalidArgs&) {
		throw WrongAuthentication ();
	}
	//#UC END# *49C8C2AF03D1_4608BA7800DA*
}

// implemented method from UserManager
void UserManager_i::create_user_with_rights (
	const char* name
	, const char* login
	, const char* password
	, const char* mail
	, bool can_buy_consulting
	, bool is_privileged
	, Uid group_id
) const /*throw (
	WrongAuthentication
	, NoMoreProfiles
	, XMLImportRunning
	, LoginDuplicate
	, TrialPeriodExpired
	, NoMorePrivilegedProfiles
)*/ {
	//#UC START# *45EED57B018D_4608BA7800DA*
	try {
		GslUserManager::UserManager_ptr user_manager = ApplicationHelper::instance ()->get_cached_user_manager ();
		if (user_manager->is_public_login_available ()) {
			user_manager->create_user_with_rights (name, login, password, mail, can_buy_consulting, is_privileged, group_id);
		}
		else {
			throw XMLImportRunning ();
		}
	} catch (GslUserManager::LoginDuplicate&) {
		throw LoginDuplicate ();
	} catch (GslUserManager::LicenceViolation&) {
		throw NoMoreProfiles ();
	}  catch (GslUserManager::NoMorePersistentUsers&) {
		throw NoMorePrivilegedProfiles ();
	} catch (GslUserManager::TrialPeriodExpired&) {
		throw TrialPeriodExpired ();
	} catch (GCD::InvalidArgs&) {
		throw WrongAuthentication ();
	}
	//#UC END# *45EED57B018D_4608BA7800DA*
}

// implemented method from UserManager
// удалить группу с заданным идентификатором
void UserManager_i::delete_group (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/ {
	//#UC START# *49C8C58D029D_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_group_manager ()->delete_group (uid);
	} catch (GslUserManager::BadGUID&) {
		throw CanNotFindData ();
	} catch (GCD::AccessDenied&) {
		throw  AccessDenied ();
	}
	//#UC END# *49C8C58D029D_4608BA7800DA*
}

// implemented method from UserManager
void UserManager_i::delete_user (Uid uid) const /*throw (AccessDenied, CanNotFindData, UserActive)*/ {
	//#UC START# *45EED57B0193_4608BA7800DA*
	try {
		GslUserManager::UserManager_ptr user_manager = ApplicationHelper::instance ()->get_cached_user_manager ();
		if (user_manager->is_user_active (uid)) {
			throw UserActive ();
		} else {
			GblPilot::FunctionMng_ptr function_manager = ApplicationHelper::instance ()->get_cached_function_manager ();
			function_manager->delete_user (uid);
		}
	} catch (GslUserManager::BadGUID&) {
		throw CanNotFindData ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (GCD::AccessDenied&) {
		throw  AccessDenied ();
	}
	//#UC END# *45EED57B0193_4608BA7800DA*
}

// implemented method from UserManager
// удалить список пользователей. Возвращает список пользователей, которых удалить не удалось.
UidList* UserManager_i::delete_users (const UidList& list) const /*throw (AccessDenied)*/ {
	//#UC START# *4651A57F001F_4608BA7800DA*
	size_t list_size = list.size ();
	GCD::UidList server_list;
	server_list.length (list_size);
	for (size_t i = 0; i < list_size; ++i) {
		server_list[i] = list[i];
	}
	GCD::UidList_var result; 
	try {
		result = ApplicationHelper::instance ()->get_cached_function_manager ()->delete_users (server_list);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	}
	size_t bad_users_count = result->length ();
	std::auto_ptr<UidList> bad_users_list (new UidList ());
	bad_users_list->reserve (bad_users_count);
	for (size_t i = 0; i < bad_users_count; ++i) {
		bad_users_list->push_back (result[i]);
	}
	return bad_users_list.release ();
	//#UC END# *4651A57F001F_4608BA7800DA*
}

// implemented method from UserManager
// Получение списка юзеров, захвативших сетевую версию
StringList* UserManager_i::get_active_users_list_for_net_one_user_version () const /*throw (CanNotFindData)*/ {
	//#UC START# *486CB9E6016C_4608BA7800DA*
	try {
		StringList* ret = new StringList ();
		GCD::StringList_var active_users = 
			ApplicationHelper::instance ()->get_cached_user_manager ()->get_active_users_list_for_net_one_user_version ();
		ret->resize (active_users->length ());
		for (unsigned i = 0; i < active_users->length (); i++) {
			(*ret) [i] = GCI::IO::StringFactory::make (active_users [i].in ());
		}
		return ret;
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	//#UC END# *486CB9E6016C_4608BA7800DA*
}

// implemented method from UserManager
// возвращает текущее значение политики оплаты консультаций для новых пользователей (true - оплата
// разрешена)
bool UserManager_i::get_consulting_payment_for_newbies () const {
	//#UC START# *45EED57B01A6_4608BA7800DA*
	// todo поправить, чтоб статус менялся от серверной нотификации
	if (!m_is_payment_status_cached) {
		m_payment_status_for_newbies = ApplicationHelper::instance ()->get_cached_user_manager ()->get_consulting_payment_policy ();
		m_is_payment_status_cached = true;
	}

	return m_payment_status_for_newbies;
	//#UC END# *45EED57B01A6_4608BA7800DA*
}

// implemented method from UserManager
// получить дерево групп
NodeBase* UserManager_i::get_groups_tree () const {
	//#UC START# *49C8C1B502C0_4608BA7800DA*
	if (m_groups_root.is_nil () && !this->load_groups_tree ()) {
		throw CanNotFindData ();
	}

	return m_groups_root._sretn ();
	//#UC END# *49C8C1B502C0_4608BA7800DA*
}

// implemented method from UserManager
// получить список блоков базы по которым запрещён поиск группе пользователей
NodeIdList* UserManager_i::get_nonsearchable_blocks_for_group (
	Uid uid
) const /*throw (
	AccessDenied
	, InternalDatabaseError
)*/ {
	//#UC START# *49C8D65B0228_4608BA7800DA*
	GCD::ObjectIDList_var server_id_list;
	try {
		server_id_list = ApplicationHelper::instance ()->get_cached_group_manager ()->
			get_nonsearchable_blocks_for_group (uid);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GCD::CanNotFindData&) {
		throw InternalDatabaseError ();
	}

	std::auto_ptr<NodeIdList> id_list (new NodeIdList ());
	id_list->reserve (server_id_list->length ());
	for (size_t i = 0; i < server_id_list->length (); ++i) {
		id_list->push_back (server_id_list[i]);
	}
	return id_list.release ();
	//#UC END# *49C8D65B0228_4608BA7800DA*
}

// implemented method from UserManager
UserProfile* UserManager_i::get_self_profile () /*throw (CanNotFindData)*/ {
	//#UC START# *45EED57B01A1_4608BA7800DA*
	UserProfile_var user_profile = UserProfileFactory::make ();

	if (m_users_root.is_nil () && !this->load_users_tree ()) {
		throw CanNotFindData ();
	}
	UsersTree* users_tree = dynamic_cast<UsersTree*> (m_users_root->owner_tree ());
	if (users_tree && !user_profile.is_nil ()) {
		users_tree->register_listener (user_profile.in ());
	}

	return user_profile._retn ();
	//#UC END# *45EED57B01A1_4608BA7800DA*
}

// implemented method from UserManager
// получить дерево пользователей для группы с заданным идентификатором
NodeBase* UserManager_i::get_users_tree () const {
	//#UC START# *49C8C25A00FC_4608BA7800DA*
	if (m_users_root.is_nil () && !this->load_users_tree ()) {
		throw CanNotFindData ();
	}

	return m_users_root._sretn ();
	//#UC END# *49C8C25A00FC_4608BA7800DA*
}

// implemented method from UserManager
// общие ли фильтры пользователя
bool UserManager_i::has_shared_filters (Uid uid) const {
	//#UC START# *4E3BC517010A_4608BA7800DA*
	return ApplicationHelper::instance ()->get_cached_filters_manager ()->has_shared_filters (uid);
	//#UC END# *4E3BC517010A_4608BA7800DA*
}

// implemented method from UserManager
// может ли пользователь быть удалён
bool UserManager_i::is_erasable (Uid uid) const {
	//#UC START# *4E5F875701F4_4608BA7800DA*
	return ApplicationHelper::instance ()->get_cached_user_manager ()->is_erasable (uid);
	//#UC END# *4E5F875701F4_4608BA7800DA*
}

// implemented method from UserManager
void UserManager_i::logout_user (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/ {
	//#UC START# *45EED57B019F_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->logout_by_admin (uid);
	} catch (GslUserManager::BadGUID&) {
		throw CanNotFindData ();
	} catch (GCD::AccessDenied&) {
		throw  AccessDenied ();
	}
	//#UC END# *45EED57B019F_4608BA7800DA*
}

// implemented method from UserManager
// завершить работу в системе указанного списка пользователей.
void UserManager_i::logout_users (const UidList& list) const /*throw (AccessDenied)*/ {
	//#UC START# *4651A63100EA_4608BA7800DA*
	size_t list_size = list.size ();
	GCD::UidList server_list;
	server_list.length (list_size);
	for (size_t i = 0; i < list_size; ++i) {
		server_list[i] = list[i];
	}
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->logout_user_list_by_admin (server_list);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	}
	//#UC END# *4651A63100EA_4608BA7800DA*
}

// implemented method from UserManager
// установка политики оплаты консультаций для всех пользователей
void UserManager_i::set_consulting_payment_for_all (bool is_allowed) const /*throw (AccessDenied)*/ {
	//#UC START# *45EED57B01A2_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->set_consulting_payment_policy (true, is_allowed);
	} catch (GCD::AccessDenied&) {
		throw  AccessDenied ();
	}
	//#UC END# *45EED57B01A2_4608BA7800DA*
}

// implemented method from UserManager
// установка политики оплаты консультаций для новых пользователей
void UserManager_i::set_consulting_payment_for_newbies (bool is_allowed) const /*throw (AccessDenied)*/ {
	//#UC START# *45EED57B01A4_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->
			set_consulting_payment_policy (false, is_allowed);
		m_payment_status_for_newbies = is_allowed;
		m_is_payment_status_cached = true;
	} catch (GCD::AccessDenied&) {
		throw  AccessDenied ();
	}
	//#UC END# *45EED57B01A4_4608BA7800DA*
}

// implemented method from UserManager
// задать права на оплату консультаций для заданного списка пользователей.
void UserManager_i::set_consulting_rights (
	const UidList& list
	, bool is_payment_allowed
) const /*throw (
	AccessDenied
	, InternalDatabaseError
)*/ {
	//#UC START# *4651A670004E_4608BA7800DA*
	size_t list_size = list.size ();
	GCD::UidList server_list;
	server_list.length (list_size);
	for (size_t i = 0; i < list_size; ++i) {
		server_list[i] = list[i];
	}
	GCD::UidList_var result; 
	try {
		result = ApplicationHelper::instance ()->get_cached_user_manager ()->set_user_list_payment_rights (server_list, is_payment_allowed);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	}
	size_t bad_users_count = result->length ();
	if (bad_users_count) {
		throw InternalDatabaseError ();
	}
	//#UC END# *4651A670004E_4608BA7800DA*
}

// implemented method from UserManager
// установка свойства - можно ли удалить пользователя
void UserManager_i::set_erasable_state (Uid uid, bool state) const {
	//#UC START# *4E5F879F0339_4608BA7800DA*
	ApplicationHelper::instance ()->get_cached_user_manager ()->set_erasable_state (uid, state);
	//#UC END# *4E5F879F0339_4608BA7800DA*
}

// implemented method from UserManager
// установить список блоков базы по которым запрещён поиск группе пользователей
void UserManager_i::set_nonsearchable_blocks_for_group (
	Uid uid
	, const NodeIdList& blocks_ids
) const /*throw (
	AccessDenied
	, CanNotFindData
)*/ {
	//#UC START# *49C8CC1C0238_4608BA7800DA*
	try {
		GCD::ObjectIDList server_id_list; 
		server_id_list.length (blocks_ids.size ());
		for (size_t i = 0; i < blocks_ids.size (); ++i) {
			server_id_list[i] = blocks_ids[i];
		}
		ApplicationHelper::instance ()->get_cached_group_manager ()->
			set_nonsearchable_blocks_for_group (uid, server_id_list);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	//#UC END# *49C8CC1C0238_4608BA7800DA*
}

// implemented method from UserManager
// установить права привилегированности
void UserManager_i::set_privileged_rights (
	const UidList& list
	, bool is_privileged
) const /*throw (
	AccessDenied
	, XMLImportRunning
	, NoMorePrivilegedProfiles
)*/ {
	//#UC START# *473DC9D20144_4608BA7800DA*
	set_privileged_rights_i (list, is_privileged);
	//#UC END# *473DC9D20144_4608BA7800DA*
}

// implemented method from UserManager
// устанавливает флажок являются ли фильтры пользователя uid общими в соответствии со значением
// state
void UserManager_i::set_shared_filters_state (Uid uid, bool state) const {
	//#UC START# *4E3BC5700385_4608BA7800DA*
	ApplicationHelper::instance ()->get_cached_filters_manager ()->set_shared_filters_state (uid, state);
	//#UC END# *4E3BC5700385_4608BA7800DA*
}

// implemented method from UserManager
// Установка свойства - может ли данный пользователь платить за консультации
void UserManager_i::user_can_buy_consulting (
	Uid uid
	, bool is_allowed
) const /*throw (
	AccessDenied
	, CanNotFindData
	, LicenceViolation
	, XMLImportRunning
)*/ {
	//#UC START# *45EED57B019C_4608BA7800DA*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->set_user_payment_rights (uid, is_allowed);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (GslUserManager::BadUserKeyInfo&) {
		throw CanNotFindData ();
	} catch (GslUserManager::LicenceViolation&) {
		throw LicenceViolation ();
	} catch (GCD::XMLImportRunning&) {
		throw XMLImportRunning ();
	}
	//#UC END# *45EED57B019C_4608BA7800DA*
}

// implemented method from UserManager
// установить свойство привилегированности для пользователя
void UserManager_i::user_is_privileged (
	Uid uid
	, bool is_privileged
) const /*throw (
	AccessDenied
	, XMLImportRunning
	, NoMorePrivilegedProfiles
)*/ {
	//#UC START# *473DCA89000A_4608BA7800DA*
	UidList users_list;
	users_list.push_back (uid);
	set_privileged_rights_i (users_list, is_privileged);
	//#UC END# *473DCA89000A_4608BA7800DA*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

