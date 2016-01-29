////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate.h"
// by <<uses>> dependencies
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentDelegate::DocumentDelegate (DocumentMaster* master, DocumentState_i* new_state)
//#UC START# *460D2463003F_BASE_INIT*
	: Document_i ()
//#UC END# *460D2463003F_BASE_INIT*
{
	//#UC START# *460D2463003F_BODY*
	LOG_D (("DocumentDelegate[%d]::DocumentDelegate", (Document_i*)this));

	this->set_inner_state (new_state);
	m_master_document = Core::IObject::_duplicate (master);
	//#UC END# *460D2463003F_BODY*
}

DocumentDelegate::~DocumentDelegate () {
	//#UC START# *460A602403B0_DESTR_BODY*
	RedactionID id = this->redaction_id ();
	if (id) {
		AomSingleton::instance ()->ptr.erase (id);
	}
	//#UC END# *460A602403B0_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Controllable
// Возвращает true, если разрешена постановка на контроль
const bool DocumentDelegate::get_can_set_to_control () const {
	//#UC START# *48EF5B3402B5_460A602403B0_GET*
	return m_master_document->get_can_set_to_control ();
	//#UC END# *48EF5B3402B5_460A602403B0_GET*
}

// implemented method from Controllable
// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
// приводит к добавлению сущности на контроль, в false соответственно к снятию.
bool DocumentDelegate::get_controlled () const {
	//#UC START# *45EEC17501BB_460A602403B0_GET*
	return m_master_document->get_controlled ();
	//#UC END# *45EEC17501BB_460A602403B0_GET*
}

void DocumentDelegate::set_controlled (bool controlled) {
	//#UC START# *45EEC17501BB_460A602403B0_SET*
	m_master_document->set_controlled (controlled);
	//#UC END# *45EEC17501BB_460A602403B0_SET*
}

// implemented method from Controllable
// Возврящает текущее значение статуса изменений.
unsigned long DocumentDelegate::get_control_status () {
	//#UC START# *45EEC17501B6_460A602403B0*
	return m_master_document->get_control_status ();
	//#UC END# *45EEC17501B6_460A602403B0*
}

// implemented method from Controllable
// Сравнение объектов на контроле.
bool DocumentDelegate::is_same_controllable (const Controllable* other) {
	//#UC START# *45EEC17501B9_460A602403B0*
	return m_master_document->is_same_controllable (other);
	//#UC END# *45EEC17501B9_460A602403B0*
}

// implemented method from Controllable
// Сбрасывает статус изменений в ноль.
void DocumentDelegate::reset_control_status () {
	//#UC START# *45EEC17501B7_460A602403B0*
	m_master_document->reset_control_status ();
	//#UC END# *45EEC17501B7_460A602403B0*
}

// implemented method from Controllable
ControlledItemType DocumentDelegate::get_type () const {
	//#UC START# *45FA9A9C00F5_460A602403B0_GET*
	return m_master_document->get_type ();
	//#UC END# *45FA9A9C00F5_460A602403B0_GET*
}

// implemented method from DocWithPid
const GCD::PID& DocumentDelegate::get_document_pid () const {
	//#UC START# *460A63BD025C_460A602403B0*
	return m_master_document->get_document_pid ();
	//#UC END# *460A63BD025C_460A602403B0*
}

// implemented method from Document
const Document* DocumentDelegate::get_annotation () const {
	//#UC START# *460B8F8F0002_460A602403B0_GET*
	return m_master_document->get_annotation ();
	//#UC END# *460B8F8F0002_460A602403B0_GET*
}

Document* DocumentDelegate::get_annotation () {
	return const_cast<Document*>(((const DocumentDelegate*)this)->get_annotation ());
}

// implemented method from Document
GCD::PID DocumentDelegate::get_redaction_pid () const {
	//#UC START# *528376540040_460A602403B0*
	GCD::PID pid;
	pid.m_object_id = this->redaction_id ();
	pid.m_class_id = Defines::CI_TOPIC;
	return pid;
	//#UC END# *528376540040_460A602403B0*
}

// implemented method from Document
// есть ли у документа хронология рассмотрения судебного дела
// K555095873
bool DocumentDelegate::has_chronology () const {
	//#UC START# *53C3BD6F0050_460A602403B0*
	return false;
	//#UC END# *53C3BD6F0050_460A602403B0*
}

// implemented method from Document
// Проверка возможности отображения атрибутов документа для текущего документа.
// Возвращает true в случае, если показ атрибутов разрешен.
// 
// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции )
bool DocumentDelegate::may_show_attributes () const {
	//#UC START# *45EEB65201D6_460A602403B0*
	return m_master_document->may_show_attributes ();
	//#UC END# *45EEB65201D6_460A602403B0*
}

// implemented method from Document
const RedactionInfoList& DocumentDelegate::get_redactions_list () const {
	//#UC START# *45EED8FA017F_460A602403B0_GET*
	return m_master_document->get_redactions_list ();
	//#UC END# *45EED8FA017F_460A602403B0_GET*
}

// implemented method from Document
const Document* DocumentDelegate::get_related_doc () const {
	//#UC START# *460B8FD603AB_460A602403B0_GET*
	return m_master_document->get_related_doc ();
	//#UC END# *460B8FD603AB_460A602403B0_GET*
}

Document* DocumentDelegate::get_related_doc () {
	return const_cast<Document*>(((const DocumentDelegate*)this)->get_related_doc ());
}

// implemented method from Document
const LanguagesList& DocumentDelegate::get_text_languages () const {
	//#UC START# *45EEBF0F014B_460A602403B0_GET*
	return m_master_document->get_text_languages ();
	//#UC END# *45EEBF0F014B_460A602403B0_GET*
}

// implemented method from Document_i
const DocumentMaster* DocumentDelegate::get_master () const {
	//#UC START# *460A644201AE_460A602403B0*
	return m_master_document.ptr ();
	//#UC END# *460A644201AE_460A602403B0*
}

// implemented method from Document_i
void DocumentDelegate::load_server_doc () const {
	//#UC START# *460A6182006F_460A602403B0*
	RedactionID my_redaction_id = this->redaction_id ();
	RedactionID master_redaction_id = m_master_document->redaction_id ();

	if (my_redaction_id != master_redaction_id) {
		GCD::PID pid;
		pid.m_class_id = Defines::CI_TOPIC;
		pid.m_object_id = my_redaction_id;
		const_cast<DocumentDelegate*>(this)->set_document (
			ApplicationHelper::instance ()->get_cached_function_manager ()->get_document (pid) // LifeCycle::duplicate_object
		);
	} else {
		const_cast<DocumentDelegate*>(this)->set_document (
			GblPilot::Document::_duplicate (m_master_document->get_server_doc ())
		);
		GblPilot::Document_var doc (this->get_document ());
		if (!CORBA::is_nil (doc)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->duplicate_object (doc.in ());
		}
	}
	//#UC END# *460A6182006F_460A602403B0*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
const NodeBase* DocumentDelegate::get_attributes_root () const {
	//#UC START# *45EEC00F006F_460A602403B0_GET*
	return this->has_same_redactions (m_master_document.in ()) ?
		m_master_document->get_attributes_root ()
		: this->Document_i::get_attributes_root ()
	;
	//#UC END# *45EEC00F006F_460A602403B0_GET*
}

NodeBase* DocumentDelegate::get_attributes_root () {
	return const_cast<NodeBase*>(((const DocumentDelegate*)this)->get_attributes_root ());
}

// overloaded method from Document
DocumentType DocumentDelegate::get_doc_type () const {
	//#UC START# *460B80CF0201_460A602403B0_GET*
	return m_master_document->get_doc_type();
	//#UC END# *460B80CF0201_460A602403B0_GET*
}

// overloaded method from Document
void DocumentDelegate::get_correspondents (const NodeBase* category, CatalogBase*& out_list) const {
	//#UC START# *45EEB65201D7_460A602403B0*
	if (this->has_same_redactions (m_master_document.in ())) {
		m_master_document->get_correspondents (category, out_list);
	} else {
		this->Document_i::get_correspondents (category, out_list);
	}
	//#UC END# *45EEB65201D7_460A602403B0*
}

// overloaded method from Document
void DocumentDelegate::get_respondents (const NodeBase* category, CatalogBase*& out_list) const {
	//#UC START# *45EEB65201DA_460A602403B0*
	if (this->has_same_redactions (m_master_document.in ())) {
		m_master_document->get_respondents (category, out_list);
	} else {
		this->Document_i::get_respondents (category, out_list);
	}
	//#UC END# *45EEB65201DA_460A602403B0*
}

// overloaded method from Document
bool DocumentDelegate::has_annotation () const {
	//#UC START# *45EEB65201C8_460A602403B0*
	return m_master_document->has_annotation ();
	//#UC END# *45EEB65201C8_460A602403B0*
}

// overloaded method from Document
// Проверка наличия корреспондентов (любогй категории) у текущего документа.
// Возвращает true в случае, если список корреспондентов для документа по категории CR_ALL не пуст.
// 
// для редакций, отличных от "главной", возвращает FALSE
bool DocumentDelegate::has_correspondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C0_460A602403B0*
	return this->has_same_redactions (m_master_document.in ())
		? m_master_document->has_correspondents (category)
		: this->Document_i::has_correspondents (category)
	;
	//#UC END# *45EEB65201C0_460A602403B0*
}

// overloaded method from Document
// Проверка наличия справки у текущего документа.
// Возвращает true в случае, если у текущего документа есть справка.
// 
// для редакций, отличных от "главной", поведение такое же как и для "главной"
bool DocumentDelegate::has_related_doc () const {
	//#UC START# *45EEB65201C5_460A602403B0*
	return m_master_document->has_related_doc ();
	//#UC END# *45EEB65201C5_460A602403B0*
}

// overloaded method from Document
// Проверка наличия респондентов (любогй категории) у текущего документа.
// Возвращает true в случае, если список респондентов для документа по категории CR_ALL не пуст.
// 
// для редакций, отличных от "главной", возвращает FALSE
bool DocumentDelegate::has_respondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C6_460A602403B0*
	return this->has_same_redactions (m_master_document.in ())
		? m_master_document->has_respondents (category)
		: this->Document_i::has_respondents (category)
	;
	//#UC END# *45EEB65201C6_460A602403B0*
}

// overloaded method from Document
// Статус документа
const ItemStatus DocumentDelegate::get_status () const {
	//#UC START# *45EEBECB019A_460A602403B0_GET*
	return this->has_same_redactions (m_master_document.in ())
		? m_master_document->get_status ()
		: this->Document_i::get_status ()
	;
	//#UC END# *45EEBECB019A_460A602403B0_GET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

