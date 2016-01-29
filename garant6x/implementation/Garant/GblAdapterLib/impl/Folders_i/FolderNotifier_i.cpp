////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FolderNotifier_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Folders_i::FolderNotifier_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FolderNotifier_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/DoneNotifier_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FolderNotifier_i::FolderNotifier_i ()
//#UC START# *45FFD1B40251_BASE_INIT*
	: m_current_user (ApplicationHelper:: instance ()->get_cached_current_user_id ())
	, m_done_notifier (new DoneNotifier_i (this))
//#UC END# *45FFD1B40251_BASE_INIT*
{
	//#UC START# *45FFD1B40251_BODY*
	// можем принимать сообщения, только после того, как объект был сконструирован
	this->start_listen_common ();
	//#UC END# *45FFD1B40251_BODY*
}

FolderNotifier_i::~FolderNotifier_i () {
	//#UC START# *45FFCCC9000F_DESTR_BODY*
	try {
		this->stop_listen_common (); // отписываемся от сообщейний, пол учаемых через EventChanel (это нужно делать здесь)
	} catch (...) {
		LOG_D (("%s: unknown exception catched", GDS_CURRENT_FUNCTION));
		GDS_ASSERT (false);
	}
	//#UC END# *45FFCCC9000F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Возвращает true, если нотифаер готов обрабатывать нотификацию от сервера.
bool FolderNotifier_i::ready () const {
	//#UC START# *49DEFD89010A*
	return !m_external_folders_change_notifier.is_nil ();
	//#UC END# *49DEFD89010A*
}

void FolderNotifier_i::send_notify (NotifyStatus status, unsigned long folder_id) {
	//#UC START# *45FFD2C10203*
	NotifyData notify_data;
	notify_data.status = status;
	notify_data.done_notifier = Core::IObject::_duplicate (m_done_notifier.ptr ());
	Folders& folders_manager = FoldersFactory::make ();
	try {
		Core::GDS::StopWatch sw ("FolderNotifier_i::send_notify- update content");
		FoldersNode_var folders_node = folders_manager.find_folder_node (folder_id);
		FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (folders_node.ptr ());
		if (status == NS_NODE) {
			folders_node_i->update_children ();
			FoldersManager_i* folders_manager_i = dynamic_cast <FoldersManager_i*> (&folders_manager);
			folders_manager_i->recalc_shared_flags ();
		} else if (status == NS_CONTENT) {
			folders_node_i->update_content ();
		}
		notify_data.folder = Core::IObject::_duplicate (folders_node.ptr ());
		m_external_folders_change_notifier->fire (notify_data);
	} catch (...) {
		LOG_D (("Notified folder not found refresh Shared folder, update all folders!"));
		try {
			Node_var folders_node = folders_manager.get_root ();

//			m_folders->find_folder_node (GblFoldersAdap::CommonFolderID_c, folders_node.out ());
			if (notify_data.status == NS_NODE) {
				const FoldersNode_i* folders_node_i = 
					dynamic_cast <const FoldersNode_i*> (folders_node.ptr ());
				const_cast <FoldersNode_i*> (folders_node_i)->update_children ();

				FoldersManager_i* folders_manager_i = dynamic_cast <FoldersManager_i*> (&folders_manager);
				folders_manager_i->recalc_shared_flags ();
			}
			notify_data.folder =
				Core::IObject::_duplicate (dynamic_cast <FoldersNode*> (folders_node.ptr ()));
			dynamic_cast <DoneNotifier_i*> (m_done_notifier.ptr ())->clear_cache ();
			m_external_folders_change_notifier->fire (notify_data);
		} catch (...) {
			LOG_D (("Can't find common Shared folder!"));
		}
	}
	//#UC END# *45FFD2C10203*
}

// Установить оболочечный нотифайер
void FolderNotifier_i::set_external_folders_change_notifier (ExternalFoldersChangeNotifier* notifier) {
	//#UC START# *49DEFDAF0082*
	m_external_folders_change_notifier = ExternalFoldersChangeNotifier::_duplicate (notifier);
	m_done_notifier->done ();
	//#UC END# *49DEFDAF0082*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from GSI::NotifyService::Consumer
// Для получения сообщений реализация перекрывает этот метод.
void FolderNotifier_i::fire_event (const CORBA::Any& event) {
	//#UC START# *44A119280119_45FFCCC9000F*
	GblPilotDef::UserNotify* user_notify;
	try {
		if ((event >>= user_notify)) {
			if (user_notify->m_type == GblPilotDef::unt_FoldersChanged || user_notify->m_type == GblPilotDef::unt_consultation_folders_changed) {
				GblFolders::ChangedContent* change_content;
				user_notify->m_data >>= change_content;
				if (user_notify->m_type == GblPilotDef::unt_consultation_folders_changed || m_current_user != change_content->m_uid) {
					dynamic_cast<DoneNotifier_i*>(m_done_notifier.ptr ())->
						add_notify_data (
							NotifierStatusConvertorSingleton::instance ()->get (change_content->m_status)
							, change_content->m_id
						);
				}
			}
		}
	} catch (...) {
		LOG_D (("Exception while update folder by notify!"));
	}
	//#UC END# *44A119280119_45FFCCC9000F*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

