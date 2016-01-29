////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerFacadeImpl
//
// реализация интерфейса обертки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CatLockerFacadeImpl::CatLockerFacadeImpl (IRoseCategoryPtr cat)
//#UC START# *46343B0002BF_46343B2E0177_47D1451002F1_BASE_INIT*
: m_cat ((MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) ? cat: 0)
, m_is_change_mode (false)
//#UC END# *46343B0002BF_46343B2E0177_47D1451002F1_BASE_INIT*
{
	//#UC START# *46343B0002BF_46343B2E0177_47D1451002F1_BODY*
	//#UC END# *46343B0002BF_46343B2E0177_47D1451002F1_BODY*
}

CatLockerFacadeImpl::CatLockerFacadeImpl (IRoseElementPtr elem)
//#UC START# *46343B0002BF_46343B3A037A_47D1451002F1_BASE_INIT*
: m_cat ((MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) ? RoseHelper::get_nearest_controllable_unit (elem): 0)
, m_is_change_mode (false)
//#UC END# *46343B0002BF_46343B3A037A_47D1451002F1_BASE_INIT*
{
	//#UC START# *46343B0002BF_46343B3A037A_47D1451002F1_BODY*
	//#UC END# *46343B0002BF_46343B3A037A_47D1451002F1_BODY*
}

CatLockerFacadeImpl::~CatLockerFacadeImpl () {
	//#UC START# *47D1451002F1_DESTR_BODY*
	if (0 != m_cat && m_is_change_mode) {
		MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (m_cat);
		if (
			true == cl->has_lock_status ()
			&& RosePackageLocking::RosePackageLockingServer::LS_FREE == cl->get_lock_status ()
		) {
			m_cat->Modifiable (false);
		}
	}
	//#UC END# *47D1451002F1_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MDPSupport::CatLockerFacade
// возвращает true если кат можно менять
bool CatLockerFacadeImpl::can_change () const {
	//#UC START# *46343BFC035B_47D1451002F1*
	if (0 != m_cat) {
		MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (m_cat);
		if (
			cl->has_lock_status ()
			&& RosePackageLocking::RosePackageLockingServer::LS_LOCKED == cl->get_lock_status ()
		) {
			return false;
		}
	}
	return true;
	//#UC END# *46343BFC035B_47D1451002F1*
}

// implemented method from MDPSupport::CatLockerFacade
// возвращает true, если кат можно отлочить
bool CatLockerFacadeImpl::can_commit () const {
	//#UC START# *46343C0B02AF_47D1451002F1*
	if (0 != m_cat) {
		MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (m_cat);
		if (
			cl->has_lock_status ()
			&& RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF == cl->get_lock_status ()
		) {
			return true;
		}
	}
	return false;
	//#UC END# *46343C0B02AF_47D1451002F1*
}

// implemented method from MDPSupport::CatLockerFacade
// возвращает true, если кат можно залочить
bool CatLockerFacadeImpl::can_lock () const {
	//#UC START# *46343C0400BB_47D1451002F1*
	if (0 != m_cat) {
		MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (m_cat);
		if (
			cl->has_lock_status ()
			&& RosePackageLocking::RosePackageLockingServer::LS_FREE == cl->get_lock_status ()
		) {
			return true;
		}
	}
	return false;
	//#UC END# *46343C0400BB_47D1451002F1*
}

// implemented method from MDPSupport::CatLockerFacade
// возвращает true, если изменения в кат можно удачно откатить
bool CatLockerFacadeImpl::can_rollback () const {
	//#UC START# *46343C2B02FD_47D1451002F1*
	return this->can_commit ();
	//#UC END# *46343C2B02FD_47D1451002F1*
}

// implemented method from MDPSupport::CatLockerFacade
// модфикация окончена удачно, принять изменения. Если модификация была не удачной,  то в
// деструкторе CatLockerFacade изменения будут откатаны.
void CatLockerFacadeImpl::do_change () {
	//#UC START# *46344A7802AF_47D1451002F1*
	if (0 != m_cat) {
		MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (m_cat);
		if (cl->has_lock_status ()) {
			RosePackageLocking::RosePackageLockingServer::LockStatus ls = cl->get_lock_status ();
			switch (ls) {
				case RosePackageLocking::RosePackageLockingServer::LS_LOCKED:
					GDS_ASSERT (0);
					break;
				case RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF:
					break;
				case RosePackageLocking::RosePackageLockingServer::LS_FREE:
					cl->modify ();
					break;
			}
		}
	}
	//#UC END# *46344A7802AF_47D1451002F1*
}

// implemented method from MDPSupport::CatLockerFacade
// начать модификацию элемента
bool CatLockerFacadeImpl::try_change () {
	//#UC START# *46343C9B006D_47D1451002F1*
	if (0 != m_cat && !m_cat->IsModifiable ()) {
		if (this->can_change ()) {
			m_is_change_mode = true;
			m_cat->Modifiable (true);
		} else {
			return false;
		}
	}
	return true;
	//#UC END# *46343C9B006D_47D1451002F1*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

