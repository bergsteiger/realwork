////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::MDPFacadeSrv
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/LockViews/ToClearLockedPacks.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/LockViews/MDSupportServerAuthorization.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/ShowOnModelSrv.h"
#include "MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/AuthorizationSettings.h"

//#UC START# *462C9FB20331_CUSTOM_INCLUDES*
#include "ace/Codecs.h"
//#UC END# *462C9FB20331_CUSTOM_INCLUDES*


//#UC START# *462C9FB20331*
//#UC END# *462C9FB20331*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MDPFacadeSrv::MDPFacadeSrv ()
//#UC START# *462C978D01AA_462C9D8E0227_462C9FB20331_BASE_INIT*
: m_is_login (false)
, m_is_server_exist (false)
//#UC END# *462C978D01AA_462C9D8E0227_462C9FB20331_BASE_INIT*
{
	//#UC START# *462C978D01AA_462C9D8E0227_462C9FB20331_BODY*
	//#UC END# *462C978D01AA_462C9D8E0227_462C9FB20331_BODY*
}

MDPFacadeSrv::~MDPFacadeSrv () {
	//#UC START# *462C9FB20331_DESTR_BODY*
	this->logout ();
	//#UC END# *462C9FB20331_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MDPSupport::MDPFacade
// возвращает false если сервер залочек недоступен
bool MDPFacadeSrv::is_server_exist () const {
	//#UC START# *462C9CCE00DF_462C9FB20331*
	return m_is_server_exist;
	//#UC END# *462C9CCE00DF_462C9FB20331*
}

// implemented method from MDPSupport::MDPFacade
// начало сеанса работы с сервером залочек
bool MDPFacadeSrv::login () {
	//#UC START# *462C9C9D011E_462C9FB20331*
	class local {
	public:
		static std::string base64_decode (const std::string& src) {
			size_t decoded_length = 0;
			Core::Aptr<ACE_Byte, Core::ArrayDeleteDestructor<ACE_Byte> > decoded_buffer (
				ACE_Base64::decode (
					reinterpret_cast<const ACE_Byte*> (src.c_str ())
					, &decoded_length
				)
			);

			return std::string (reinterpret_cast<const char*> (decoded_buffer.ptr ()), decoded_length);
		}

		static std::string base64_encode (const std::string& src) {
			size_t encoded_length = 0;
			Core::Aptr<ACE_Byte, Core::ArrayDeleteDestructor<ACE_Byte> > encoded_buffer (
				ACE_Base64::encode (
					reinterpret_cast<const ACE_Byte*> (src.c_str ())
					, src.size ()
					, &encoded_length
				)
			);

			return std::string (reinterpret_cast<const char*> (encoded_buffer.ptr ()), encoded_length);
		}
	};
	m_is_login = false;
	m_is_server_exist = false;
	try {
		//ses: потому-что нет проверки - доступен сервер или нет
		RosePackageLocking::RosePackageLockingServer::PackageManagerFactory::instance ();
		m_is_server_exist = true;
	} catch (...) {
		return false;
	}
	
	std::string login;
	std::string paswd;

	//формат хранения авторизации:
	//1 - логин/пароль храниться в НЕзашифрованном виде
	//0 - логин/пароль не храниться (или не используется)
	//>1 - логин/пароль храниться в зашифрованном виде
	unsigned long saved_mdp_auth_format = AuthorizationSettings::get_use_saved_mdp_auth();
	bool use_saved = saved_mdp_auth_format > 0;

	if (use_saved) {
		login = AuthorizationSettings::get_saved_mdp_login();
		paswd = AuthorizationSettings::get_saved_mdp_paswd();
		
		if (saved_mdp_auth_format > 1) {
			//логин/пароль храниться в зашифрованном виде - нужно расшифровать
			login = local::base64_decode (login);
			paswd = local::base64_decode (paswd);
		} else {
			//нужно зашифровать пароль!
			std::string encoded_login = local::base64_encode (login);
			std::string encoded_passwd = local::base64_encode (paswd);

			AuthorizationSettings::set_saved_mdp_login(encoded_login);
			AuthorizationSettings::set_saved_mdp_paswd(encoded_passwd);
			
			AuthorizationSettings::set_use_saved_mdp_auth(2);
		}
	}

	bool res = false;
	if (login != "") {
		res = true;
	}
	
	MDSupportServerAuthorization auth_dlg;
	std::string error_message ("Не возможно авторизоваться на сервере!");
	while (true) {
		if (!res) {
			auth_dlg.set_init_login (login);
			auth_dlg.set_init_password (paswd);
			res = (auth_dlg.DoModal () == IDOK);
			if (res) {
				login = auth_dlg.get_result().login;
				paswd = auth_dlg.get_result().pass;
				use_saved = auth_dlg.get_result().use_saved_auth;
			}
		}
		if (res) {
			try {
				CoreSrv::SessionFactory::get().login (login.data(), paswd.data());
				m_is_login = true;
				LOG_I (("Login by %s", login.data()));

				MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
				RosePackageLocking::RosePackageLockingServer::LocksListener_var obj = cats_cont.get_listener ();
				RosePackageLocking::RosePackageLockingServer::PackageManagerFactory::instance ().add_locks_listener (obj.in ());
				
				LinkSupport::ConfModelLinks::ShowOnModel_var obj2 = ShowOnModelSrv::instance ()->_this ();
				LinkSupport::ConfModelLinks::ShowOnModelMngFactory::get().add_shower (obj2);
								
				if (use_saved) {
					AuthorizationSettings::set_saved_mdp_login (
						local::base64_encode (login)
					);
					AuthorizationSettings::set_saved_mdp_paswd (
						local::base64_encode (paswd)
					);

					AuthorizationSettings::set_use_saved_mdp_auth(2);
				} else {
					AuthorizationSettings::set_use_saved_mdp_auth(0);
				}
				
				break;
			} catch (CoreSrv::AccessDenied&) {
				error_message = "В доступе отказано.\r\nВозможно неправильно указан логин или пароль.";
			} catch (...) {
				//GenSupport::LogManagerFactory::get ().log_info ("Unknown exception while authorization on MDPSupport Server!");
			}
			res = false;
			if (AfxMessageBox (error_message.c_str (), MB_ICONEXCLAMATION|MB_RETRYCANCEL) != IDRETRY) {
				break;
			}
		} else {
			break;
		}
	}
	return res;
	//#UC END# *462C9C9D011E_462C9FB20331*
}

// implemented method from MDPSupport::MDPFacade
// окончание сеанса работы с сервером залочек
void MDPFacadeSrv::logout () {
	//#UC START# *462C9CA70208_462C9FB20331*
	try {
		if (true == m_is_login) {
			CoreSrv::SessionFactory::get().logout ();
			m_is_login = false;
		}
	} CATCH_AND_LOG ("while logout");
	//#UC END# *462C9CA70208_462C9FB20331*
}

// implemented method from MDPSupport::MDPFacade
// показывает блок диалога со списком  залоченных пакетов
void MDPFacadeSrv::show_locked () const {
	//#UC START# *462C9CEA01D9_462C9FB20331*	
	bool need_show = false;

	const MDPSupport::CatsLockStatus& cats_status = MDPSupport::CatsContainerFactory::get ().get_cats_lock_status ();
	MDPSupport::CatsLockStatus::const_iterator it = cats_status.begin ();
	MDPSupport::CatsLockStatus::const_iterator it_end = cats_status.end ();
	for (; it != it_end; ++it) {
		IRoseCategoryPtr cur;
		if (it->second.status == RosePackageLocking::RosePackageLockingServer::LS_LOCKED) {
			cur = MDPSupport::CatsContainerFactory::get ().get_cat_by_guid (it->first.c_str ());
			if (cur) {
				ChangedPackageInfo::instance ()->add_info (
					ChangedPackageInfo::Info (
						get_rose_element_uid(cur)
						, it->second.lock_owner_name
						, it->second.lock_time
						, ChangedPackageInfo::CT_LOCK
					)
				);
				need_show = true;
			}
		} else if (it->second.status == RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF) {
			cur = MDPSupport::CatsContainerFactory::get ().get_cat_by_guid (it->first.c_str ());
			if (cur) {
				ChangedPackageInfo::instance ()->add_info (
					ChangedPackageInfo::Info (
						get_rose_element_uid(cur)
						, "self"
						, it->second.lock_time
						, ChangedPackageInfo::CT_LOCK
					)
				);
				need_show = true;
			}
		}
	}

	if (need_show) {
		ChangedPackageInfo::instance ()->show ();
	}
	//#UC END# *462C9CEA01D9_462C9FB20331*
}

// implemented method from MDPSupport::MDPFacade
// синхронизирует модель (model) на сервере - получает статусы залочек пакетов с сервера
bool MDPFacadeSrv::sync (IRoseModelPtr model) {
	//#UC START# *462C9CF90285_462C9FB20331*
#ifndef GDS_NLOG_DEBUG
	::Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	IRoseCategoryCollectionPtr cats = model->GetAllCategories ();
	if (false == this->is_server_exist ()) {
		//ses: сервер не найден
		for (short i = 1; i <= cats->Count; ++i) {
			IRoseCategoryPtr cat = cats->GetAt (i);
			if (cat->IsControlled ()) {
				cat->Modifiable (true);
			}
		}
		return false;
	}
	
	MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
	cats_cont.clear_lock_status ();
	cats_cont.register_for_com_marshal (model);
	ChangedPackageInfo::instance ()->register_for_com_marshal (model->Application);

	if (false == m_is_login) {
		for (short i = 1; i <= cats->Count; ++i) {
			IRoseCategoryPtr cat = cats->GetAt (i);
			if (cat->IsControlled ()) {
				cat->Modifiable (false);
			}
		}
		return true;
	}

	for (short i = 1; i <= cats->Count; ++i) {
		IRoseCategoryPtr cat = cats->GetAt (i);
		if (cat->IsControlled ()) {
			cat->Modifiable (false);
		}
	}

	while (true) {
		try {
			RosePackageLocking::RosePackageLockingServer::PackageInfoSeq pis;
			pis.length (cats->Count);
			short controlled = 0;
			for (short i = 1; i <= cats->Count; ++i) {
				IRoseCategoryPtr cat = cats->GetAt (i);
				if (cat->IsControlled ()) {
					controlled++;
					pis.length (controlled);
					pis[controlled-1].guid = get_rose_element_uid(cat).c_str ();
					std::string sn = RoseHelper::create_full_name (cat);
					if (sn.empty ()) {
						LOG_E (("Full name is empty!!!"));
					}
					pis[controlled-1].full_name = sn.c_str ();
				}
			}

			RosePackageLocking::RosePackageLockingServer::PackageManagerFactory::instance ().sync (pis);

			controlled = 0;
			for (short i = 1; i <= cats->Count; ++i) {
				IRoseCategoryPtr cat = cats->GetAt (i);
				if (cat->IsControlled ()) {
					cats_cont.write_info (
						pis[controlled].guid.in ()
						, MDPSupport::LockInfo (
							pis[controlled].lock_status
							, std::string (pis[controlled].lock_owner_name.in ())
							, std::string (pis[controlled].time.in ())
						)
					);					
					if (RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF == pis[controlled].lock_status) {
						cat->Modifiable (true);
					} else {
						//LS_LOCKED
						cat->Modifiable (false);
					}
					controlled++;
				}
			}
			this->show_locked ();
			return true;
		} catch (...) {
			GenSupport::LogManagerFactory::get ().log_info ("Unknown exception while model synchronize!");
		}

		int code = AfxMessageBox ("Ошибки при сихронизации модели на сервере!", MB_RETRYCANCEL|MB_ICONSTOP);
		if (code == IDRETRY) {
			continue;
		} else {
			for (short i = 1; i <= cats->Count; ++i) {
				IRoseCategoryPtr cat = cats->GetAt (i);
				if (cat->IsControlled ()) {
					cat->Modifiable (false);
				}
			}
			break;
		}		
	}
	return true;
	//#UC END# *462C9CF90285_462C9FB20331*
}

// implemented method from MDPSupport::MDPFacade
// "закрывает" модель после синхронизации. Выполняется при закрытии модели.
bool MDPFacadeSrv::unsync (IRoseModelPtr model) {
	//#UC START# *462C9D150043_462C9FB20331*
#ifndef GDS_NLOG_DEBUG
	::Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif
	if (false == this->is_server_exist ()) {
		return false;
	}
	MDPSupport::CatsContainer& cats_cont = MDPSupport::CatsContainerFactory::get ();
	cats_cont.unregister_for_com_marshal (model);
	ChangedPackageInfo::instance ()->unregister_for_com_marshal ();

	if (true == cats_cont.get_cats_lock_status ().empty ()) {
		return true;
	}

	IRoseCategoryCollectionPtr cats = model->GetAllCategories ();
	ToClearLockedPacks dlg;
	std::map<std::string, IRoseCategoryPtr> full_name_to_cat;
	for (short i = 1; i <= cats->Count; ++i) {
		IRoseCategoryPtr cat = cats->GetAt (i);
		try {
			if (
				cat->IsControlled ()
				&& cats_cont.is_info_exists (get_rose_element_uid(cat)) == true
				&& RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF
					== cats_cont.get_info (get_rose_element_uid(cat)).status
			) {
				std::string sn = RoseHelper::create_full_name (cat);
				full_name_to_cat[sn] = cat;
				dlg.add_model_pack_full_name(sn.c_str ());
			}
		} catch (MDPSupport::LockInfoNotExists& ex) {
			LOG_E (("%s for package %s", ex.what (), get_rose_element_uid(cat)));
		}
	}
	
	std::map<std::string, std::string> full_name_to_guid;
	try {
		RosePackageLocking::RosePackageLockingServer::PackageInfoSeq_var locked_self = 
			RosePackageLocking::RosePackageLockingServer::PackageManagerFactory::instance ().get_self_locked ();

		CORBA::ULong size = locked_self->length ();

		for (CORBA::ULong i = 0; i < size; ++i) {
			RosePackageLocking::RosePackageLockingServer::PackageInfo& pi = locked_self[i];
			std::string pi_guid (pi.guid.in ());
			std::string full_name (pi.full_name.in ());
			if (
				full_name.empty () == false
				&& cats_cont.is_info_exists (pi_guid) == false
			) {
				//пакет с другой модели				
				full_name_to_guid[full_name] = pi_guid;
				dlg.add_other_pack_full_name (full_name);
				
			}
		}
	} catch (CORBA::SystemException& ex) {
		LOG_CEX ((ex, "While execute RosePackageLockingServer::PackageManager::get_self_locked ()"));
	} catch (CoreSrv::NoActiveFactory& ex) {
		LOG_CEX ((ex, "While execute RosePackageLockingServer::PackageManager::get_self_locked ()"));
		//сервер залочек недоступен - дальнейшая работа бессмысленна
		return false;
	} catch (...) {
		LOG_UEX (("Unknown exception while execute RosePackageLockingServer::PackageManager::get_self_locked ()"));
	}

	dlg.show_all ();
	GCL::StrSet::const_iterator it = dlg.get_model_packs_to_unlock ().begin ();
	GCL::StrSet::const_iterator it_end = dlg.get_model_packs_to_unlock ().end ();

	for (; it != it_end; ++it) {
		IRoseCategoryPtr cat = full_name_to_cat[*it];
		if (cat) {
			MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (cat);
			cl->commit ();
		} else {
			std::string name = cat->GetName ();
			LOG_E (("Trying to unlock unknown Package: %s", name.c_str ()));
		}
	}
	
	it = dlg.get_other_model_packs ().begin ();
	it_end = dlg.get_other_model_packs ().end ();
	
	for (; it != it_end; ++it) {
		std::string guid = full_name_to_guid[*it];
		if (guid.empty () == false) {
			try {
				RosePackageLocking::RosePackageLockingServer::PackageFactory::instance (guid.c_str ()).commit ();
			} CATCH_AND_LOG (("while unlock  %s", it->c_str ()));
		}
	}

	cats_cont.clear_lock_status ();

	return true;
	//#UC END# *462C9D150043_462C9FB20331*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

