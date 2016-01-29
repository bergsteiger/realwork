////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatsContainerImpl
//
// реализация интерфейса контэйнера катов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *47D140840220_CUSTOM_INCLUDES*
//#UC END# *47D140840220_CUSTOM_INCLUDES*


//#UC START# *47D140840220*
//#UC END# *47D140840220*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CatsContainerImpl::CatsContainerImpl ()
//#UC START# *45EBCC4500D7_462DC25B01A5_47D140840220_BASE_INIT*
: m_current_model_id (0), m_listener (new LocksListenerImpl ())
//#UC END# *45EBCC4500D7_462DC25B01A5_47D140840220_BASE_INIT*
{
	//#UC START# *45EBCC4500D7_462DC25B01A5_47D140840220_BODY*
	m_git.CreateInstance (CLSID_StdGlobalInterfaceTable);
	//#UC END# *45EBCC4500D7_462DC25B01A5_47D140840220_BODY*
}

CatsContainerImpl::~CatsContainerImpl () {
	//#UC START# *47D140840220_DESTR_BODY*
	//#UC END# *47D140840220_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MDPSupport::CatsContainer
// статусы залочек
const MDPSupport::CatsLockStatus& CatsContainerImpl::get_cats_lock_status () const {
	//#UC START# *45EECDFE029F_47D140840220_GET*
	return m_cats_lock_status;
	//#UC END# *45EECDFE029F_47D140840220_GET*
}

// implemented method from MDPSupport::CatsContainer
// очищает список залочек
void CatsContainerImpl::clear_lock_status () {
	//#UC START# *47C40AFF03DA_47D140840220*
	m_cats_lock_status.clear ();
	//#UC END# *47C40AFF03DA_47D140840220*
}

// implemented method from MDPSupport::CatsContainer
// получить кат по его гуиду
IRoseCategoryPtr CatsContainerImpl::get_cat_by_guid (const char* guid) const {
	//#UC START# *45F7E7F7022E_47D140840220*
	IRoseModelPtr model;
	{
		GUARD(m_git_mutex);
		m_git->GetInterfaceFromGlobal (m_current_model_id, __uuidof (IRoseModel), (void**)&model);
	}
	if (model) {
		return model->FindCategoryWithID (guid);
	}
	return 0;
	//#UC END# *45F7E7F7022E_47D140840220*
}

// implemented method from MDPSupport::CatsContainer
// получить информацию о залочке
const MDPSupport::LockInfo& CatsContainerImpl::get_info (
	const std::string& key
) const /*throw (
	MDPSupport::LockInfoNotExists
)*/ {
	//#UC START# *47D6248A030F_47D140840220*
	MDPSupport::CatsLockStatus::const_iterator it = m_cats_lock_status.find (key);
	if (it != m_cats_lock_status.end ()) {
		return it->second;
	}
	throw MDPSupport::LockInfoNotExists ();
	//#UC END# *47D6248A030F_47D140840220*
}

// implemented method from MDPSupport::CatsContainer
// возвращает объект подписчик (несмотря на то, что метод не кэшированный - реальный  объект
// возвращается всегда один и тот же)
RosePackageLocking::RosePackageLockingServer::LocksListener* CatsContainerImpl::get_listener () {
	//#UC START# *47D61C73039C_47D140840220*
	return m_listener->_this ();
	//#UC END# *47D61C73039C_47D140840220*
}

// implemented method from MDPSupport::CatsContainer
// возвращает true, если есть информация о залочке
bool CatsContainerImpl::is_info_exists (const std::string& key) const {
	//#UC START# *47D627B200A4_47D140840220*
	MDPSupport::CatsLockStatus::const_iterator it = m_cats_lock_status.find (key);
	return it != m_cats_lock_status.end ();
	//#UC END# *47D627B200A4_47D140840220*
}

// implemented method from MDPSupport::CatsContainer
// регистрирует интерфейс для комовского маршалинга, нужно для вывзова из не майн потока, в котором
// обрабатываются вызовы от сервера залочек
void CatsContainerImpl::register_for_com_marshal (IRoseModelPtr model) {
	//#UC START# *462CBBB00321_47D140840220*
	GUARD(m_git_mutex);
	m_git->RegisterInterfaceInGlobal (model.GetInterfacePtr (), __uuidof (IRoseModel), &m_current_model_id);
	//#UC END# *462CBBB00321_47D140840220*
}

// implemented method from MDPSupport::CatsContainer
// unregister для интерфейс
void CatsContainerImpl::unregister_for_com_marshal (IRoseModelPtr model) {
	//#UC START# *462CBBD40341_47D140840220*
	GUARD(m_git_mutex);
	m_git->RevokeInterfaceFromGlobal (m_current_model_id);
	m_current_model_id = 0;
	//#UC END# *462CBBD40341_47D140840220*
}

// implemented method from MDPSupport::CatsContainer
// записывает информацию о залочке
void CatsContainerImpl::write_info (const std::string& key, const MDPSupport::LockInfo& info) {
	//#UC START# *47D622DA031A_47D140840220*
	m_cats_lock_status[key] = info;
	//#UC END# *47D622DA031A_47D140840220*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

