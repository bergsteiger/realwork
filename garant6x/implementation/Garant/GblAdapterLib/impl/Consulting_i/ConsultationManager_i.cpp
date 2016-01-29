////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::ConsultationManager_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i_factory.h"
#include <fstream>
#include "garantServer/src/Global/Core/gcdC.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"

//#UC START# *457026710138_CUSTOM_INCLUDES*
#include "tao/Basic_Types.h"

#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClient.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
//#UC END# *457026710138_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *457026710138*
//#UC END# *457026710138*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultationManager_i::ConsultationManager_i ()
//#UC START# *457009CC035B_457026D700EA_457026710138_BASE_INIT*
: m_consulting_available (boost::indeterminate)
//#UC END# *457009CC035B_457026D700EA_457026710138_BASE_INIT*
{
	//#UC START# *457009CC035B_457026D700EA_457026710138_BODY*
	//#UC END# *457009CC035B_457026D700EA_457026710138_BODY*
}

ConsultationManager_i::~ConsultationManager_i () {
	//#UC START# *457026710138_DESTR_BODY*
	//#UC END# *457026710138_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void ConsultationManager_i::clear_cache () {
	//#UC START# *45702DA9037A_457026710138*
	m_consulting_available = boost::indeterminate;
	//#UC END# *45702DA9037A_457026710138*
}

// implemented method from ConsultationManager
// Сообщает о невозможности получать ответы (true - когда лампочку надо включать)
bool ConsultationManager_i::cant_receive_answer () const {
	//#UC START# *4829A56201B6_457026710138*
	return ApplicationHelper::instance ()->get_cached_consultation_manager ()->cant_receive_answer ();
	//#UC END# *4829A56201B6_457026710138*
}

// implemented method from ConsultationManager
// Проверка досутпности консультационных услуг
bool ConsultationManager_i::check_consulting_available () const {
	//#UC START# *457009CC035D_457026710138*
	this->check_update_and_clear_cache ();
	
	if (boost::indeterminate (m_consulting_available)) {
		m_consulting_available = 
			ApplicationHelper::instance ()->get_cached_consultation_manager ()->check_consulting_available ();
	}
	
	return m_consulting_available;
	//#UC END# *457009CC035D_457026710138*
}

// implemented method from ConsultationManager
// Проверка интернет канала
bool ConsultationManager_i::check_internet_channel () const {
	//#UC START# *457009CC035C_457026710138*
	return ApplicationHelper::instance ()->get_cached_consultation_manager ()->check_internet_channel ();
	//#UC END# *457009CC035C_457026710138*
}

// implemented method from ConsultationManager
// Создание уведомления пользователя о консалтинге
void ConsultationManager_i::create_query_with_notice_user () const {
	//#UC START# *4867614C01B0_457026710138*
	ApplicationHelper::instance ()->get_cached_consultation_manager ()->create_query_with_notice_user ();
	//#UC END# *4867614C01B0_457026710138*
}

// implemented method from ConsultationManager
// Удалить консультацию
void ConsultationManager_i::delete_consultation (Consultation* for_delete) const /*throw (NotDeleted, Deleted)*/ {
	//#UC START# *457009CC035E_457026710138*
	Consultation_i* for_delete_i = dynamic_cast <Consultation_i*>(for_delete);
	GDS_ASSERT (for_delete_i);
	ApplicationHelper::instance ()->get_cached_consultation_manager ()->delete_consultation (
		for_delete_i->get_cached_server_consultation ()
	);
	for_delete_i->mark_deleted ();
	//#UC END# *457009CC035E_457026710138*
}

// implemented method from ConsultationManager
// загрузить консультацию из файла
void ConsultationManager_i::load_from_xml (const char* file_name) const /*throw (AccessDenied, InvalidXMLType)*/ {
	//#UC START# *457009CC0361_457026710138*
	std::ifstream xml_stream (file_name, std::ios_base::in | std::ios_base::binary);
	if (!xml_stream) {
		LOG_E (("%s: can't open xml file for reading - %s", GDS_CURRENT_FUNCTION, file_name));
		throw AccessDenied ();
	}
	xml_stream.seekg (0, std::ios_base::end);
	std::streamoff length = xml_stream.tellg ();
	xml_stream.seekg (0, std::ios_base::beg);
	if (length == 0) {
		LOG_E (("%s: empty file - %s", GDS_CURRENT_FUNCTION, file_name));
		throw InvalidXMLType ();
	} else {
		GDS_ASSERT (length <= std::numeric_limits<CORBA::ULong>::max ());
		CORBA::ULong buffer_size = static_cast<CORBA::ULong> (length);

		CORBA::Octet* octet_buffer = GCD::XMLText::allocbuf (buffer_size);
		xml_stream.read (reinterpret_cast<char*> (octet_buffer), length);
		GCD::XMLText xml_text (buffer_size, buffer_size, octet_buffer, 1);

		try {
			ApplicationHelper::instance ()->get_cached_consultation_manager()->load_from_xml (xml_text);
		} catch (GblConsultingDef::InvalidXML&) {
			throw InvalidXMLType ();
		}
	}
	//#UC END# *457009CC0361_457026710138*
}

// implemented method from ConsultationManager
// Возвращает количество непрочитанных консультаций
unsigned long ConsultationManager_i::update_not_readed_consultations () const {
	//#UC START# *457009CC0360_457026710138*
	GCD::Uid uid = ApplicationHelper::instance ()->get_cached_current_user_id ();
	GblConsultingDef::ConsultationStatus status_for_check;
	status_for_check.client_status (
		GblConsultingDef::CCS_ANSWER_RECEIVED 
		| GblConsultingDef::CCS_ANSWER_NOT_CONFIRM
		| GblConsultingDef::CCS_PAYMENT_REQUEST);
	return ApplicationHelper::instance ()->get_cached_consultation_manager()
		->update_consultations_by_status (uid, status_for_check);
	//#UC END# *457009CC0360_457026710138*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

