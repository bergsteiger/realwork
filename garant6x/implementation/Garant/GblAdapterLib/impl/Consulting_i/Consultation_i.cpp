////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Consultation_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i.h"
// by <<uses>> dependencies
#include "garantServer/src/Business/GblFolders/GblFoldersAdapC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTimeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/EstimationTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.h"

//#UC START# *45704FB40290_CUSTOM_INCLUDES*
#include "ace/Codecs.h"

#include "boost/shared_array.hpp"
//#UC END# *45704FB40290_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45704FB40290*
//#UC END# *45704FB40290*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Consultation_i::Consultation_i (GblConsultingClient::Consultation* server_consultation, FoldersNode* folders_node)
//#UC START# *457008050157_4570516E002E_45704FB40290_BASE_INIT*
:	m_server_consultation (GblConsultingClient::Consultation::_duplicate (server_consultation))
	, m_folders_node (FoldersNode::_duplicate (folders_node))
	, m_is_evd (false)
//#UC END# *457008050157_4570516E002E_45704FB40290_BASE_INIT*
{
	//#UC START# *457008050157_4570516E002E_45704FB40290_BODY*
	//#UC END# *457008050157_4570516E002E_45704FB40290_BODY*
}

Consultation_i::~Consultation_i () {
	//#UC START# *45704FB40290_DESTR_BODY*
	try {
		ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (m_server_consultation.in ());
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *45704FB40290_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Consultation_i::check_deleted () const /*throw (Deleted)*/ {
	//#UC START# *45740150033C*
	if (ListOfDeletedConsultations::instance ()->is_deleted (m_folders_node->get_id ())) {
		throw Deleted ();
	}
	//#UC END# *45740150033C*
}

GblConsultingClient::Consultation* Consultation_i::get_cached_server_consultation () const {
	//#UC START# *457438EB037A*
	return m_server_consultation.ptr ();
	//#UC END# *457438EB037A*
}

bool Consultation_i::is_evd_paras (const GblConsultingDef::ParaList& server_list) const {
	//#UC START# *4DA6F8EC03E4*
	if (server_list.length() != 2) {
		return false;
	}

	return !ACE_OS::strcmp (GblConsultingDef::EVD_REPLY_MARKER, server_list[0].in ());
	//#UC END# *4DA6F8EC03E4*
}

// пометить консультацию как удалённую
void Consultation_i::mark_deleted () {
	//#UC START# *4AC0B11502FE*
	ListOfDeletedConsultations::instance ()->add_node (m_folders_node->get_id ());
	//#UC END# *4AC0B11502FE*
}

void Consultation_i::refresh_node_flags () {
	//#UC START# *4574225D029F*
	try {
		dynamic_cast <FoldersNode_i*> (m_folders_node.ptr ())->recalc_consultations_flag ();
	} catch (...) {
		FoldersNode_var folders_node = FoldersFactory::make ().find_folder_node (GblFoldersAdap::CONSULTATIONS_FOLDER_ID);
		dynamic_cast <FoldersNode_i*> (folders_node.ptr ())->recursive_recalc_consultations_flag ();
	}
	//#UC END# *4574225D029F*
}

void Consultation_i::translate_evd_paras (
	const GblConsultingDef::ParaList& server_list
	, ParasList& adapter_list
) const {
	//#UC START# *4DA6F9D1029C*
	GDS_ASSERT (server_list.length () == 2);

	size_t decoded_length = 0;
	boost::shared_array<ACE_Byte> decoded_buffer (
		ACE_Base64::decode (reinterpret_cast<const ACE_Byte*> (server_list[1].in ()), &decoded_length)
	);

	adapter_list.push_back (
		GCI::IO::BinaryStringFactory::make (decoded_buffer.get (), decoded_length)
	);
	//#UC END# *4DA6F9D1029C*
}

// возвращает true, если в ответе лежит evd
bool Consultation_i::translate_paras (const GblConsultingDef::ParaList& server_list, ParasList& adapter_list) const {
	//#UC START# *4CEE2E62024A*
	GDS_ASSERT (adapter_list.empty ());

	bool is_evd = this->is_evd_paras (server_list);
	if (is_evd) {
		this->translate_evd_paras (server_list, adapter_list);
	} else {
		this->translate_txt_paras (server_list, adapter_list);
	}

	return is_evd;
	//#UC END# *4CEE2E62024A*
}

void Consultation_i::translate_txt_paras (
	const GblConsultingDef::ParaList& server_list
	, ParasList& adapter_list
) const {
	//#UC START# *4DA6F9C4030A*
	adapter_list.reserve (server_list.length ());
	for (size_t i = 0; i < server_list.length (); ++i) {
		adapter_list.push_back (
			GCI::IO::StringFactory::make (server_list[i].in ())
		);
	}
	//#UC END# *4DA6F9C4030A*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Consultation
// создать оценку
Estimation* Consultation_i::create_estimation () const {
	//#UC START# *45700805015D_45704FB40290*
	return EstimationFactory::make ();
	//#UC END# *45700805015D_45704FB40290*
}

// implemented method from Consultation
// Дата создания
const DateTime& Consultation_i::get_creation_date () const
	/*throw (Deleted)*/
{
	//#UC START# *457008050162_45704FB40290_GET*
	this->check_deleted ();
	try {
		if (m_creation_date.is_nil ()) {
			DateTimeTranslator::translate (m_server_consultation->get_creation_date (), *m_creation_date);
		}
		return *m_creation_date;
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *457008050162_45704FB40290_GET*
}

// implemented method from Consultation
const ParasList Consultation_i::get_expert_info () const
	/*throw (Deleted)*/
{
	//#UC START# *4CEBD05900FE_45704FB40290_GET*
	this->check_deleted ();
	try {
		GblConsultingDef::HCConsultationData_var consultation_data (m_server_consultation->get_consultation_data ());
		ParasList result;
		this->translate_paras (consultation_data->price (), result);
		return result;
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEBD05900FE_45704FB40290_GET*
}

// implemented method from Consultation
const GCI::IO::String& Consultation_i::get_expert_name () const
	/*throw (Deleted)*/
{
	//#UC START# *4CEBD0D901D5_45704FB40290_GET*
	this->check_deleted ();
	try {
		if (m_expert_name.is_nil ()) {
			GblConsultingDef::HCConsultationData_var consultation_data (m_server_consultation->get_consultation_data ());
			const GblConsultingDef::ConsultationAuthor& cons_author = consultation_data->author ();
			std::string author (cons_author.name.in ());
			if (cons_author.email && cons_author.email [0]) {
				author += ", ";
				author += cons_author.email;
			}
			m_expert_name = GCI::IO::StringFactory::make (author.c_str ());
		}
		return *m_expert_name.in ();
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEBD0D901D5_45704FB40290_GET*
}

// implemented method from Consultation
// Получить уведомление или ответ на запрос
Document* Consultation_i::get_answer () const /*throw (Deleted, OldFormatConsultation)*/ {
	//#UC START# *457008050159_45704FB40290*
	this->check_deleted ();

	return ConsultingStubFactory::make_consulting_stub ();
	//#UC END# *457008050159_45704FB40290*
}

// implemented method from Consultation
const ParasList& Consultation_i::get_answer_data (bool& is_evd) const {
	//#UC START# *4DA581950113_45704FB40290*
	this->check_deleted ();
	try {
		if (m_answer.empty ()) {
			GblConsultingDef::HCConsultationData_var consultation_data (m_server_consultation->get_consultation_data ());
			m_is_evd = this->translate_paras (consultation_data->text (), m_answer);
		}
		is_evd = m_is_evd;
		return m_answer;
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4DA581950113_45704FB40290*
}

// implemented method from Consultation
// Получить список документов ответа
DynList* Consultation_i::get_document_list () const /*throw (NoDocumentList, Deleted, OldFormatConsultation)*/ {
	//#UC START# *45700805015A_45704FB40290*
	this->check_deleted ();
	try {
		GblDocList::DocListTree_var server_doclist_tree = m_server_consultation->get_list ();
		return DynListFactory::make (server_doclist_tree.in ());
	} catch (GCD::CanNotFindData&) {
		throw NoDocumentList ();
	} catch (GblConsultingClient::OldFormatConsultation&) {
		throw OldFormatConsultation ();
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *45700805015A_45704FB40290*
}

// implemented method from Consultation
// Получить запрос
Document* Consultation_i::get_query () const /*throw (Deleted, OldFormatConsultation)*/ {
	//#UC START# *46BAFEDB004E_45704FB40290*
	this->check_deleted ();

	return ConsultingStubFactory::make_consulting_stub ();
	//#UC END# *46BAFEDB004E_45704FB40290*
}

// implemented method from Consultation
// получить запрос в виде списка параграфов
const ParasList& Consultation_i::get_query_by_paras () const {
	//#UC START# *4D07592B0032_45704FB40290*
	this->check_deleted ();
	try {
		if (m_query.is_nil ()) {
			CORBA::String_var query (m_server_consultation->get_query ());
			m_query = GCI::IO::StringFactory::make (query.in ());
		}
		if (m_query_paras.empty ()) {
			std::string query_string (m_query->get_data (), m_query->get_length ());
			GDS_ASSERT (!query_string.empty ());
			if (query_string.empty ()) {
				return m_query_paras;
			}

			// разбиваем запрос на параграфы
			size_t begin = 0;
			for (size_t end = 0; end != std::string::npos; begin = end + 1) {		
				end = query_string.find ('\n', begin);
				m_query_paras.push_back (
					GCI::IO::StringFactory::make (query_string.substr (begin, end - begin).c_str ())
				);
			}
		}

		return m_query_paras;
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4D07592B0032_45704FB40290*
}

// implemented method from Consultation
bool Consultation_i::has_estimation () const /*throw (Deleted)*/ {
	//#UC START# *4CEBD99E01F5_45704FB40290*
	this->check_deleted ();
	try {
		GblConsultingDef::ConsultationStatus status = m_server_consultation->get_status ();
		return status.client_status () & GblConsultingDef::CCS_ESTIMATION_SENT;
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEBD99E01F5_45704FB40290*
}

// implemented method from Consultation
bool Consultation_i::has_list () const /*throw (Deleted)*/ {
	//#UC START# *4CEBD9790091_45704FB40290*
	this->check_deleted ();
	try {
		return m_server_consultation->has_list ();
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEBD9790091_45704FB40290*
}

// implemented method from Consultation
bool Consultation_i::has_payment_information () const /*throw (Deleted)*/ {
	//#UC START# *4CEBD9BE03E4_45704FB40290*
	this->check_deleted ();
	try {
		GblConsultingDef::ConsultationStatus status = m_server_consultation->get_status ();
		return status.client_status () & (GblConsultingDef::CCS_PAYMENT_REFUSAL | GblConsultingDef::CCS_PAYMENT_CONFIRM);
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEBD9BE03E4_45704FB40290*
}

// implemented method from Consultation
// Идентификатор консультации
const GCI::IO::String& Consultation_i::get_id () const
	/*throw (Deleted)*/
{
	//#UC START# *457008050161_45704FB40290_GET*
	this->check_deleted ();
	if (m_id.is_nil ()) {
		CORBA::String_var id = m_server_consultation->id ();
		m_id = GCI::IO::StringFactory::make (id.in ());
	}
	return *(m_id.in());
	//#UC END# *457008050161_45704FB40290_GET*
}

GCI::IO::String& Consultation_i::get_id ()
	/*throw (Deleted)*/
{
	return const_cast<GCI::IO::String&>(((const Consultation_i*)this)->get_id ());
}

// implemented method from Consultation
// Дата последнего изменения статуса
const DateTime& Consultation_i::get_modification_date () const
	/*throw (Deleted)*/
{
	//#UC START# *457008050163_45704FB40290_GET*
	this->check_deleted ();
	try {
		if (m_modification_date.is_nil ()) {
			DateTimeTranslator::translate (m_server_consultation->get_modification_date (), *m_modification_date);
		}
		return *m_modification_date;
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *457008050163_45704FB40290_GET*
}

// implemented method from Consultation
// Имя консультации (текст запроса)
const GCI::IO::String& Consultation_i::get_name () const
	/*throw (Deleted)*/
{
	//#UC START# *457008050164_45704FB40290_GET*
	this->check_deleted ();
	try {
		if (!m_name.ptr ()) {
			Core::Aptr<char> name = m_server_consultation->get_query ();
			m_name = GCI::IO::StringFactory::make (name.in ());
		}
		return *m_name.ptr ();
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *457008050164_45704FB40290_GET*
}

GCI::IO::String& Consultation_i::get_name ()
	/*throw (Deleted)*/
{
	return const_cast<GCI::IO::String&>(((const Consultation_i*)this)->get_name ());
}

// implemented method from Consultation
// Подвердить (answer = true)/отказаться (false) от оплаты
void Consultation_i::payment_confirm (bool answer) /*throw (NoConnection, PaymentForbidden)*/ {
	//#UC START# *45700805015E_45704FB40290*
	this->check_deleted ();
	try {
		ApplicationHelper::instance ()->
			get_cached_consultation_manager ()->payment_confirm (m_server_consultation.in (), answer);
	} catch (::GblConsultingDef::NotConnected&) {
		throw NoConnection ();
	} catch (::GblConsulting::InvalidConsultationID&) {
		return;
	} catch (::GblConsultingClient::PaymentNotAllowed&) {
		throw PaymentForbidden ();
	}
	// Только для поддтверденных запросов нужно перечитывать флги, для отклоненных это сделается автоматом при перечитывании папок
	if (answer) {
		this->refresh_node_flags ();
	}
	//#UC END# *45700805015E_45704FB40290*
}

// implemented method from Consultation
const GCI::IO::String& Consultation_i::get_query_data () const
	/*throw (Deleted)*/
{
	//#UC START# *4CEBCF3F036E_45704FB40290_GET*
	this->check_deleted ();
	try {
		if (m_query.is_nil ()) {
			CORBA::String_var query (m_server_consultation->get_query ());
			m_query = GCI::IO::StringFactory::make (query.in ());
		}
		return *m_query.ptr ();
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEBCF3F036E_45704FB40290_GET*
}

// implemented method from Consultation
// Помечают консультацию как прочитанную
void Consultation_i::read () /*throw (Deleted)*/ {
	//#UC START# *486B5273020E_45704FB40290*
	this->check_deleted ();
	try {
		bool status_changed = false;
		GblConsultingDef::ConsultationStatus server_status = m_server_consultation->get_status ();
		if (server_status.client_status () & GblConsultingDef::CCS_ANSWER_RECEIVED) {
			if (server_status.client_status () & GblConsultingDef::CCS_ESTIMATION_SENT) {
				server_status.client_status (GblConsultingDef::CCS_ESTIMATION_SENT);
				status_changed = true;
			} else {
				server_status.client_status (GblConsultingDef::CCS_READ);
				status_changed = true;
			}
		}
		if (server_status.client_status () & GblConsultingDef::CCS_ANSWER_NOT_CONFIRM) {
			server_status.client_status (GblConsultingDef::CCS_READ_NOT_CONFIRM);
			status_changed = true;
		}
		if (status_changed) {
			m_server_consultation->set_status (server_status);
			this->refresh_node_flags ();
			m_modification_date = 0;
		}
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *486B5273020E_45704FB40290*
}

// implemented method from Consultation
const Date Consultation_i::get_reply_date () const
	/*throw (Deleted)*/
{
	//#UC START# *4CEE1A350233_45704FB40290_GET*
	this->check_deleted ();
	try {
		GblConsultingDef::HCConsultationData_var consultation_data (m_server_consultation->get_consultation_data ());
		Date date;
		DateTranslator::translate_date (consultation_data->date (), date);

		return date;
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEE1A350233_45704FB40290_GET*
}

// implemented method from Consultation
// Отправить оценку
void Consultation_i::send_estimation (const Estimation* value) /*throw (NoConnection, NoSubscription, Deleted)*/ {
	//#UC START# *45700805015B_45704FB40290*
	this->check_deleted ();
	// Отправляем оценку
	GblConsultingDef::EstimationInfo_var estimate = new GblConsultingDef::EstimationInfo ();
	estimate->estimation_value = EstimationTranslatorSingleton::instance ()->get (value->get_value ());
	const GCI::IO::String& text = value->get_text ();
	estimate->text = text.get_data ();
	m_server_consultation->estimate (estimate.in ());
	try {
		ApplicationHelper::instance ()->
			get_cached_consultation_manager ()->send_estimation (m_server_consultation.in ());
	} catch (::GblConsultingDef::NotConnected&) {
		throw NoConnection ();
	} catch (::GblConsultingDef::NoSubscription&) {
		throw NoSubscription ();
	} catch (::GblConsulting::InvalidConsultationID&) {
		return;
	}
	this->refresh_node_flags ();
	//#UC END# *45700805015B_45704FB40290*
}

// implemented method from Consultation
// Статус консультации
ConsultationStatus Consultation_i::get_status () const
	/*throw (Deleted)*/
{
	//#UC START# *457008050160_45704FB40290_GET*
	this->check_deleted ();
	try {
		return ServerAdapterConverters::server_to_adapter (m_server_consultation->get_status ().client_status ());
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *457008050160_45704FB40290_GET*
}

// implemented method from Consultation
const GblConsultingDef::HCConsultationDataType Consultation_i::get_type () const
	/*throw (Deleted)*/
{
	//#UC START# *4CEE59B10371_45704FB40290_GET*
	this->check_deleted ();
	try {
		GblConsultingDef::HCConsultationData_var consultation_data (m_server_consultation->get_consultation_data ());
		return consultation_data->type ();
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEE59B10371_45704FB40290_GET*
}

// implemented method from Consultation
const GCI::IO::String& Consultation_i::get_user_name () const
	/*throw (Deleted)*/
{
	//#UC START# *4CEBCF680012_45704FB40290_GET*
	this->check_deleted ();
	try {
		if (m_user_name.is_nil ()) {
			GblConsultingDef::UserInfo_var user_info (m_server_consultation->get_user_info ());
			m_user_name = GCI::IO::StringFactory::make (user_info->name.in ());
		}
		return *m_user_name.ptr ();
	} catch (::GblConsultingClient::Deleted&) {
		throw Deleted ();
	}
	//#UC END# *4CEBCF680012_45704FB40290_GET*
}

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* Consultation_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_45704FB40290*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_45704FB40290*
}

// implemented method from EntityBase
// идентификатор
const unsigned long Consultation_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_45704FB40290_GET*
	throw Unsupported ();
	//#UC END# *456EE084033C_45704FB40290_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool Consultation_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_45704FB40290_GET*
	return false;
	//#UC END# *456EB3E1017D_45704FB40290_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool Consultation_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_45704FB40290_GET*
	return false;
	//#UC END# *456EB3E1017C_45704FB40290_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* Consultation_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_45704FB40290*
	throw Unsupported ();
	//#UC END# *456EB3E10178_45704FB40290*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

