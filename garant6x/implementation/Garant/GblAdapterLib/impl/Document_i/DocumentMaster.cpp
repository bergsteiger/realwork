////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentMaster
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/RedactionTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

//#UC START# *460A604B02E4_CUSTOM_INCLUDES*
#include "garantServer/src/Global/Core/Common/Operators.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"
//#UC END# *460A604B02E4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *460A604B02E4*
//#UC END# *460A604B02E4*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

char DocumentMaster::s_may_show_attributes;


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentMaster::DocumentMaster (GblPilot::Document* document)
//#UC START# *460CC502011F_BASE_INIT*
	: Document_i(document)
	, m_under_control_status (0)
	, m_can_set_to_control (boost::indeterminate)
//#UC END# *460CC502011F_BASE_INIT*
{
	//#UC START# *460CC502011F_BODY*
	//#UC END# *460CC502011F_BODY*
}

DocumentMaster::DocumentMaster (const GCD::PID& pid, const char* name)
//#UC START# *49B91732023C_BASE_INIT*
: Document_i (name)
, m_under_control_status (0)
, m_can_set_to_control (boost::indeterminate)
//#UC END# *49B91732023C_BASE_INIT*
{
	//#UC START# *49B91732023C_BODY*
	m_pid = pid;
	//#UC END# *49B91732023C_BODY*
}

DocumentMaster::~DocumentMaster () {
	//#UC START# *460A604B02E4_DESTR_BODY*
	if (!m_pid.is_nil ()) {
		AomSingleton::instance ()->ptr.erase (m_pid->m_object_id);
	}
	//#UC END# *460A604B02E4_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает true, если список проинициализированн, иначе false
bool DocumentMaster::is_redaction_info_list_init () const {
	//#UC START# *4949041101BB*
	return !m_redaction_info_list.is_nil ();
	//#UC END# *4949041101BB*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const RedactionInfoList DocumentMaster::get_redaction_info_list () const {
	//#UC START# *460CC4260026_GET_ACCESSOR*
	return *m_redaction_info_list;
	//#UC END# *460CC4260026_GET_ACCESSOR*
}

void DocumentMaster::set_redaction_info_list (const RedactionInfoList& redaction_info_list) const {
	//#UC START# *460CC4260026_SET_ACCESSOR*
	m_redaction_info_list = redaction_info_list;
	//#UC END# *460CC4260026_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Controllable
// Возвращает true, если разрешена постановка на контроль
const bool DocumentMaster::get_can_set_to_control () const {
	//#UC START# *48EF5B3402B5_460A604B02E4_GET*
	if (boost::indeterminate (m_can_set_to_control)) {
		m_can_set_to_control = this->is_alive ();
	}
	return m_can_set_to_control;
	//#UC END# *48EF5B3402B5_460A604B02E4_GET*
}

// implemented method from Controllable
// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
// приводит к добавлению сущности на контроль, в false соответственно к снятию.
bool DocumentMaster::get_controlled () const {
	//#UC START# *45EEC17501BB_460A604B02E4_GET*
	try {
		return ControlManagerFactory::make ().get_under_control_status (this->get_document_pid (), m_under_control_status);
	} catch (GCD::FeatureDisabled&) {
		return false;
	}	
	//#UC END# *45EEC17501BB_460A604B02E4_GET*
}

void DocumentMaster::set_controlled (bool controlled) {
	//#UC START# *45EEC17501BB_460A604B02E4_SET*
	bool update_controlled_flags;

	update_controlled_flags = false;

	if (controlled) {
		try {
			this->get_server_doc()->add_to_control ();
			update_controlled_flags = true;
		} catch (GCD::AlreadyControlled&) {
			throw AlreadyControlled ();
		} catch (GblPilot::CanNotPerformOperation&) {
			// Документ нельзя поставить на контроль, так как его нет в базе или просмотр запрещен
			// Очень "понятно" называющееся исключение
			m_can_set_to_control = false; // все дальнейшие манипуляции с контролем для этого документа - запрещены
										  // это нужно для экзотической ситуации, когда документ открыт для просмотра, но в это время
										  // админ запрещает пользователю его просмотр
										  // хотя визуально выглядеть будет криво - кнопка останется нажатой (это делает оболочка)
										  // но задизейбленной
										  // http://mdp.garant.ru/pages/viewpage.action?pageId=296618317 

		} catch (CORBA::TRANSIENT&) {
			throw GblAdapterLib::NoServer ();
		} catch (...) {
			GDS_ASSERT (false);// throw NotSaved (); - это походу какой-то ошметок со времен, 
							   // когда на контроль можно было ставить толкьо через папки
		}
	} else {
		try {
			this->get_server_doc()->remove_from_control ();
			update_controlled_flags = true;
		} catch (CORBA::TRANSIENT&) {
			throw GblAdapterLib::NoServer ();
		} catch (...) {
			throw NotUnderControl ();
		}
	}
	
	if (update_controlled_flags) {
		ControlManagerFactory::make ().refresh_control_status ();
	}
	//#UC END# *45EEC17501BB_460A604B02E4_SET*
}

// implemented method from Controllable
// Возврящает текущее значение статуса изменений.
unsigned long DocumentMaster::get_control_status () {
	//#UC START# *45EEC17501B6_460A604B02E4*
	this->load_and_update ();

	if (!this->get_controlled ()) {
		return 0;
	}
	return m_under_control_status;
	//#UC END# *45EEC17501B6_460A604B02E4*
}

// implemented method from Controllable
// Сравнение объектов на контроле.
bool DocumentMaster::is_same_controllable (const Controllable* other) {
	//#UC START# *45EEC17501B9_460A604B02E4*
	if (static_cast<Controllable*> (this) == other) {
		return true;
	}
	
	if (const DocWithPid* doc = dynamic_cast <const DocWithPid*> (other)) {
		return doc->get_document_pid () == this->get_document_pid ();
	}
	
	if (const FoldersNode_i* folders_node_i = dynamic_cast <const FoldersNode_i*> (other)) {
		return folders_node_i->get_document_pid () == this->get_document_pid ();
	}

	return false;
	//#UC END# *45EEC17501B9_460A604B02E4*
}

// implemented method from Controllable
// Сбрасывает статус изменений в ноль.
void DocumentMaster::reset_control_status () {
	//#UC START# *45EEC17501B7_460A604B02E4*
	if (this->get_controlled ()) {
		this->get_server_doc ()->reset_controlled_status ();
		ControlManagerFactory::make ().refresh_control_status ();
	}
	//#UC END# *45EEC17501B7_460A604B02E4*
}

// implemented method from Controllable
ControlledItemType DocumentMaster::get_type () const {
	//#UC START# *45FA9A9C00F5_460A604B02E4_GET*
	return CIT_DOCUMENT;
	//#UC END# *45FA9A9C00F5_460A604B02E4_GET*
}

// implemented method from DocWithPid
const GCD::PID& DocumentMaster::get_document_pid () const {
	//#UC START# *460A63BD025C_460A604B02E4*
	if (m_pid.is_nil()) {
		m_pid = this->get_server_doc()->get_pid ();
	}
	return *m_pid;
	//#UC END# *460A63BD025C_460A604B02E4*
}

// implemented method from Document
const Document* DocumentMaster::get_annotation () const {
	//#UC START# *460B8F8F0002_460A604B02E4_GET*
	// annotation is like Related Document now
	try {
		if (m_annotation.is_nil ()) {
			GblPilot::LegalDocument_var legal_doc = GblPilot::LegalDocument::_narrow (this->get_server_doc());
			GblPilot::Document_var annotation = legal_doc->get_annotation ();
			m_annotation = DocumentFactory::make (annotation.in (), FK_SIMPLE_DOCUMENT);
		}
	} catch (...) {
		throw CanNotFindData ();
	}

	return m_annotation._sretn ();
	//#UC END# *460B8F8F0002_460A604B02E4_GET*
}

Document* DocumentMaster::get_annotation () {
	return const_cast<Document*>(((const DocumentMaster*)this)->get_annotation ());
}

// implemented method from Document
GCD::PID DocumentMaster::get_redaction_pid () const {
	//#UC START# *528376540040_460A604B02E4*
	return this->get_document_pid ();
	//#UC END# *528376540040_460A604B02E4*
}

// implemented method from Document
// есть ли у документа хронология рассмотрения судебного дела
// K555095873
bool DocumentMaster::has_chronology () const {
	//#UC START# *53C3BD6F0050_460A604B02E4*
	try {
		GblPilot::LegalDocument_var legal_doc = GblPilot::LegalDocument::_narrow (this->get_server_doc());
		if (!CORBA::is_nil (legal_doc)) {
			return legal_doc->has_chronology ();
		}
	} catch (...) {
	}

	return false;
	//#UC END# *53C3BD6F0050_460A604B02E4*
}

// implemented method from Document
// Проверка возможности отображения атрибутов документа для текущего документа.
// Возвращает true в случае, если показ атрибутов разрешен.
// 
// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции )
bool DocumentMaster::may_show_attributes () const {
	//#UC START# *45EEB65201D6_460A604B02E4*
	//this->load_and_update ();
	return true;

	// SES: Закоментировано для будущего использования, если маркетинг изменит свое решение См. CQ 12559

	//if (s_may_show_attributes == -1) {
	//	s_may_show_attributes = false;

	//	try {
	//		GslUserManager::UserManager_ptr user_manager;
	//		GslSecurity::SecurityManager_ptr security_manager;
	//		GslUserManager::Profile_var profile;

	//		user_manager = ApplicationHelper::instance ()->get_cached_user_manager ();
	//		security_manager = ApplicationHelper::instance ()->get_cached_security_manager ();
	//		profile = user_manager->get_current_profile();
	//		if (!CORBA::is_nil (profile) && security_manager->is_allowed (profile, this->get_document_pid (), Defines::AI_GET_FULL_ATTRIBUTES)) {
	//			s_may_show_attributes = true;
	//		}
	//	} catch (...) {
	//	}	
	//}

	//return s_may_show_attributes != 0;
	//#UC END# *45EEB65201D6_460A604B02E4*
}

// implemented method from Document
const RedactionInfoList& DocumentMaster::get_redactions_list () const {
	//#UC START# *45EED8FA017F_460A604B02E4_GET*
	// TODO: попилить
	if (m_redaction_info_list.is_nil ()) {
		GblPilotDef::RedactionInfoList_var ri_list;

		try {
			ri_list = this->get_server_doc()->get_redactions ();
		} catch (GCD::CanNotFindData&) {
			m_redaction_info_list = new RedactionInfoList ();
			return *(m_redaction_info_list.ptr ());
		}
	

		CORBA::ULong length = ri_list->length ();

		m_redaction_info_list = new RedactionInfoList (length);

		for (CORBA::ULong i = 0; i < length; ++i) {
			RedactionInfo* data_ptr = &(m_redaction_info_list->at (i));

			data_ptr->id = ri_list [i].m_id;
			data_ptr->actual_type = RedactionTypeTranslatorSingleton::instance ()->get (ri_list [i].m_status);
			data_ptr->is_comparable = ri_list[i].m_is_comparable; // [$190678297]
			
			// copy activity intervals
			ServerAdapterConverters::copy_intervals (&(ri_list [i].m_activity), data_ptr->active_intervals);
			
			// copy not sure intervals
			CORBA::ULong not_sure_length = ri_list [i].m_not_sure_date.length ();
			for (CORBA::ULong j = 0; j < not_sure_length; ++j) {
				NotSureInfo	not_sure_info;
				DateTranslator::translate (ri_list [i].m_not_sure_date [j].m_from, not_sure_info.interval.start);
				DateTranslator::translate (ri_list [i].m_not_sure_date [j].m_to, not_sure_info.interval.finish);
				not_sure_info.warning = GCI::IO::StringFactory::make (ri_list [i].m_not_sure_date [j].m_warning.in ());
				data_ptr->not_sure_intervals.push_back (not_sure_info);
			}

			// changing document list
			CORBA::ULong changing_document_list_size = ri_list [i].m_changing_document_list.length ();
			for (CORBA::ULong j = 0; j < changing_document_list_size; ++j) {
				RedactionSourceDocumentInfo redaction_source_document_info;
				redaction_source_document_info.display_name = GCI::IO::StringFactory::make (ri_list [i].m_changing_document_list [j].title.in ());
				redaction_source_document_info.doc_topic.pid.object_id = ri_list [i].m_changing_document_list [j].topic;
				redaction_source_document_info.doc_topic.pid.class_id = Defines::CI_TOPIC;
				redaction_source_document_info.doc_topic.position.type = PT_SUB;
				redaction_source_document_info.doc_topic.position.point = ri_list [i].m_changing_document_list [j].sub;
				data_ptr->changing_documents.push_back (redaction_source_document_info);
			}

			if (ri_list [i].m_activity [0].m_from.m_year != 0) {
				DateTranslator::translate(ri_list[i].m_activity [0].m_from, data_ptr->time_machine_date);
			} else {
				DateTranslator::translate(ri_list [i].m_date, data_ptr->time_machine_date);
			}
			
			DateTranslator::translate (ri_list [i].m_date, data_ptr->doc_date);

			if (ri_list [i].m_status == GblPilotDef::rs_Old
				&& ri_list [i].m_activity [0].m_from.m_year == 0
				&& ri_list [i].m_activity [0].m_to.m_year == 0
				&& data_ptr->time_machine_date.year == 0
				&& i > 0
			) {
				RedactionInfo* prev_data_ptr = &(m_redaction_info_list->at (i-1));    // TIME MACHINE
				data_ptr->time_machine_date = prev_data_ptr->time_machine_date;       // TIME MACHINE
			}

			data_ptr->name = GCI::IO::StringFactory::make (ri_list [i].m_name.in ());
		}
	}

	return *m_redaction_info_list;
	//#UC END# *45EED8FA017F_460A604B02E4_GET*
}

// implemented method from Document
const Document* DocumentMaster::get_related_doc () const {
	//#UC START# *460B8FD603AB_460A604B02E4_GET*
	if (m_related_doc.is_nil ()) {
		try {
			GblPilot::Document_var rel = this->get_server_doc ()->get_related_doc ();
			m_related_doc = DocumentFactory::make (rel.in (), FK_SIMPLE_DOCUMENT);
		} catch (GCD::CanNotFindData&) {
			throw CanNotFindData ();
		}
	}
	return m_related_doc._sretn ();
	//#UC END# *460B8FD603AB_460A604B02E4_GET*
}

Document* DocumentMaster::get_related_doc () {
	return const_cast<Document*>(((const DocumentMaster*)this)->get_related_doc ());
}

// implemented method from Document
const LanguagesList& DocumentMaster::get_text_languages () const {
	//#UC START# *45EEBF0F014B_460A604B02E4_GET*
	this->load_and_update ();
	return m_language_list;
	//#UC END# *45EEBF0F014B_460A604B02E4_GET*
}

// implemented method from Document_i
const DocumentMaster* DocumentMaster::get_master () const {
	//#UC START# *460A644201AE_460A604B02E4*
	return this;
	//#UC END# *460A644201AE_460A604B02E4*
}

// implemented method from Document_i
void DocumentMaster::load_server_doc () const {
	//#UC START# *460A6182006F_460A604B02E4*
	const_cast<DocumentMaster*> (this)->set_document (
		ApplicationHelper::instance ()->get_cached_function_manager ()->get_document (this->get_document_pid ()) // LifeCycle::duplicate_object
	);
	//#UC END# *460A6182006F_460A604B02E4*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from BaseUpdateChecker_i
void DocumentMaster::clear_cache () {
	//#UC START# *45702DA9037A_460A604B02E4*
	Document_i::clear_cache ();
	m_related_doc = 0;
	m_redaction_info_list = 0;
	m_language_list.clear ();
	m_can_set_to_control = boost::indeterminate;
	//#UC END# *45702DA9037A_460A604B02E4*
}

// overloaded method from Document
// Статус документа
const ItemStatus DocumentMaster::get_status () const {
	//#UC START# *45EEBECB019A_460A604B02E4_GET*
	this->load_and_update ();
	return this->get_status_impl ();
	//#UC END# *45EEBECB019A_460A604B02E4_GET*
}

// overloaded method from Document_i
void DocumentMaster::load (GblPilotDef::ExtendedDocInfo* edi) const {
	//#UC START# *460A61D501D6_460A604B02E4*
	Document_i::load (edi);

	if (m_pid.is_nil()) {
		*m_pid = edi->pid ();
	}

	ServerAdapterConverters::server_to_adapter (edi->available_languages (), m_language_list);
	//#UC END# *460A61D501D6_460A604B02E4*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

