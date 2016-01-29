////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerSrv
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv.h"
// by <<uses>> dependencies
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"


//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// возвращает текущее время и дату в виде строки
const std::string CatLockerSrv::get_time () {
	//#UC START# *47677D3A03A0*
	ACE_Time_Value time = ACE_OS::gettimeofday ();
	const size_t TIMESTAMP_SIZE = 26;
	ACE_TCHAR timestamp[TIMESTAMP_SIZE];

	const ACE_TCHAR *time_fmt = ACE_LIB_TEXT ("%s %s %s");
	time_t now = time.sec ();
	ACE_TCHAR ctp[TIMESTAMP_SIZE]; // 26 is a magic number...

	if (ACE_OS::ctime_r (&now, ctp, sizeof ctp) == 0) {
		return std::string ();
	}
	/* 01234567890123456789012345 */
	/* Wed Oct 18 14:25:36 1989n0 */
	
	ctp[10] = '\0'; // NUL-terminate after the data.
	ctp[19] = '\0'; // NUL-terminate after the time.
	ctp[24] = '\0'; // NUL-terminate after the year.

	ACE_OS::snprintf (
		timestamp
		,TIMESTAMP_SIZE
		, time_fmt
		, ctp
		, ctp + 20
		, ctp + 11
	);
	
	return std::string (timestamp);
	//#UC END# *47677D3A03A0*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CatLockerSrv::CatLockerSrv (IRoseCategoryPtr cat)
//#UC START# *462C8854011E_462C88E400A1_462C9FF30043_BASE_INIT*
: m_cat (cat)
//#UC END# *462C8854011E_462C88E400A1_462C9FF30043_BASE_INIT*
{
	//#UC START# *462C8854011E_462C88E400A1_462C9FF30043_BODY*
	//#UC END# *462C8854011E_462C88E400A1_462C9FF30043_BODY*
}

CatLockerSrv::~CatLockerSrv () {
	//#UC START# *462C9FF30043_DESTR_BODY*
	//#UC END# *462C9FF30043_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// можно ли выполнить коммит
bool CatLockerSrv::can_commit_i (bool need_assertion) const {
	//#UC START# *462CAA8D00EF*
	if (false == MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) {
		return false;
	}
	
	MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
	bool info_exists = cats_cont.is_info_exists (get_rose_element_uid(m_cat));
	if (info_exists == false) {
		if (need_assertion) {
			GenSupport::LogManagerFactory::get ().log_error ("Unlock failed! Package in not under control.");
			AfxMessageBox ("Не возможно разлочить этот пакет!", MB_ICONEXCLAMATION);
		}
		return false;
	} 
	const MDPSupport::LockInfo& lock_info = cats_cont.get_info (get_rose_element_uid(m_cat));
	if (RosePackageLocking::RosePackageLockingServer::LS_FREE == lock_info.status) {
		if (need_assertion) {
			GenSupport::LogManagerFactory::get ().log_error ("Unlock failed! Package free.");
			AfxMessageBox ("Не возможно разлочить этот пакет!", MB_ICONEXCLAMATION);
		}
		return false;
	} else if (RosePackageLocking::RosePackageLockingServer::LS_LOCKED == lock_info.status) {
		if (need_assertion) {
			GenSupport::LogManagerFactory::get ().log_error ("Unlock failed! Package locked by another user.");
			AfxMessageBox ("Не возможно разлочить этот пакет!", MB_ICONEXCLAMATION);
		}
		return false;
	}
	return true;
	//#UC END# *462CAA8D00EF*
}

// можно ли начать модификацию
bool CatLockerSrv::can_modify_i (bool need_assertion) const {
	//#UC START# *462CAAAE0072*
	if (false == MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) {
		return false;
	}

	if (false == m_cat->IsControlled ()) {
		if (need_assertion) {
			GenSupport::LogManagerFactory::get ().log_error ("Lock failed! Package in not under control.");
			AfxMessageBox ("Не возможно залочить этот пакет!", MB_ICONEXCLAMATION);
		}
		return false;
	}
	
	MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
	if (
		cats_cont.is_info_exists (get_rose_element_uid(m_cat)) == true
		&& cats_cont.get_info (get_rose_element_uid(m_cat)).status == RosePackageLocking::RosePackageLockingServer::LS_LOCKED
	) {
		if (need_assertion) {
			GenSupport::LogManagerFactory::get ().log_error ("Lock failed! Package locked by another user.");
			AfxMessageBox ("Не возможно залочить этот пакет!", MB_ICONEXCLAMATION);
		}
		return false;
	}
	return true;
	//#UC END# *462CAAAE0072*
}

// можно ли откатить изменения
bool CatLockerSrv::can_rollback_i (bool need_assertion) const {
	//#UC START# *462CAABD03AE*
	return this->can_commit_i (false);
	//#UC END# *462CAABD03AE*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MDPSupport::CatLocker
// Разлочивает пакет. Возвращает false в случие ошибки.
bool CatLockerSrv::commit () {
	//#UC START# *462C890A03DD_462C9FF30043*
	if (false == MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) {
		return false;
	}

	if (false == this->can_commit_i (true)) {
		return false;
	}

	std::string buf ("Unlock ");
	buf += get_rose_element_uid(m_cat);
	
	GenSupport::LogManagerFactory::get ().log_info (buf.c_str ());	

	try {
		std::string time = get_time ();
		MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
		RosePackageLocking::RosePackageLockingServer::PackageFactory::instance (get_rose_element_uid(m_cat).c_str ()).commit ();
		cats_cont.write_info (
			get_rose_element_uid(m_cat)
			, MDPSupport::LockInfo (
				RosePackageLocking::RosePackageLockingServer::LS_FREE
				, std::string ("")
				, time
			)
		);
		if (false == m_cat->Save ()) {
			AfxMessageBox ("Save failed!", MB_ICONEXCLAMATION);
			m_cat->Modifiable (false);
			return false;
		}
		m_cat->Modifiable (false);
		ChangedPackageInfo::instance ()->add_info (
			ChangedPackageInfo::Info (
				get_rose_element_uid(m_cat)
				, "self"
				, time
				, ChangedPackageInfo::CT_UNLOCK
			)
		);
		return true;
	} catch (RosePackageLocking::RosePackageLockingServer::LockFailed&) {
	} catch (...) {
	}
	AfxMessageBox ("Разлочка пакета закончилась неудачей!", MB_ICONSTOP);
	return false;
	//#UC END# *462C890A03DD_462C9FF30043*
}

// implemented method from MDPSupport::CatLocker
// возвращает false, если пакет находится под управлением сервера залочек.
bool CatLockerSrv::has_lock_status () const {
	//#UC START# *46344BD802FD_462C9FF30043*
	return MDPSupport::CatsContainerFactory::get ().is_info_exists (get_rose_element_uid(m_cat));
	//#UC END# *46344BD802FD_462C9FF30043*
}

// implemented method from MDPSupport::CatLocker
// статус залочки пакета
RosePackageLocking::RosePackageLockingServer::LockStatus CatLockerSrv::get_lock_status () const {
	//#UC START# *463443E7003E_462C9FF30043_GET*
	return MDPSupport::CatsContainerFactory::get ().get_info (get_rose_element_uid(m_cat)).status;
	//#UC END# *463443E7003E_462C9FF30043_GET*
}

// implemented method from MDPSupport::CatLocker
// Лочит пакет для можификации. Возвращает false если пакет уже кем-то залочен.
bool CatLockerSrv::modify () {
	//#UC START# *462C88D400B0_462C9FF30043*
	if (false == MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) {
		return false;
	}

	if (false == this->can_modify_i (true)) {
		return false;
	}

	std::string buf ("Lock ");
	buf += get_rose_element_uid(m_cat);	
	GenSupport::LogManagerFactory::get ().log_info (buf.c_str ());	

	try {
		std::string time = get_time ();

		MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
		RosePackageLocking::RosePackageLockingServer::PackageFactory::instance (get_rose_element_uid(m_cat).c_str ()).modify ();
		
		cats_cont.write_info (
			get_rose_element_uid(m_cat)
			, MDPSupport::LockInfo (
				RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF
				, std::string ("self")
				, time
			)
		);

		m_cat->Modifiable (true);
		ChangedPackageInfo::instance ()->add_info (
			ChangedPackageInfo::Info (
				get_rose_element_uid(m_cat)
				, "self"
				, time
				, ChangedPackageInfo::CT_LOCK
			)
		);
		return true;
	} catch (RosePackageLocking::RosePackageLockingServer::LockFailed&) {
	} catch (...) {
	}
	AfxMessageBox ("Залочка пакета закончилась неудачей!", MB_ICONSTOP);
	return false;
	//#UC END# *462C88D400B0_462C9FF30043*
}

// implemented method from MDPSupport::CatLocker
// Откатывает изменения.
bool CatLockerSrv::rollback () {
	//#UC START# *462C891700EF_462C9FF30043*
	if (false == MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) {
		return false;
	}

	if (false == this->can_rollback_i (true)) {
		return false;
	}

	std::string buf ("Rollback ");
	buf += get_rose_element_uid(m_cat);	
	GenSupport::LogManagerFactory::get ().log_info (buf.c_str ());


	try {
		std::string time = get_time ();
		
		MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
		RosePackageLocking::RosePackageLockingServer::PackageFactory::instance (get_rose_element_uid(m_cat).c_str ()).rollback ();
		
		cats_cont.write_info (
			get_rose_element_uid(m_cat)
			, MDPSupport::LockInfo (
				RosePackageLocking::RosePackageLockingServer::LS_FREE
				, std::string ("")
				, time
			)
		);		
		m_cat->Modifiable (false);
		return true;
	} catch (RosePackageLocking::RosePackageLockingServer::LockFailed&) {
	} catch (...) {
	}
	AfxMessageBox ("Залочка пакета закончилась неудачей!", MB_ICONSTOP);
	return false;
	//#UC END# *462C891700EF_462C9FF30043*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

