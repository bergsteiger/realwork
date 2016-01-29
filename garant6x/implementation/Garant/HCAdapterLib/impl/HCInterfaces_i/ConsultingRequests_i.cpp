////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::ConsultingRequests_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/CommonUtils/XML/XML.h"
#include "ace/Date_Time.h"
#include "garantServer/src/Business/GblConsulting/Common/ConsultingSign.h"

//#UC START# *442CE26D0280_CUSTOM_INCLUDES*
#include "boost/lexical_cast.hpp"

#include "xercesc/dom/DOMDocument.hpp"
#include "xercesc/dom/DOMElement.hpp"

#include "shared/Core/Params/Params.h"
#include "shared/XercesHelpers/wrappers/XercesHelper.h"

#include "garant6x/implementation/Garant/HCAdapter/HCAdapter.h"
//#UC END# *442CE26D0280_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

//#UC START# *442CE26D0280*
ConsultingRequests_i::Addr2String::Addr2String (ACE_UINT32 addr) {
	const unsigned char* string_addr = reinterpret_cast<const unsigned char*> (&addr);
	ACE_OS::snprintf (
		m_addr, MAX_ADDR_SIZE, "%d.%d.%d.%d\0"
		, string_addr[3]
		, string_addr[2]
		, string_addr[1]
		, string_addr[0]
	);
}

const char* ConsultingRequests_i::Addr2String::data () const {
	return m_addr;
}

GblConsultingDef::UniqueConsultationIDList* ConsultingRequests_i::get_list_of_new_ids () const {
	HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
	return life_cycle->get_consultation_manager70 ().get_next_requests ();
}

GCI::IO::Stream* ConsultingRequests_i::create_xml_with_new_ids (const GblConsultingDef::UniqueConsultationIDList& ids) const {
	XercesHelpers::DocumentManager xml_manager ("list_of_new_queries");
	XERCES_CPP_NAMESPACE::DOMDocument* document = xml_manager.get_doc ();
	XERCES_CPP_NAMESPACE::DOMElement* root = document->getDocumentElement ();
	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();

	CORBA::ULong id_count = ids.length ();
	for (CORBA::ULong i = 0; i < id_count; ++i) {
		XERCES_CPP_NAMESPACE::DOMElement* query_tag = helper->create_element (document, "query");
		root->appendChild (query_tag);
		helper->set_attribute (query_tag, "id", ids[i].in ());
	}		

	return this->create_stream_by_xml (xml_manager);
}

//#UC END# *442CE26D0280*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultingRequests_i::ConsultingRequests_i ()
//#UC START# *442BFF3E0232_442CE1BE03C8_442CE26D0280_BASE_INIT*
//#UC END# *442BFF3E0232_442CE1BE03C8_442CE26D0280_BASE_INIT*
{
	//#UC START# *442BFF3E0232_442CE1BE03C8_442CE26D0280_BODY*
	//#UC END# *442BFF3E0232_442CE1BE03C8_442CE26D0280_BODY*
}

ConsultingRequests_i::~ConsultingRequests_i () {
	//#UC START# *442CE26D0280_DESTR_BODY*
	//#UC END# *442CE26D0280_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Конвертер результата записи в базу
HCInterfaces::ResultValue ConsultingRequests_i::commit_result_to_set_answer_result (
	GblConsulting::CommitResult value
) const {
	//#UC START# *445C72060261*
	HCInterfaces::ResultValue result = HCInterfaces::RV_SUCCESS;

	switch (value) {
		case GblConsulting::CR_OK:
			result = HCInterfaces::RV_SUCCESS;
			break;
		case GblConsulting::CR_DUPLICATE:
			result = HCInterfaces::RV_DUPLICATED;
			break;
		case GblConsulting::CR_ERROR:
			result = HCInterfaces::RV_ERROR;
			break;
		default:
			GDS_ASSERT (!"Bad return code from ConsultationManager::commit ()");
			break;
	}

	return result;
	//#UC END# *445C72060261*
}

// создать поток с результатами удаления консультаций
GCI::IO::Stream* ConsultingRequests_i::create_erase_result_stream (
	const GblConsulting::DeleteErrorInfoList& list70
) const {
	//#UC START# *47B178EF01C0*
	HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
	XercesHelpers::DocumentManager xml_manager ("errorlist");
	XERCES_CPP_NAMESPACE::DOMDocument* document = xml_manager.get_doc ();
	XERCES_CPP_NAMESPACE::DOMElement* root_tag = document->getDocumentElement ();

	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();
	for (size_t i = 0; i < list70.length (); ++i) {
		XERCES_CPP_NAMESPACE::DOMElement* query_tag = helper->create_element (document, "query");
		const GblConsulting::DeleteErrorInfo& info = list70[i];
		helper->set_attribute (query_tag, "id", info.id);
		helper->set_attribute (
			query_tag
			, "reason"
			, ErrorResultToStringSingleton::instance ()->get (info.code)
		);
		root_tag->appendChild (query_tag);
	}

	XercesHelpers::XMLStr buffer;
	size_t buffer_size = xml_manager.write_to_buffer (buffer);

	GCI::IO::Stream* result = GCI::IO::StreamFactory::make ();
	result->write (buffer.in (), buffer_size);

	return result;
	//#UC END# *47B178EF01C0*
}

// создание стрима со статистикой о заданных запросах
GCI::IO::Stream* ConsultingRequests_i::create_status_stream (const GblConsulting::StatInfoList& list70) const {
	//#UC START# *45B49D9801B5*
	HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
	XercesHelpers::DocumentManager xml_manager ("status_list");
	XERCES_CPP_NAMESPACE::DOMDocument* document = xml_manager.get_doc ();
	XERCES_CPP_NAMESPACE::DOMElement* root_tag = document->getDocumentElement ();

	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();
	// Create queries
	for (size_t i = 0; i < list70.length (); ++i) {
		XERCES_CPP_NAMESPACE::DOMElement* query_tag = helper->create_element (document, "query");
		const GblConsulting::StatInfo& info = list70[i];
		helper->set_attribute (query_tag, "id", info.id);
		helper->set_attribute (
			query_tag
			, "status"
			, ConsultationStatusToStringSingleton::instance ()->get (info.status)
		);

		this->set_xml_date (document, query_tag, 0, info.modified_date);
		this->set_xml_time (document, query_tag, 0, info.modified_time);

		root_tag->appendChild (query_tag);
	}

	XercesHelpers::XMLStr buffer;
	size_t buffer_size = xml_manager.write_to_buffer (buffer);

	GCI::IO::Stream* result = GCI::IO::StreamFactory::make ();
	result->write (buffer.in (), buffer_size);

	return result;
	//#UC END# *45B49D9801B5*
}

// Кладёт полученный xml документ в поток
GCI::IO::Stream* ConsultingRequests_i::create_stream_by_xml (XercesHelpers::DocumentManager& xml_manager) const {
	//#UC START# *445C70A00138*
	XercesHelpers::XMLStr buffer;
	size_t buffer_size = xml_manager.write_to_buffer (buffer);
	GCI::IO::Stream* xml_stream = GCI::IO::StreamFactory::make ();
	xml_stream->write (buffer.in (), buffer_size);

	return xml_stream;
	//#UC END# *445C70A00138*
}

// Генерит xml для полученной оценки
GCI::IO::Stream* ConsultingRequests_i::create_xml_estimation (
	GblConsulting::ConsultationEstimation& estimation
) const {
	//#UC START# *445C4744035B*
	HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
	XercesHelpers::DocumentManager xml_manager ("consulting");
	XERCES_CPP_NAMESPACE::DOMDocument* document = xml_manager.get_doc ();

	// Create consulting attributes
	XERCES_CPP_NAMESPACE::DOMElement* consulting_tag = this->set_xml_root_params (
		document
		, estimation.id
	);

	// Create mark
	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();
	XERCES_CPP_NAMESPACE::DOMElement* mark_tag = helper->create_element (document, "mark");
	consulting_tag->appendChild (mark_tag);
	helper->set_attribute (
		mark_tag
		, "value"
		, EstimationValueToStringSingleton::instance ()->get (estimation.estimation.estimation_value)
	);
	XERCES_CPP_NAMESPACE::DOMElement* comment_tag = helper->create_element (document, "comment");
	mark_tag->appendChild (comment_tag);
	helper->add_text_node (document, comment_tag, estimation.estimation.text);

	return this->create_stream_by_xml (xml_manager);
	//#UC END# *445C4744035B*
}

// создать xml запрос для консультации с сервера f1
GCI::IO::Stream* ConsultingRequests_i::create_xml_request (
	const GblConsulting::ExtendedClientInfo70& extended_info
	, const GblConsultingDef::ConsultationID& id
	, const char* query
	, const GCD::Date& creation_date
	, const GCD::Time& creation_time
	, const GCD::Date& date
	, const GCD::Time& time
	, GblConsulting::HCConsultationPaymentStatus status
	, const GblConsultingDef::UserInfo70& user_info
) const {
	//#UC START# *46BC3C23009C*
	HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
	XercesHelpers::DocumentManager xml_manager ("consulting");
	XERCES_CPP_NAMESPACE::DOMDocument* document = xml_manager.get_doc ();

	// Create consulting attributes
	XERCES_CPP_NAMESPACE::DOMElement* consulting_tag = this->set_xml_root_params (document, id);

	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();

	// Create query
	XERCES_CPP_NAMESPACE::DOMElement* query_tag = helper->create_element (document, "query");
	consulting_tag->appendChild (query_tag);

	try {
		helper->set_attribute (
			query_tag
			, "status"
			, HCConsultationPaymentStatusToStringSingleton::instance ()->get (status)
		);
	} catch (Core::ElementNotFound&) {
		LOG_E (("%s: can't create attribute %s (value: %d)", GDS_CURRENT_FUNCTION, "status", status));
		helper->set_attribute (
			query_tag
			, "status"
			, "UNKNOWN"
		);

	}

	// Create query text
	XERCES_CPP_NAMESPACE::DOMElement* query_text_tag = helper->create_element (document, "query_text");
	query_tag->appendChild (query_text_tag);
	helper->add_text_node (document, query_text_tag, query);

	// Create additional info
	XERCES_CPP_NAMESPACE::DOMElement* additional_info_tag = helper->create_element (document, "additional_info");
	query_tag->appendChild (additional_info_tag);

	// Create receive date-time info
	this->set_xml_date (document, additional_info_tag, "date", date);
	this->set_xml_time (document, additional_info_tag, "time", time);

	this->set_xml_date (document, additional_info_tag, "borndate", creation_date);
	this->set_xml_time (document, additional_info_tag, "borntime", creation_time);

	// Create base info
	XERCES_CPP_NAMESPACE::DOMElement* base_info_tag = helper->create_element (document, "base_info");
	additional_info_tag->appendChild (base_info_tag);
	this->set_xml_date (document, base_info_tag, "date", extended_info.base_revision_date);

	// Create authentification info
	XERCES_CPP_NAMESPACE::DOMElement* authentication_tag = helper->create_element (document, "authentication_info");
	additional_info_tag->appendChild (authentication_tag);
	if (extended_info.identification_info.password.in () && (extended_info.identification_info.password[0] != 0)) {
		helper->set_attribute (authentication_tag, "type", "regular");
		helper->set_attribute (authentication_tag, "password", extended_info.identification_info.password.in ());
	} else {
		helper->set_attribute (authentication_tag, "type", "online");
		helper->set_attribute (authentication_tag, "client_complect_id", extended_info.identification_info.complect_id_opp);
		helper->set_attribute (authentication_tag, "user_cardnum", extended_info.consumer_cardnum);
	}

	// Create user info
	XERCES_CPP_NAMESPACE::DOMElement* user_tag = helper->create_element (document, "user");
	additional_info_tag->appendChild (user_tag);

	// Create user contact info
	if (
		ACE_OS::strlen (user_info.name) 
		|| ACE_OS::strlen (user_info.region_code) 
		|| ACE_OS::strlen (user_info.phone_number)
		|| ACE_OS::strlen (user_info.email)
		|| extended_info.client_addr
	) {
		XERCES_CPP_NAMESPACE::DOMElement* contact_tag = helper->create_element (document, "contact");
		user_tag->appendChild (contact_tag);
		helper->set_attribute (contact_tag, "name", user_info.name);
		helper->set_attribute (contact_tag, "region", user_info.region_code);
		helper->set_attribute (contact_tag, "phone", user_info.phone_number);
		// new fields for 7.0
		helper->set_attribute (contact_tag, "email", user_info.email);
		helper->set_attribute (contact_tag, "can_get_consultation", user_info.can_pay_for_consulting ? "yes" : "no");
		// cq28309
		Addr2String addr (extended_info.client_addr);
		helper->set_attribute (contact_tag, "ip", addr.data ());
	}

	return this->create_stream_by_xml (xml_manager);
	//#UC END# *46BC3C23009C*
}

// Генерит дату в формате xml
void ConsultingRequests_i::set_xml_date (
	XERCES_CPP_NAMESPACE::DOMDocument* document
	, XERCES_CPP_NAMESPACE::DOMElement* parent
	, const char* tag_name
	, const GCD::Date& date
) const {
	//#UC START# *445C6F4100FA*
	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();
	XERCES_CPP_NAMESPACE::DOMElement* date_tag = parent;
	if (tag_name) {
		date_tag = helper->create_element (document, tag_name);
		parent->appendChild (date_tag);
	}
	helper->set_attribute (date_tag, "day", date.day);
	helper->set_attribute (date_tag, "month", date.month);
	helper->set_attribute (date_tag, "year", date.year);
	//#UC END# *445C6F4100FA*
}

// Установка рутового тега для генерируемого xml
XERCES_CPP_NAMESPACE::DOMElement* ConsultingRequests_i::set_xml_root_params (
	XERCES_CPP_NAMESPACE::DOMDocument* document
	, const GblConsultingDef::ConsultationID& consultation_id
) const {
	//#UC START# *445C6CF100AB*
	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();
	XERCES_CPP_NAMESPACE::DOMElement* consulting_tag = document->getDocumentElement ();

	helper->set_attribute (consulting_tag, "query_id", consultation_id.consultation_id);

	return consulting_tag;
	//#UC END# *445C6CF100AB*
}

void ConsultingRequests_i::set_xml_time (
	XERCES_CPP_NAMESPACE::DOMDocument* document
	, XERCES_CPP_NAMESPACE::DOMElement* parent
	, const char* tag_name
	, const GCD::Time& time
) const {
	//#UC START# *4DA2E6AF02BD*
	XercesHelpers::XercesHelper* helper = XercesHelpers::XercesHelper::instance ();
	XERCES_CPP_NAMESPACE::DOMElement* time_tag = parent;
	if (tag_name) {
		time_tag = helper->create_element (document, tag_name);
		parent->appendChild (time_tag);
	}
	helper->set_attribute (time_tag, "hours", time.hour);
	helper->set_attribute (time_tag, "minutes", time.min);
	helper->set_attribute (time_tag, "seconds", time.sec);
	//#UC END# *4DA2E6AF02BD*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from HCInterfaces::ConsultingRequests
// удалить запросы из базы СК
HCInterfaces::ResultValue ConsultingRequests_i::erase_queries_by_id (
	GCI::IO::Stream* query
	, GCI::IO::Stream*& result
) const {
	//#UC START# *47B0663F0363_442CE26D0280*
	LOG_D (("%s called", GDS_CURRENT_FUNCTION));
	// так как query - MSDNStream, в конструкторе которого делается addref
	// надо его положить в Var, иначе он утечёт (проблема в том, что
	// в оболочке F1 Stream родной MSDN-овский, а Можаев (ОПП) использует наш IStream)
	GCI::IO::Stream_var query_remover (query);

	// выбираем идентификаторы из xml
	GblConsultingDef::UniqueConsultationIDList id_list70;
	bool force = false;

	try {
		IDListCreator helper (query);
		helper.get_unique_id_lists (id_list70);
		force = helper.get_force_flag ();
	} catch (IDListCreator::BadXML&) {
		return HCInterfaces::RV_BAD_XML;
	} catch (IDListCreator::EmptyXML&) {
		return HCInterfaces::RV_EMPTY;
	}

	// спрашиваем данные у СК
	try {
		const size_t max_packet_size = Core::ParamManagerFactory::get ().get_ulong (
			HCInterfaces::STATISTIC_PACKET_SIZE_PARAMETER
			, HCInterfaces::STATISTIC_PACKET_SIZE
		);

		const unsigned long sleep_time = Core::ParamManagerFactory::get ().get_ulong (
			HCInterfaces::STATISTIC_SLEEP_TIME_PARAMETER
			, HCInterfaces::STATISTIC_SLEEP_TIME
		);

		GblConsulting::DeleteErrorInfoList result70_list;
		size_t id_list70_size = id_list70.length ();
		GblConsultingDef::UniqueConsultationIDList list70_part (std::min (max_packet_size, id_list70_size));
		for (size_t i = 0; i < id_list70_size; i += max_packet_size) {
			// даём время внешним пользователям достучаться до СК
			if (i) {
				ACE_OS::sleep (sleep_time);
			}
			size_t packet_size = std::min (max_packet_size, id_list70_size - i);
			list70_part.length (packet_size);
			for (size_t j = 0; j < packet_size; ++j) {
				list70_part[j] = id_list70[i + j];
			}
			HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
			GblConsulting::DeleteErrorInfoList_var result70_list_part (
				life_cycle->get_consultation_manager70().delete_consultations (list70_part, force)
			);
			size_t old_size = result70_list.length ();
			size_t result70_list_part_size = result70_list_part->length ();
			result70_list.length (old_size + result70_list_part_size);
			for (size_t j = 0; j < result70_list_part_size; ++j) {
				result70_list[old_size + j] = result70_list_part[j];
			}
		}
		try {
			result = this->create_erase_result_stream (result70_list);
		} catch (...) {
			LOG_E (("%s: error while creating xml with statuses from reply", GDS_CURRENT_FUNCTION));
			return HCInterfaces::RV_ERROR;
		}
	} catch (CORBA::Exception&) {
		LOG_E (("%s: error while getting statuses from server", GDS_CURRENT_FUNCTION));
		return HCInterfaces::RV_ERROR;
	}
	return HCInterfaces::RV_SUCCESS;
	//#UC END# *47B0663F0363_442CE26D0280*
}

// implemented method from HCInterfaces::ConsultingRequests
// получить список идентификаторов консультаций, которые нужно забрать на обработку в ППО
HCInterfaces::ResultValue ConsultingRequests_i::get_list_of_new_queries (GCI::IO::Stream*& result) const {
	//#UC START# *4EE08E2C0010_442CE26D0280*
	try {
		GblConsultingDef::UniqueConsultationIDList_var id_list (this->get_list_of_new_ids ());
		if (id_list->length ()) {
			result = this->create_xml_with_new_ids (id_list.in ());
		} else {
			result = 0;

			return HCInterfaces::RV_EMPTY;
		}		
	} catch (CORBA::Exception& ex) {
		LOG_CEX ((ex, "%s", GDS_CURRENT_FUNCTION));
		result = 0;

		return HCInterfaces::RV_ERROR;
	} catch (...) {
		LOG_E (("%s: can't create list of new queries", GDS_CURRENT_FUNCTION));
		return HCInterfaces::RV_ERROR;
	}

	return HCInterfaces::RV_SUCCESS;
	//#UC END# *4EE08E2C0010_442CE26D0280*
}

// implemented method from HCInterfaces::ConsultingRequests
// Получение очередной оценки на запрос.
// При вызове этой операции происходит передача объекта "Оценка" для получения данных. До тех пор
// пока не будет проведен вызов DataRecieved, эта операция будет возвращать этот запрос.
// Если нет ни одного нового запроса, получившего оценку пользователя, возвращается нулевой объект.
HCInterfaces::ResultValue ConsultingRequests_i::get_next_mark (HCInterfaces::ConsultingData*& data) const {
	//#UC START# *442BFFFE038A_442CE26D0280*
	LOG_D (("ConsultingRequests_i::get_next_mark called"));

	Core::Aptr<GblConsulting::ConsultationEstimation> estimation;
	try {
		HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
		estimation = life_cycle->get_consultation_manager70().get_next_estimation ();

		// consultation_id = 0 if all estimations already received
		if (std::strlen (estimation->id.consultation_id) == 0) {
			data = 0;
			return HCInterfaces::RV_EMPTY;
		}
	} catch (CORBA::Exception& ex) {
		LOG_CEX ((ex, "%s", GDS_CURRENT_FUNCTION));

		data = 0;
		return HCInterfaces::RV_ERROR;
	}

	Core::Var<GCI::IO::Stream> xml_stream = this->create_xml_estimation (*estimation.ptr ());

	data = HCInterfaces::OnlineDataFactory::make (xml_stream._retn (), estimation->id, "MARK70");
	return HCInterfaces::RV_SUCCESS;
	//#UC END# *442BFFFE038A_442CE26D0280*
}

// implemented method from HCInterfaces::ConsultingRequests
// получить следующий запрос для обработки
HCInterfaces::ResultValue ConsultingRequests_i::get_query_by_id (
	HCInterfaces::QueryID_const query_id
	, HCInterfaces::ConsultingData*& data
) const {
	//#UC START# *442BFF9202EE_442CE26D0280*
	LOG_D (("%s called", GDS_CURRENT_FUNCTION));

	GblConsulting::ConsultationRequest70_var request;
	try {
		HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
		request = life_cycle->get_consultation_manager70 ().get_request (query_id);
	} catch (GblConsulting::InvalidConsultationID&) {
		LOG_E (("%s: invalid consultation id %s", GDS_CURRENT_FUNCTION, query_id));
		data = 0;

		return HCInterfaces::RV_INVALID_QUERY_ID;
	} catch (CORBA::Exception& ex) {
		LOG_CEX ((ex, "%s", GDS_CURRENT_FUNCTION));
		data = 0;

		return HCInterfaces::RV_ERROR;
	}

	if (CORBA::is_nil (request)) {
		data = 0;
		return HCInterfaces::RV_EMPTY;
	}

	bool complect_removed_from_arm = false;
	Core::Var<GCI::IO::Stream> xml_stream;
	try {
		Core::Aptr<GblConsulting::ExtendedClientInfo70> extended_info;
		try {
			extended_info = request->get_extended_info ();
		} catch (GblConsulting::InfoNotFound&) {
			LOG_E (("%s: internal consulting server error", GDS_CURRENT_FUNCTION));
			complect_removed_from_arm = true;
			extended_info = new GblConsulting::ExtendedClientInfo70;
		}
		Core::Aptr<GblConsultingDef::ConsultationID> consultation_id = request->get_id ();
		Core::Aptr<char> query (request->get_text ());
		Core::Aptr<GCD::Date> creation_date = request->get_creation_date ();
		Core::Aptr<GCD::Time> creation_time = request->get_creation_time ();
		Core::Aptr<GCD::Date> date = request->get_date ();
		Core::Aptr<GCD::Time> time = request->get_time ();
		Core::Aptr<GblConsultingDef::UserInfo70> user_info = request->get_user_info ();
		GblConsulting::HCConsultationPaymentStatus status = request->get_payment_status ();

		try {
			xml_stream = this->create_xml_request (
				*extended_info.ptr ()
				, *consultation_id.ptr ()
				, query.ptr ()
				, *creation_date.ptr ()
				, *creation_time.ptr ()
				, *date.ptr ()
				, *time.ptr ()
				, status
				, *user_info.ptr ()
			);
		} catch (...) {
			LOG_E (("%s: can't create xml data", GDS_CURRENT_FUNCTION));
			data = 0;

			return HCInterfaces::RV_ERROR;
		}
	} catch (GblConsulting::TryLater&) {
		LOG_E (("%s: can't get extended data. Maybe problems with validating server.", GDS_CURRENT_FUNCTION));
		data = 0;

		return HCInterfaces::RV_ERROR;
	}

	Core::Aptr<GblConsultingDef::ConsultationID> consultation_id = request->get_id ();

	data = HCInterfaces::OnlineDataFactory::make (xml_stream._retn (), *consultation_id.ptr (), "QUERY70");
	return complect_removed_from_arm ? HCInterfaces::RV_COMPLECT_REMOVED_ERROR : HCInterfaces::RV_SUCCESS;
	//#UC END# *442BFF9202EE_442CE26D0280*
}

// implemented method from HCInterfaces::ConsultingRequests
// функция выдаёт статусы консультаций и даты их последней модификации по их идентификаторам.
HCInterfaces::ResultValue ConsultingRequests_i::get_status_statistic (
	GCI::IO::Stream* query
	, GCI::IO::Stream*& result
) const {
	//#UC START# *45B49CBD03B9_442CE26D0280*
	LOG_D (("%s called", GDS_CURRENT_FUNCTION));
	// так как query - MSDNStream, в конструкторе которого делается addref
	// надо его положить в Var, иначе он утечёт (проблема в том, что
	// в оболочке F1 Stream родной MSDN-овский, а Можаев (ОПП) использует наш IStream)
	GCI::IO::Stream_var query_remover (query);


	// выбираем идентификаторы из xml
	GblConsultingDef::UniqueConsultationIDList id_list70;

	try {
		IDListCreator helper (query);
		helper.get_unique_id_lists (id_list70);
	} catch (IDListCreator::BadXML&) {
		return HCInterfaces::RV_BAD_XML;
	} catch (IDListCreator::EmptyXML&) {
		return HCInterfaces::RV_EMPTY;
	}

	// спрашиваем данные у СК
	try {
		const size_t max_packet_size = Core::ParamManagerFactory::get ().get_ulong (
			HCInterfaces::STATISTIC_PACKET_SIZE_PARAMETER
			, HCInterfaces::STATISTIC_PACKET_SIZE
		);

		const unsigned long sleep_time = Core::ParamManagerFactory::get ().get_ulong (
			HCInterfaces::STATISTIC_SLEEP_TIME_PARAMETER
			, HCInterfaces::STATISTIC_SLEEP_TIME
		);

		GblConsulting::StatInfoList result70_list;
		size_t id_list70_size = id_list70.length ();
		GblConsultingDef::UniqueConsultationIDList list70_part (std::min (max_packet_size, id_list70_size));
		for (size_t i = 0; i < id_list70_size; i += max_packet_size) {
			// даём время внешним пользователям достучаться до СК
			if (i) {
				ACE_OS::sleep (sleep_time);
			}
			size_t packet_size = std::min (max_packet_size, id_list70_size - i);
			list70_part.length (packet_size);
			for (size_t j = 0; j < packet_size; ++j) {
				list70_part[j] = id_list70[i + j];
			}
			HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
			GblConsulting::StatInfoList_var result_list_part =
				life_cycle->get_consultation_manager70().get_stat_info (list70_part);
			size_t old_size = result70_list.length ();
			size_t result_list_part_size = result_list_part->length ();
			result70_list.length (old_size + result_list_part_size);
			for (size_t j = 0; j < result_list_part_size; ++j) {
				result70_list[old_size + j] = result_list_part[j];
			}
		}
		try {
			result = this->create_status_stream (result70_list);
		} catch (...) {
			LOG_E (("%s: error while creating xml with statuses from reply", GDS_CURRENT_FUNCTION));
			return HCInterfaces::RV_ERROR;
		}
	} catch (CORBA::Exception&) {
		LOG_E (("%s: error while getting statuses  from server", GDS_CURRENT_FUNCTION));
		return HCInterfaces::RV_ERROR;
	}
	return HCInterfaces::RV_SUCCESS;
	//#UC END# *45B49CBD03B9_442CE26D0280*
}

// implemented method from HCInterfaces::ConsultingRequests
// Ответ на запрос или предварительное уведомление о сроках обработки запроса.
// Ответ оформлен в XML формате (описание cм. в реквизите).
// Варианты возвращаемых значений:
// [0] - если ответ успешно помещен в базу.
// [1] - если запрос в базе уже помечен, как отвеченный.
// [-1] - если серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-
// то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа.
// [-2] - если формат ответа не соответствует "ожиданиям" сервера.
HCInterfaces::ResultValue ConsultingRequests_i::set_answer (GCI::IO::Stream* answer) const {
	//#UC START# *442C007702FD_442CE26D0280*
	LOG_D (("%s", GDS_CURRENT_FUNCTION));
	// так как answer - MSDNStream, в конструкторе которого делается addref
	// надо его положить в Var, иначе он утечёт (проблема в том, что
	// в оболочке F1 Stream родной MSDN-овский, а Можаев (ОПП) использует наш IStream)
	GCI::IO::Stream_var answer_remover (answer);

	CommonUtils::XML::XMLReader_var reader = CommonUtils::XML::XMLReaderFactory::make ();
	GblConsultingDef::ConsultationData_var reply;
	try {
		HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
		reply = reader->read_result (answer);
	} catch (CommonUtils::XML::BadXMLFormat&) {
		return HCInterfaces::RV_BAD_XML;
	}


	try {
		HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
		return this->commit_result_to_set_answer_result (
			life_cycle->get_consultation_manager70 ().commit (reply.in ())
		);
	} catch (CORBA::Exception& ex) {
		LOG_CEX ((ex, "ConsultingRequests_i::set_answer"));
		return HCInterfaces::RV_ERROR;
	}

	return HCInterfaces::RV_SUCCESS; // NOT REACHED!
	//#UC END# *442C007702FD_442CE26D0280*
}

// implemented method from HCInterfaces::ConsultingRequests
// добавить в xml контрольную сумму
HCInterfaces::ResultValue ConsultingRequests_i::sign_query (
	GCI::IO::Stream* query
	, GCI::IO::Stream*& signed_query
) const {
	//#UC START# *484402BF023D_442CE26D0280*
	LOG_D (("%s called", GDS_CURRENT_FUNCTION));
	// так как query - MSDNStream, в конструкторе которого делается addref
	// надо его положить в Var, иначе он утечёт (проблема в том, что
	// в оболочке F1 Stream родной MSDN-овский, а Можаев (ОПП) использует наш IStream)
	GCI::IO::Stream_var query_remover (query);
	
	size_t data_size = query->seek (0, 2);
	if (!data_size) {
		LOG_W (("%s: empty stream", GDS_CURRENT_FUNCTION));
		return HCInterfaces::RV_EMPTY;
	}
	query->seek (0, 0);
	Core::Aptr<char, Core::ArrayDeleteDestructor<char> >  buffer (new char [data_size]);
	size_t len = query->read (buffer.ptr (), data_size);
	if (!len) {
		LOG_E (("%s: can't read data from stream", GDS_CURRENT_FUNCTION));
		return HCInterfaces::RV_ERROR;
	}
	GDS_ASSERT (len == data_size);
	if (len != data_size) {
		LOG_W (("%s: stream size (%d) not equal to readed data size (%d)", GDS_CURRENT_FUNCTION, data_size, len));
	}

	std::string sign = GblConsultingDef::ConsultingSign (buffer.ptr (), len).get_sign ();

	signed_query = GCI::IO::StreamFactory::make ();
	// первая строка - заголовок xml, её не трогаем, второй строкой включаем контрольную сумму
	size_t skip = 0;
	while ((skip < len) && (buffer.ptr ()[skip++] != '\n'));
	if (skip == len) {
		LOG_E (("%s: can't find second string at xml file", GDS_CURRENT_FUNCTION));
		return HCInterfaces::RV_ERROR;
	}
	signed_query->write (buffer.ptr (), skip);
	signed_query->write (sign.c_str (), sign.size ());
	signed_query->write (buffer.ptr () + skip, data_size - skip);

	return HCInterfaces::RV_SUCCESS;
	//#UC END# *484402BF023D_442CE26D0280*
}
} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

