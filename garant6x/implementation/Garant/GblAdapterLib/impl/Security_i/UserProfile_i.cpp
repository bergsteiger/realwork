////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserProfile_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i.h"
// by <<uses>> dependencies
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserProfile_i::UserProfile_i (
	long uid
	, const char* login
	, const char* name
	, const char* mail
	, bool is_system
	, bool has_password
	, bool can_buy_consulting
	, bool is_privileged
)
//#UC START# *4608DBA7006D_BASE_INIT*
	: m_uid (uid)
	, m_login (GCI::IO::StringFactory::make (login))
	, m_name (GCI::IO::StringFactory::make (name))
	, m_mail (GCI::IO::StringFactory::make (mail))
	, m_is_system (is_system)
	, m_has_password (has_password)
	, m_can_buy_consulting (can_buy_consulting)
	, m_is_privileged (is_privileged)
//#UC END# *4608DBA7006D_BASE_INIT*
{
	//#UC START# *4608DBA7006D_BODY*
	//#UC END# *4608DBA7006D_BODY*
}

UserProfile_i::~UserProfile_i () {
	//#UC START# *4608CCA80119_DESTR_BODY*
	this->unregister_object ();
	//#UC END# *4608CCA80119_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ActiveChangeable
void UserProfile_i::acquire_update_mutex () {
	//#UC START# *4601162A008C_4608CCA80119*
	m_update_mutex.acquire ();
	//#UC END# *4601162A008C_4608CCA80119*
}

// implemented method from ActiveChangeable
void UserProfile_i::release_update_mutex () {
	//#UC START# *460116360399_4608CCA80119*
	m_update_mutex.release ();
	//#UC END# *460116360399_4608CCA80119*
}

// implemented method from ActiveChangeable
void UserProfile_i::update_cache (const CORBA::Any& hint) {
	//#UC START# *460115F6007D_4608CCA80119*
	GUARD (m_update_mutex);

	GTree::ChangeDelta* change_delta;
	if (hint >>= change_delta) {
		const GTree::ChangeDataList& ch_node_list = change_delta->changed_nodes ();

		for (CORBA::ULong i = 0; i < ch_node_list.length (); ++i) {
			const GTree::ChangeData& changed_node_data = ch_node_list[i];
			const GTree::ChangeNodeData& data = changed_node_data.changed_data;

			if (data.change_mask & GTree::CMC_ENTITY_CHANGED) {
				GslUserManager::UserProfileInfo* info;
				if ((data.entity >>= info) && (this->m_uid == info->m_uid)) {
					m_name->reset (info->m_name.in ());
					m_mail->reset (info->m_mail.in ());
					m_is_system = info->m_system;
					m_has_password = info->m_has_password;
					m_can_buy_consulting = info->m_can_buy_consulting;
				}
			}
		} 
		return;
	}

	GTree::InsertDelta* insert_delta;
	if (hint >>= insert_delta) {
		const GTree::DeltaRootDataList& delta_list = insert_delta->data ();
		if (insert_delta->for_created_node ()._d() == GTree::CNIT_OBJECT_ID) {
			const GCD::PID& pid = insert_delta->for_created_node ().object_id ();
			GDS_ASSERT (pid.m_class_id == Defines::CI_USER);

			if (pid.m_object_id == this->m_uid) {
				GslUserManager::UserInfo_var user_info (ApplicationHelper::instance ()->get_cached_user_manager ()->get_user_info (pid.m_object_id));
				if (user_info.ptr ()) {
					m_name->reset (user_info->m_name.in ());
					m_mail->reset (user_info->m_mail.in ());
				}
			}
		}
		return;
	}
	//#UC END# *460115F6007D_4608CCA80119*
}

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* UserProfile_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_4608CCA80119*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_4608CCA80119*
}

// implemented method from EntityBase
// идентификатор
const unsigned long UserProfile_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_4608CCA80119_GET*
	throw Unsupported ();
	//#UC END# *456EE084033C_4608CCA80119_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool UserProfile_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_4608CCA80119_GET*
	return false;
	//#UC END# *456EB3E1017D_4608CCA80119_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool UserProfile_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_4608CCA80119_GET*
	return true;
	//#UC END# *456EB3E1017C_4608CCA80119_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* UserProfile_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_4608CCA80119*
	throw Unsupported ();
	//#UC END# *456EB3E10178_4608CCA80119*
}

// implemented method from UserProfile
bool UserProfile_i::can_buy_consulting () const {
	//#UC START# *45EED78501BD_4608CCA80119*
	return m_can_buy_consulting;
	//#UC END# *45EED78501BD_4608CCA80119*
}

// implemented method from UserProfile
const GCI::IO::String& UserProfile_i::get_login () const {
	//#UC START# *45EED78501B7_4608CCA80119*
	return *(m_login.in ());
	//#UC END# *45EED78501B7_4608CCA80119*
}

// implemented method from UserProfile
const GCI::IO::String& UserProfile_i::get_mail () const {
	//#UC START# *45EED78501BA_4608CCA80119*
	return *(m_mail.in ());
	//#UC END# *45EED78501BA_4608CCA80119*
}

// implemented method from UserProfile
const GCI::IO::String& UserProfile_i::get_name () const {
	//#UC START# *45EED78501B9_4608CCA80119*
	return *(m_name.in ());
	//#UC END# *45EED78501B9_4608CCA80119*
}

// implemented method from UserProfile
long UserProfile_i::get_uid () const {
	//#UC START# *45EED78501BB_4608CCA80119*
	return m_uid;
	//#UC END# *45EED78501BB_4608CCA80119*
}

// implemented method from UserProfile
// идентификатор группы, к которой принадлежит пользователь.
const Uid UserProfile_i::get_group_id () const
	/*throw (AccessDenied)*/
{
	//#UC START# *49DC72900077_4608CCA80119_GET*
	try {
		GCD::UidList_var uid_list (ApplicationHelper::instance ()->get_cached_group_manager ()->get_groups_for_user (this->get_uid ()));
		GDS_ASSERT (!(uid_list->length () > 2));

		for (size_t i = 0; i < uid_list->length (); ++i) {
			if (uid_list[i] != GCD::BaseUsersGroup) {
				return uid_list[i];
			}
		}
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GslUserManager::BadGUID&) {
		GDS_ASSERT (false);
	}

	return GCD::BaseUsersGroup;
	//#UC END# *49DC72900077_4608CCA80119_GET*
}

// implemented method from UserProfile
bool UserProfile_i::has_password () const {
	//#UC START# *45EED78501B8_4608CCA80119*
	return m_has_password;
	//#UC END# *45EED78501B8_4608CCA80119*
}

// implemented method from UserProfile
// привилегированный пользователь
bool UserProfile_i::is_privileged () const {
	//#UC START# *473DCDF900ED_4608CCA80119*
	return m_is_privileged;
	//#UC END# *473DCDF900ED_4608CCA80119*
}

// implemented method from UserProfile
bool UserProfile_i::is_system () const {
	//#UC START# *45EED78501BC_4608CCA80119*
	return m_is_system;
	//#UC END# *45EED78501BC_4608CCA80119*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

