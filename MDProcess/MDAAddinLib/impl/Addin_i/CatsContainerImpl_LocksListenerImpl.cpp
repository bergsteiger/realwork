////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl_LocksListenerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::CatsContainerImpl::LocksListenerImpl
//
// реализация серверного callback
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

class CatsContainerImpl;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CatsContainerImpl::LocksListenerImpl::~LocksListenerImpl () {
	//#UC START# *47D61CD901FA_DESTR_BODY*
	//#UC END# *47D61CD901FA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from RosePackageLocking::RosePackageLockingServer::LocksListener
// lock_changed - событие о том, что состояние залочки пакета поменялся юзером by_user.
void CatsContainerImpl::LocksListenerImpl::lock_changed (
	RosePackageLocking::RosePackageLockingServer::PackageGUID_const guid
	, const char* by_user
	, const char* time
	, RosePackageLocking::RosePackageLockingServer::LockChange what
) throw (
	CORBA::SystemException
) {
	//#UC START# *45E6AA080099_47D61CD901FA*
	
	MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
	IRoseCategoryPtr cat = cats_cont.get_cat_by_guid (guid);
	if (NULL == cat) {
		return;
	}
	
	if (what == RosePackageLocking::RosePackageLockingServer::LC_LOCK) {
		std::string info ("<");
		info += by_user;
		info += "> захватил \"";
		info += RoseHelper::create_full_name (cat);
		info += "\"";
		GenSupport::LogManagerFactory::get ().log_info (info.c_str ());

		cats_cont.write_info (
			guid
			, MDPSupport::LockInfo (
				RosePackageLocking::RosePackageLockingServer::LS_LOCKED
				, std::string (by_user)
				, std::string (time)
			)
		);

		cat->Modifiable (false);
		
		ChangedPackageInfo::instance ()->add_info (
			ChangedPackageInfo::Info (
				get_rose_element_uid(cat)
				, std::string (by_user)
				, std::string (time)
				, ChangedPackageInfo::CT_LOCK
			)
		);
	} else if (what == RosePackageLocking::RosePackageLockingServer::LC_UNLOCK) {
		std::string info ("<");
		info += by_user;
		info += "> освободил \"";
		info += RoseHelper::create_full_name (cat);
		info += "\"";
		GenSupport::LogManagerFactory::get ().log_info (info.c_str ());

		ChangedPackageInfo::instance ()->add_info (
			ChangedPackageInfo::Info (
				get_rose_element_uid(cat)
				, std::string (by_user)
				, std::string (time)
				, ChangedPackageInfo::CT_UNLOCK
			)
		);
		ChangedPackageInfo::instance ()->show ();
		//::MessageBox (0, buf, "MDAGenerator", MB_OK|MB_ICONWARNING);
	} else if (what == RosePackageLocking::RosePackageLockingServer::LC_ROLLBACK) {
		std::string info ("<");
		info += by_user;
		info += "> освободил \"";
		info += RoseHelper::create_full_name (cat);
		info += "\" и отменил свои изменения";
		
		GenSupport::LogManagerFactory::get ().log_info (info.c_str ());

		cats_cont.write_info (
			guid
			, MDPSupport::LockInfo (
				RosePackageLocking::RosePackageLockingServer::LS_FREE
				, std::string (by_user)
				, std::string (time)
			)
		);		
	}
	//#UC END# *45E6AA080099_47D61CD901FA*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

