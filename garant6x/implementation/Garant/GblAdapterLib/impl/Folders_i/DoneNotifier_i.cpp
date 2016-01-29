////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/DoneNotifier_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Folders_i::DoneNotifier_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/DoneNotifier_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DoneNotifier_i::DoneNotifier_i (FolderNotifier_i* servant)
//#UC START# *45FFCC7F0157_BASE_INIT*
	: m_notifier (servant)
	, m_fire_done (true)
//#UC END# *45FFCC7F0157_BASE_INIT*
{
	//#UC START# *45FFCC7F0157_BODY*
	//#UC END# *45FFCC7F0157_BODY*
}

DoneNotifier_i::~DoneNotifier_i () {
	//#UC START# *45FFCBD60196_DESTR_BODY*
	//#UC END# *45FFCBD60196_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void DoneNotifier_i::add_notify_data (NotifyStatus status, unsigned long folder_id) {
	//#UC START# *45FFDBD202DE*
	// Если мы не в процессе обработки нотификации - посылаем нотификацию
	if (m_fire_done && m_notifier->ready ()) {
		{
			GUARD (m_done_mutex);
			m_fire_done = false;
		}
		//LOG_D (("Send notify"));
		m_notifier->send_notify (status, folder_id);
	} else {
		GUARD (m_done_mutex);
		//LOG_D (("Add to array"));
		Notify data;
		data.status = status;
		data.folder_id = folder_id;
		m_notify_data_list.push (data);
	}
	//#UC END# *45FFDBD202DE*
}

void DoneNotifier_i::clear_cache () {
	//#UC START# *45FFDBFF01B5*
	GUARD (m_done_mutex);
	//m_notify_data_list.clear ();
	//#UC END# *45FFDBFF01B5*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DoneNotifier
bool DoneNotifier_i::done () {
	//#UC START# *45EEDB8B032F_45FFCBD60196*
	GDS_ASSERT (m_notifier->ready ()); // Попытка сказать done без инициализации нотифаера start_processing_folder_notification
	bool ret = true;
	{
		GUARD (m_done_mutex);
		m_fire_done = true;
	}
	// Список необработанных нотификаций не пуст - отправить очередную нотификацию 
	//LOG_D (("DoneNotifier_i::done"));
	if (!m_notify_data_list.empty ()) {
		//LOG_D (("Notify array size=%d", m_notify_data_list.size ()));
		Notify data;
		{
			GUARD (m_done_mutex);
			m_fire_done = false;
			data = m_notify_data_list.front ();
			m_notify_data_list.pop ();
		}
		m_notifier->send_notify (data.status, data.folder_id);
	}
	return ret;
	//#UC END# *45EEDB8B032F_45FFCBD60196*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

