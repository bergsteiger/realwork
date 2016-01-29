////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i_factory.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"

//#UC START# *457050AC03A9_CUSTOM_INCLUDES*
#include <fstream>

#include "garantServer/src/Global/Core/Common/XMLParser.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i.h" // XXX: запил от циклической ссылки
//#UC END# *457050AC03A9_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *457050AC03A9*
inline bool operator == (const GCD::PID& a, const GCD::PID& b) {
	return (a.m_class_id == b.m_class_id  && a.m_object_id == b.m_object_id);
}

struct ServerConsultationLCRemover {
	ServerConsultationLCRemover (GblConsultingClient::Consultation_ptr server_consultation) 
		: m_server_consultation (server_consultation) 
	{
		GDS_ASSERT (!CORBA::is_nil (m_server_consultation));
	}

	~ServerConsultationLCRemover () {
		ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (m_server_consultation);
	}

private:
	GblConsultingClient::Consultation_ptr m_server_consultation;
};
//#UC END# *457050AC03A9*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
const unsigned long FoldersNode_i::MAX_TREE_DEPTH = 5;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FoldersNode_i::FoldersNode_i (Containers::Content* content, Folders* folders)
//#UC START# *45EED5F0008E_45EEDDBC00AE_457050AC03A9_BASE_INIT*
	: m_flags (0)
	, m_under_control_status (0)
	, m_content (Containers::Content::_duplicate (content))
	, m_folders_manager (dynamic_cast <FoldersManager_i*> (folders))

//#UC END# *45EED5F0008E_45EEDDBC00AE_457050AC03A9_BASE_INIT*
{
	//#UC START# *45EED5F0008E_45EEDDBC00AE_457050AC03A9_BODY*
	this->update_content ();
	this->load_children ();
	//#UC END# *45EED5F0008E_45EEDDBC00AE_457050AC03A9_BODY*
}

FoldersNode_i::~FoldersNode_i () {
	//#UC START# *457050AC03A9_DESTR_BODY*
	//#UC END# *457050AC03A9_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Рекурсивный поиск ребенка по идентификатору
FoldersNode* FoldersNode_i::find_node_by_id (FolderId id) const {
	//#UC START# *45F931D5001F*
	FoldersNode_var folders_node = 0;
	for (long i = 0; i < this->get_child_count (); ++i) {
		Node_var child_node;
		FoldersNode_var child_folders_node;

		child_node = const_cast <FoldersNode_i*> (this)->get_child (i);
		child_folders_node = Core::IObject::_duplicate (dynamic_cast <FoldersNode*> (child_node.in ()));
		if (child_folders_node->get_id () == id) {
			folders_node = child_folders_node._retn ();
			break;
		} else {
			FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (child_folders_node.ptr ());
			folders_node = folders_node_i->find_node_by_id (id);
			if (folders_node.ptr () != 0) {
				break;
			}
		}
	}
	return folders_node._retn ();
	//#UC END# *45F931D5001F*
}

GCD::PID FoldersNode_i::get_document_pid () const {
	//#UC START# *45F9333D01E4*
	GCD::PID retv;

	retv.m_class_id = 0;
	retv.m_object_id = 0;
	if (this->is_bookmark ()) {
		if (m_pid.is_nil()) {
			GblFolders::DocBookmark_var doc_bookmark;

			doc_bookmark = GblFolders::DocBookmark::_narrow (m_content);
			try {
				*m_pid = doc_bookmark->get_doc_pid ();
			} catch (...) {
				// [dk]: гасим все исключения, для случая, если есть закладка на несуществующий в базе документ
			}
		}
		retv = *m_pid;
	}
	return retv;
	//#UC END# *45F9333D01E4*
}

GblFolders::Folder* FoldersNode_i::get_folder () {
	//#UC START# *45FE9AE500CB*
	if (m_content_type == Defines::CT_FOLDER) {
		return GblFolders::Folder::_narrow (m_content);
	} else {
		return 0;
	}
	//#UC END# *45FE9AE500CB*
}

// Является ли контент ноды закладкой
bool FoldersNode_i::is_bookmark () const {
	//#UC START# *4EA110DA0024*
	return (m_content_type == Defines::CT_DOC_BOOKMARK || m_content_type == Defines::CT_PHARM_BOOKMARK);
	//#UC END# *4EA110DA0024*
}

// проверка или папка "Мои документы"
bool FoldersNode_i::is_my_documents () const {
	//#UC START# *4B821FCA0104*
	return m_flags & NF_MY_DOCUMENTS;
	//#UC END# *4B821FCA0104*
}

// папка "Мои документы" или ее содержимое
bool FoldersNode_i::is_my_documents_or_lower () const {
	//#UC START# *4697626102FD*
	for (
		FoldersNode_i_cvar parent_node (FoldersNode_i::_duplicate (this))
		; !parent_node.is_nil ()
		; parent_node = dynamic_cast<const FoldersNode_i*> (parent_node->get_parent ())
	) {
		if (parent_node->is_my_documents ()) {
			return true;
		}
	}

	return false;
	//#UC END# *4697626102FD*
}

// Прогрузить детей, рекурсивно
void FoldersNode_i::load_children () {
	//#UC START# *45F9313603D8*
	CORBA::ULong i;
	//
	// Прогружаем рекурсивно всех детей
	//
	if (!CORBA::is_nil (m_content.in ())) {
		if (m_content_type == Defines::CT_FOLDER ) {
			GblFolders::Folder_var folder;
			folder = GblFolders::Folder::_narrow (m_content.in ());
			GCD::SequenceIndex count = 0;
			try {
				count = folder->count ();
			} catch(...) {
			}

			if (count > 0) {
				Containers::ContentList_var content_list;
				try
				{
					content_list = folder->get_contents (0, count);
				} catch(...) {
				}

				for (i = 0; i < content_list->length (); i ++) {
					FoldersNode_i* node;
					try {
						node = new FoldersNode_i (content_list [i].in (), m_folders_manager);
					} catch (...) {
						continue;
					}
					this->insert_back_child (node);
				}
			}
		} else if (m_content_type == Defines::CT_DOC_BOOKMARK) {
		} else if (m_content_type == Defines::CT_SAVED_LIST) {
		} else if (m_content_type == Defines::CT_SAVED_QUERY) {
		} else if (m_content_type == Defines::CT_CONSULTATION) {
		} else if (m_content_type == Defines::CT_SAVED_PHARM_LIST) {
		} else if (m_content_type == Defines::CT_PHARM_BOOKMARK) {
		}
	}
	//#UC END# *45F9313603D8*
}

void FoldersNode_i::recalc_consultations_flag () {
	//#UC START# *45742398006D*
	GblFolders::SavedConsultation_var saved_consultation;
	saved_consultation = GblFolders::SavedConsultation::_narrow (m_content);
	if (!CORBA::is_nil (saved_consultation)) {
		GblConsultingClient::Consultation_var server_consultation = saved_consultation->get_consultation ();
		ServerConsultationLCRemover remover (server_consultation.in ());
		// Флаги для самих консультаций
		unsigned long flag = ServerAdapterConverters::consultation_status_to_folders_flag (server_consultation->get_status ().client_status ());
		if (flag & NF_CONSULTATION_SENT) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_CONSULTATION_SENT);
		}
		if (flag & NF_PAYMENT_REQUEST) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_PAYMENT_REQUEST);
		}
		if (flag & NF_ANSWER_RECEIVED) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_ANSWER_RECEIVED);
		}
		if (flag & NF_ANSWER_READ) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_ANSWER_READ);
		}
		if (flag & NF_ESTIMATION_SENT) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_ESTIMATION_SENT);
		}

		if (flag & NF_DRAFTS) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_DRAFTS);
		}

		if (flag & NF_PAYMENT_REFUSAL) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_PAYMENT_REFUSAL);
		}

		if (flag & NF_PAYMENT_CONFIRM) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_PAYMENT_CONFIRM);
		}
		if (flag & NF_VALIDATION_FAILED) {
			m_flags |= flag;
		} else {
			m_flags -= (m_flags & NF_VALIDATION_FAILED);
		}
	}
	//#UC END# *45742398006D*
}

void FoldersNode_i::recalc_external_flag () {
	//#UC START# *45F93397030D*
	GblFolders::Folder_var folder_content;

	folder_content = GblFolders::Folder::_narrow (m_content);

	if (!CORBA::is_nil (folder_content)) {
		GblFolders::FolderAttribute fa = folder_content->get_attribute ();
		if (fa == GblFolders::FA_COMMON) {
			m_flags |= NF_COMMON;
		} else {
			m_flags -= (m_flags & NF_COMMON);
		}
		if (fa == GblFolders::FA_MY_COMMENTS) {
			m_flags |= NF_COMMENTS;
		} else {
			m_flags -= (m_flags & NF_COMMENTS);
		}

		if (fa == GblFolders::FA_MY_DOCUMENTS) {
			m_flags |= NF_MY_DOCUMENTS;
		} else {
			m_flags -= (m_flags & NF_MY_DOCUMENTS);
		}

		if (folder_content->get_folder_privacy_type () == GblFolders::ft_public) {
			m_flags |= NF_SHARED;
		} else {
			m_flags -= (m_flags & NF_SHARED);
		}

		// Флаги в папке Мои консультации
		if (fa == GblFolders::FA_MY_CONSULTATION) {
			m_flags |= NF_MY_CONSULTATIONS;
		} else {
			m_flags -= (m_flags & NF_MY_CONSULTATIONS);
		}

		if (fa == GblFolders::FA_SENT) {
			m_flags |= NF_FOLDER_SENT;
		} else {
			m_flags -= (m_flags & NF_FOLDER_SENT);
		}

		if (fa == GblFolders::FA_RECEIVED) {
			m_flags |= NF_FOLDER_RECEIVED;
		} else {
			m_flags -= (m_flags & NF_FOLDER_RECEIVED);
		}

		if (fa == GblFolders::FA_DRAFTS) {
			m_flags |= NF_FOLDER_DRAFTS;
		} else {
			m_flags -= (m_flags & NF_FOLDER_DRAFTS);
		}

		if (fa == GblFolders::FA_NOT_SENT) {
			m_flags |= NF_FOLDER_PAYMENT_REFUSAL;
		} else {
			m_flags -= (m_flags & NF_FOLDER_PAYMENT_REFUSAL);
		}
	}

	this->recalc_consultations_flag ();

	if (!CORBA::is_nil (folder_content)) {
		if (ApplicationHelper::instance ()->get_cached_current_user_id () == folder_content->get_owner ()) {
			m_flags -= (m_flags & NF_EXTERNAL);
		} else {
			m_flags |= NF_EXTERNAL;
		}
	} else {
		Node_cvar parent_node = this->get_parent ();
		if (!parent_node.is_nil ()) {
			m_flags |= (parent_node->get_flags () & NF_EXTERNAL);
		}
	}
	//#UC END# *45F93397030D*
}

// Обновить флаг flag2
// Вызывается рекурсивно от родителя передачей кумулятивного флага from_node
// Возвращает true если хотя бы один из детенышей имеет флаг flag1
bool FoldersNode_i::recalc_node_flags (bool from_node, unsigned long flag1, unsigned long flag2) {
	//#UC START# *45F9319703D8*
	m_flags -= (m_flags & flag2);

	if (from_node) {
		m_flags |= flag2;
	}

	for (long i = 0; i < this->get_child_count (); ++i) {
		Node_var child_node = this->get_child (i);

		FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (child_node.in ());
		folders_node_i->recalc_node_flags ((m_flags & (flag1 | flag2)) != 0, flag1, flag2);
	}
	return (m_flags & flag1) != 0;
	//#UC END# *45F9319703D8*
}

// Обновить флаги NF_HAS_SHARED, NF_IN_SHARED
// Вызывается рекурсивно от родителя передачей кумулятивного флага from_shared
// Возвращает true если хотя бы один из детенышей имеет флаг NS_SHARED
bool FoldersNode_i::recalc_shared_flags (bool from_shared) {
	//#UC START# *45F9316A03B9*
	// clear shared flags
	m_flags -= (m_flags & (NF_HAS_SHARED | NF_IN_SHARED));

	if (from_shared) {
		m_flags |= NF_IN_SHARED;
	}

	for (long i = 0; i < this->get_child_count (); ++i) {
		Node_var child_node = this->get_child (i);

		FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (child_node.in ());
		if (folders_node_i->recalc_shared_flags ((m_flags & (NF_SHARED | NF_IN_SHARED)) != 0)) {
			m_flags |= NF_HAS_SHARED;
		}
	}
	return (m_flags & (NF_SHARED | NF_HAS_SHARED)) != 0;
	//#UC END# *45F9316A03B9*
}

void FoldersNode_i::recursive_recalc_consultations_flag () {
	//#UC START# *4574278C0213*
	this->recalc_consultations_flag ();
	for (long i = 0; i < this->get_child_count (); ++i) {
		Node_var child_node = this->get_child (i);
		FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (child_node.in ());
		folders_node_i->recursive_recalc_consultations_flag ();
	}
	//#UC END# *4574278C0213*
}

void FoldersNode_i::set_shared_flag (bool is_shared) {
	//#UC START# *45F9337C029F*
	if (is_shared) {
		m_flags |= NF_SHARED;
	} else {
		m_flags -= (m_flags & NF_SHARED);
	}

	m_folders_manager->recalc_shared_flags ();
	//#UC END# *45F9337C029F*
}

// Обновить кэш всех детей
void FoldersNode_i::update_children () {
	//#UC START# *45F93118001F*
	this->clear_children ();
	this->load_children ();
	//#UC END# *45F93118001F*
}

// Обновить содержимое этого узла
void FoldersNode_i::update_content () {
	//#UC START# *45F93109032C*
	GCD::GCDate date;
	tm* time_struct;

	m_folder_element = GblFolders::FolderElement::_narrow (m_content);
	::GblFolders::FolderElementInfo_var folder_element_info = m_folder_element->info ();
	m_id = folder_element_info->id;
	m_content_type = folder_element_info->type;
	m_type = ContentTypeConvertorSingleton::instance ()->get (m_content_type);
	m_caption = GCI::IO::StringFactory::make (folder_element_info->name);
	m_hint = GCI::IO::StringFactory::make (folder_element_info->comment);

	date = folder_element_info->create_date;
	time_t _time = *(const long*)&date;
	time_struct = localtime (&_time);
	if (time_struct) { // if date < 01.01.1970 localtime return 0, so we must check it
		m_creation_date.day = time_struct->tm_mday;
		m_creation_date.month = time_struct->tm_mon + 1; // месяцы начинаются с 0
		// так написано в MSDN (уроды)
		m_creation_date.year = time_struct->tm_year + 1900;
	}

	// check External flag
	this->recalc_external_flag ();
	//#UC END# *45F93109032C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Controllable
// Возвращает true, если разрешена постановка на контроль
const bool FoldersNode_i::get_can_set_to_control () const {
	//#UC START# *48EF5B3402B5_457050AC03A9_GET*
	GDS_ASSERT (this->is_bookmark ());
	GCD::PID pid = this->get_pid ();
	Document_cvar document = DocumentFactory::make (pid, true, 0, DocumentFactoryKeyHelper::PID_to_key (pid));
	return document->get_can_set_to_control ();
	//#UC END# *48EF5B3402B5_457050AC03A9_GET*
}

// implemented method from Controllable
// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
// приводит к добавлению сущности на контроль, в false соответственно к снятию.
bool FoldersNode_i::get_controlled () const {
	//#UC START# *45EEC17501BB_457050AC03A9_GET*
	return (this->get_flags () & NF_CONTROLLED) != 0;
	//#UC END# *45EEC17501BB_457050AC03A9_GET*
}

void FoldersNode_i::set_controlled (bool controlled) {
	//#UC START# *45EEC17501BB_457050AC03A9_SET*
	if (controlled) {
		ControlManagerFactory::make ().add (this->get_pid ());
	} else {
		ControlManagerFactory::make ().remove (this->get_pid ());
	}
	ControlManagerFactory::make ().refresh_control_status ();
	//#UC END# *45EEC17501BB_457050AC03A9_SET*
}

// implemented method from Controllable
// Возврящает текущее значение статуса изменений.
unsigned long FoldersNode_i::get_control_status () {
	//#UC START# *45EEC17501B6_457050AC03A9*
	if (this->get_controlled ()) {
		return m_under_control_status;
	} else {
		throw NotUnderControl ();
	}
	//#UC END# *45EEC17501B6_457050AC03A9*
}

// implemented method from Controllable
// Сравнение объектов на контроле.
bool FoldersNode_i::is_same_controllable (const Controllable* other) {
	//#UC START# *45EEC17501B9_457050AC03A9*
	bool retv = false;
	const Controllable* this_controlable = dynamic_cast <const Controllable*> (this);

	if (this_controlable == other) {
		retv = true;
	} else {
		const Document* other_document = dynamic_cast <const Document*> (other);	
		const DocWithPid* other_document_i = dynamic_cast <const DocWithPid*> (other_document);
		if (other_document_i != 0) {
			if (this->get_document_pid () == other_document_i->get_document_pid ()) {
				retv = true;
			}
		} else {
			const FoldersNode* folders_node = dynamic_cast <const FoldersNode*> (other);
			if (folders_node) {
				if (this->get_pid () == folders_node->get_pid ()) {
					retv = true;
				}
			}
		}
	}
	return retv;
	//#UC END# *45EEC17501B9_457050AC03A9*
}

// implemented method from Controllable
const GCI::IO::String& FoldersNode_i::get_name () const {
	//#UC START# *4BFE1E970136_457050AC03A9_GET*
	GDS_ASSERT (false && "need to be implemented");
	return this->get_short_name ();
	//#UC END# *4BFE1E970136_457050AC03A9_GET*
}

GCI::IO::String& FoldersNode_i::get_name () {
	return const_cast<GCI::IO::String&>(((const FoldersNode_i*)this)->get_name ());
}

// implemented method from Controllable
// Сбрасывает статус изменений в ноль.
void FoldersNode_i::reset_control_status () {
	//#UC START# *45EEC17501B7_457050AC03A9*
	if (this->get_controlled ()) {
		ControlManagerFactory::make ().reset_control_status (this->get_pid ());
	}
	//#UC END# *45EEC17501B7_457050AC03A9*
}

// implemented method from Controllable
// Название объекта на контроле.
const GCI::IO::String& FoldersNode_i::get_short_name () const {
	//#UC START# *45EEC17501BC_457050AC03A9_GET*
	if (m_short_doc_name.is_nil () && this->is_bookmark ()) {
		GblFolders::DocBookmark_var doc_bookmark = GblFolders::DocBookmark::_narrow (
			const_cast <FoldersNode_i*> (this)->m_content
		);
		try {
			GblPilotDef::Bookmark bookmark = doc_bookmark->get_bookmark ();
			GCD::PersistentObj_var object =
				ApplicationHelper::instance ()->get_cached_function_manager ()->get_object_by_id (bookmark.id);
			GblPilot::Document_var pilot_document = GblPilot::Document::_narrow (object);
			m_short_doc_name = 
				GCI::IO::StringFactory::make (CORBA::String_var (pilot_document->get_short_name ()).in ());
		} catch (...) {
			m_short_doc_name = m_caption;
		}
	}
	return *m_short_doc_name;
	//#UC END# *45EEC17501BC_457050AC03A9_GET*
}

GCI::IO::String& FoldersNode_i::get_short_name () {
	return const_cast<GCI::IO::String&>(((const FoldersNode_i*)this)->get_short_name ());
}

// implemented method from Controllable
ControlledItemType FoldersNode_i::get_type () const {
	//#UC START# *45FA9A9C00F5_457050AC03A9_GET*
	if ((this->get_object_type () == FIT_BOOKMARK) 
		|| (this->get_object_type () == FIT_PHARM_BOOKMARK)
	) {
		return CIT_DOCUMENT;
	} else {
		throw Unsupported ();
	}
	//#UC END# *45FA9A9C00F5_457050AC03A9_GET*
}

// implemented method from EntityStorage
// получить содежимое
Containers::Content* FoldersNode_i::get_cached_content () const {
	//#UC START# *4616371B010F_457050AC03A9*
	return m_content.in ();
	//#UC END# *4616371B010F_457050AC03A9*
}

// implemented method from EntityStorage
// получить тип содержимого
Containers::ContentType FoldersNode_i::get_content_type () const {
	//#UC START# *461636870045_457050AC03A9*
		return m_content_type;
	//#UC END# *461636870045_457050AC03A9*
}

// implemented method from FoldersNode
// указывает можно ли в ноду загрузить данные из xml.
bool FoldersNode_i::can_load_from_xml () const {
	//#UC START# *469757F10138_457050AC03A9*
	// папка
	if (this->get_object_type () != FIT_FOLDER) {
		return false;
	}

	// пустая
	if (this->has_child ()) {
		return false;
	}

	// лежит в "Моих документах"
	if (!this->is_my_documents_or_lower ()) {
		return false;
	}

	// не расшарена и не внутри расшаренной
	if ((m_flags & NF_SHARED) || (m_flags & NF_IN_SHARED)) {
		return false;
	}

	return true;
	//#UC END# *469757F10138_457050AC03A9*
}

// implemented method from FoldersNode
// Указывает может ли консультация быть сохранена в xml.
bool FoldersNode_i::can_save_consultation_to_xml () const {
	//#UC START# *45EED5F00094_457050AC03A9*
	if (
		(m_content_type == Defines::CT_CONSULTATION)
		 && (
			(m_flags & NF_ANSWER_RECEIVED)
			|| (m_flags & NF_ANSWER_READ)
			|| (m_flags & NF_ESTIMATION_SENT)
		   )
	   ) {
		return true;
	}

	return false;
	//#UC END# *45EED5F00094_457050AC03A9*
}

// implemented method from FoldersNode
// может ли нода быть сохранена для библиотеки интеграции
bool FoldersNode_i::can_save_to_integration_xml () const {
	//#UC START# *46433578001F_457050AC03A9*
	// http://mdp.garant.ru/x/Mp44Bw
	if (this->is_bookmark () || m_content_type == Defines::CT_SAVED_LIST || m_content_type == Defines::CT_SAVED_QUERY) { 
		return true;
	}
	return false;
	//#UC END# *46433578001F_457050AC03A9*
}

// implemented method from FoldersNode
// указывает может ли нода быть сохранена в xml.
bool FoldersNode_i::can_save_to_xml () const {
	//#UC START# *469755970138_457050AC03A9*
	return this->get_object_type () == FIT_FOLDER	// папка
			&& this->has_child ()					// не пустая
			&& this->is_my_documents_or_lower ();	// в Моих документах
	//#UC END# *469755970138_457050AC03A9*
}

// implemented method from FoldersNode
// Дата создания
const Date FoldersNode_i::get_creation_date () const {
	//#UC START# *45EED69600CD_457050AC03A9_GET*
	return m_creation_date;
	//#UC END# *45EED69600CD_457050AC03A9_GET*
}

// implemented method from FoldersNode
GCD::PID FoldersNode_i::get_pid () const {
	//#UC START# *474D68CA00C1_457050AC03A9*
	GCD::PID pid;

	pid.m_object_id = m_id;
	switch (m_type) {
		case FIT_BOOKMARK:
		case FIT_PHARM_BOOKMARK:
			pid = const_cast <FoldersNode_i*> (this)->get_document_pid ();
			break;
		case FIT_LIST:
		case FIT_PHARM_LIST:
			pid.m_class_id = Defines::CI_LIST;
			break;
		case FIT_QUERY:
			pid.m_class_id = Defines::CI_QUERY;
			break;
		default:
			pid.m_class_id = 0;
			break;
	}
	return pid;
	//#UC END# *474D68CA00C1_457050AC03A9*
}

// implemented method from FoldersNode
// Сонтент айди
const FolderId FoldersNode_i::get_id () const {
	//#UC START# *45EED66E00DD_457050AC03A9_GET*
	return m_id;
	//#UC END# *45EED66E00DD_457050AC03A9_GET*
}

// implemented method from FoldersNode
// загружает информацию из xml в папку (пустую, нерасшаренную).
void FoldersNode_i::load_from_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/ {
	//#UC START# *469755D1008C_457050AC03A9*
	if (!this->can_load_from_xml ()) {
		throw InvalidEntityType ();
	}

	try {
		GCD::XMLText_var xml_text = GCL::XMLParser::create_buffer_from_xml_file (xml_file_path);
		m_content->load_from_xml (*xml_text.ptr ());
		Common_var common (CommonFactory::make ());
		Common_i* common_servant = dynamic_cast<Common_i*> (common.ptr ());
		GDS_ASSERT (common_servant);
		FolderNotifier_i* notifier = common_servant->get_cached_folder_notifier ();
		if (!notifier) {
			return;
		}
		notifier->send_notify (NS_NODE, m_content->id ());
	} catch (GCL::FileAccessError&) {
		throw AccessDenied ();
	} catch (CORBA::Exception&) {
		LOG_E (("%s: can't load xml from file %s (corba exception)", GDS_CURRENT_FUNCTION, xml_file_path));
		throw InvalidEntityType ();
	} catch (...) {
		LOG_E (("%s: can't load xml from file %s", GDS_CURRENT_FUNCTION, xml_file_path));
		throw InvalidEntityType ();
	} 
	//#UC END# *469755D1008C_457050AC03A9*
}

// implemented method from FoldersNode
// Сохраняет информацию о сущности, представляемой папочной нодой консультации в xml.
void FoldersNode_i::save_consultation_to_xml (const char* xml_file_path) const {
	//#UC START# *45EED5F00092_457050AC03A9*
	if (!this->can_save_consultation_to_xml ()) {
		throw InvalidEntityType ();
	} else {
		GblFolders::SavedConsultation_var saved_consultation = 
			GblFolders::SavedConsultation::_narrow (m_content);
		GCD::XMLText* result = 0;
		try {
			GblConsultingClient::Consultation_var server_consultation (saved_consultation->get_consultation ());
			ServerConsultationLCRemover remover (server_consultation.in ());
			GCD::XMLText* result = server_consultation->save_to_xml ();
		} catch (CORBA::OBJECT_NOT_EXIST&) {
			throw InvalidEntityType ();
		}
		GDS_ASSERT (result);

		try {
			GCL::XMLParser::save_xml_buffer_to_file (result, xml_file_path);
		} catch (GCL::FileAccessError&) {
			throw AccessDenied ();
		}
	}
	//#UC END# *45EED5F00092_457050AC03A9*
}

// implemented method from FoldersNode
// сохранить ноду для библиотеки интеграции
GCI::IO::String* FoldersNode_i::save_to_integration_xml () const /*throw (InvalidEntityType)*/ {
	//#UC START# *4643355B029F_457050AC03A9*
	if (!this->can_save_to_integration_xml ()) {
		throw InvalidEntityType ();
	}

	try {
		GCD::XMLText* result = m_content->save_to_integration_xml ();
		std::string tmp (reinterpret_cast<const char*> (result->get_buffer ()), result->length ());
		return GCI::IO::StringFactory::create (tmp.c_str (), -1);
	} catch (Containers::ContentNotFound&) {
		throw InvalidEntityType ();
	} catch (CORBA::Exception&) {
		throw InvalidEntityType ();
	}
	//#UC END# *4643355B029F_457050AC03A9*
}

// implemented method from FoldersNode
void FoldersNode_i::save_to_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/ {
	//#UC START# *46974935032C_457050AC03A9*
	if (!this->can_save_to_xml ()) {
		throw InvalidEntityType ();
	}
	try {
		GCD::XMLText* result = m_content->save_to_xml ();
		GCL::XMLParser::save_xml_buffer_to_file (result, xml_file_path);
	} catch (Containers::OperationNotAllowed&) {
		throw InvalidEntityType ();
	}
	//#UC END# *46974935032C_457050AC03A9*
}

// implemented method from Node
// Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если
// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify.
// Если нода не может содержать детей возвращается исключение InvalidContainer
Node* FoldersNode_i::add_child_node (
	const Core::IObject* entity
) const /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, DuplicateNode
	, InvalidEntityType
)*/ {
	//#UC START# *456FE63B01DE_457050AC03A9*
	Containers::Content_var content;
	GblFolders::Folder_var pilot_folder;

	if (m_content_type != Defines::CT_FOLDER ) {
		throw InvalidEntityType ();
	}
	
	Folder_cvar folder = Core::IObject::_duplicate (dynamic_cast <const Folder*> (entity));
	// Папка
	if (!folder.is_nil ()) {
		Folder_i* folder_i = dynamic_cast <Folder_i*> (const_cast <Folder*> (folder.ptr ()));

		// Получаем Content папки
		content = folder_i->get_content_folder ();

		// Добавляем на сервере папку
		pilot_folder = GblFolders::Folder::_narrow (m_content);
		try {
			pilot_folder->add_content (content);
		} catch (Containers::DuplicateName&) {
			folder_i->clear_content_folder ();
			throw DuplicateNode ();
		} catch (GCD::AccessDenied&) {
			folder_i->clear_content_folder ();
			throw AccessDenied ();
		} catch (...) {
			folder_i->clear_content_folder ();
			throw CanNotFindData ();
		}

	}

	Bookmark_cvar bookmark = Core::IObject::_duplicate (dynamic_cast <const Bookmark*> (entity));
	// Документ
	if (!bookmark.is_nil ()) {
		Bookmark_i* bookmark_i = dynamic_cast <Bookmark_i*> (const_cast <Bookmark*> (bookmark.ptr ()));
		content = bookmark_i->get_doc_bookmark ();

		// Добавляем на сервере папку
		pilot_folder = GblFolders::Folder::_narrow (m_content);
		try {
			pilot_folder->add_content (content);
		} catch (Containers::DuplicateName&) {
			bookmark_i->clear_doc_bookmark ();
			throw DuplicateNode ();
		} catch (GCD::AccessDenied&) {
			bookmark_i->clear_doc_bookmark ();
			throw AccessDenied ();
		} catch (...) {
			bookmark_i->clear_doc_bookmark ();
			throw CanNotFindData ();
		}
		ControlManagerFactory::make ().refresh_control_status ();
	}

	DynList_cvar dyn_list = Core::IObject::_duplicate (dynamic_cast <const DynList*> (entity));
	if (!dyn_list.is_nil ()) {
		DynList_i* dyn_list_i = dynamic_cast<DynList_i*>(const_cast <DynList*> (dyn_list.ptr ()));
		// Добавляем на сервере список
		pilot_folder = GblFolders::Folder::_narrow (m_content);
		// Получаем Content папки
		content = dyn_list_i->save_to_folder (pilot_folder);
	}


	FoldersQuery_var query = 
		Core::IObject::_duplicate (
			const_cast<FoldersQuery*> (
				dynamic_cast <const FoldersQuery*> (entity)
			)
		);
	// Запрос
	if (!query.is_nil ()) {
		// Получаем Content запроса
		content = query->get_saved_query ();

		// Добавляем на сервере список
		pilot_folder = GblFolders::Folder::_narrow (m_content);
		try {
			pilot_folder->add_content (content);
		} catch (Containers::DuplicateName&) {
			query->reset_saved_query ();  // заточка для CQ: 18209
			throw DuplicateNode ();
		} catch (GCD::AccessDenied&) {
			throw AccessDenied ();
		} catch (...) {
			throw CanNotFindData ();
		}
	}
	
	GDS_ASSERT (!CORBA::is_nil (content));
	
	// Создаем FoldersNode
	FoldersNode_var out_node = FoldersNodeFactory::make (content.in (), m_folders_manager);
	FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (out_node.in ());
	const_cast <FoldersNode_i*> (this)->insert_back_child (folders_node_i);
	FoldersNode::_duplicate (folders_node_i);		//???

	m_folders_manager->recalc_shared_flags ();
	m_folders_manager->recalc_node_flags ();
	return out_node._retn ();
	//#UC END# *456FE63B01DE_457050AC03A9*
}

// implemented method from Node
// Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если
// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify
Node* FoldersNode_i::add_sibling_node (
	const Core::IObject* entity
) const /*throw (
	ConstantModify
	, Unsupported
	, DuplicateNode
)*/ {
	//#UC START# *456FE63B01E0_457050AC03A9*
	Node_cvar parent = this->get_parent ();
	Node_var node;
	if (!parent.is_nil ()) {
		node = const_cast <Node*> (parent.in ())->add_sibling_node (entity);
	}

	m_folders_manager->recalc_shared_flags ();
	m_folders_manager->recalc_node_flags ();
	return node._sretn ();
	//#UC END# *456FE63B01E0_457050AC03A9*
}

// implemented method from Node
// название
const GCI::IO::String& FoldersNode_i::get_caption () const {
	//#UC START# *457025090261_457050AC03A9_GET*
	return *m_caption;
	//#UC END# *457025090261_457050AC03A9_GET*
}

GCI::IO::String& FoldersNode_i::get_caption () {
	return const_cast<GCI::IO::String&>(((const FoldersNode_i*)this)->get_caption ());
}

void FoldersNode_i::set_caption (GCI::IO::String* caption)
	/*throw (ConstantModify, AccessDenied)*/
{
	//#UC START# *457025090261_457050AC03A9_SET*
	try {
		m_folder_element->set_name (caption->get_data ());
	} catch (Containers::DuplicateName&) {
		throw DuplicateNode ();
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (...) {
		throw CanNotFindData ();
	}
	 m_caption = GCI::IO::String::_duplicate (caption);
	//#UC END# *457025090261_457050AC03A9_SET*
}

// implemented method from Node
// Поле для передачи дополнительной винарной информации о статусе элемента.
long FoldersNode_i::get_flags () const {
	//#UC START# *456FE63B01F4_457050AC03A9_GET*
	bool test = ControlManagerFactory::make ().get_under_control_status (this->get_pid (), m_under_control_status);
	if (test) {
		m_flags |= NF_CONTROLLED;
	} else {
		m_flags -= (m_flags & NF_CONTROLLED);
	}
	return m_flags;
	//#UC END# *456FE63B01F4_457050AC03A9_GET*
}

// implemented method from Node
// информация о ноде
const GCI::IO::String& FoldersNode_i::get_hint () const {
	//#UC START# *4570251D0119_457050AC03A9_GET*
	return *m_hint;
	//#UC END# *4570251D0119_457050AC03A9_GET*
}

GCI::IO::String& FoldersNode_i::get_hint () {
	return const_cast<GCI::IO::String&>(((const FoldersNode_i*)this)->get_hint ());
}

void FoldersNode_i::set_hint (GCI::IO::String* hint)
	/*throw (ConstantModify, AccessDenied)*/
{
	//#UC START# *4570251D0119_457050AC03A9_SET*
	try {
		m_folder_element->set_comment (hint->get_data ());
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (...) {
		throw CanNotFindData ();
	}
	 m_hint = GCI::IO::String::_duplicate (hint);
	//#UC END# *4570251D0119_457050AC03A9_SET*
}

// implemented method from Node
// Возвращает интерфейс для работы с конкретным элементом (сущностью) системы.
Core::IObject* FoldersNode_i::open () /*throw (CanNotFindData, NotEntityElement)*/ {
	//#UC START# *456FE63B01DB_457050AC03A9*
	FoldersNode* folders_node = dynamic_cast <FoldersNode*> (this);
	// Надо понять что здесь лежит : документ, запрос, список или папка
	switch (m_content_type) {
		case Defines::CT_FOLDER:
			{
				GblFolders::Folder_var folder_content;
				Folder_var folder;
				folder_content = GblFolders::Folder::_narrow (m_content);
				folder = FolderFactory::make (folder_content, folders_node);
				return folder._sretn ();
			}
		case Defines::CT_DOC_BOOKMARK:
		case Defines::CT_PHARM_BOOKMARK:
			{
				GblFolders::DocBookmark_var doc_bookmark = GblFolders::DocBookmark::_narrow (m_content);
				Bookmark_var bookmark;
				try {
					bookmark = BookmarkFactory::make (
									doc_bookmark->get_bookmark ()
									, doc_bookmark
									, folders_node
								);

				} catch (CORBA::OBJ_ADAPTER&) {
					throw CanNotFindData ();
				} catch (GCD::CanNotFindData&) {
					throw CanNotFindData ();
				}
				return bookmark._sretn ();
			}
		case Defines::CT_SAVED_LIST:
		case Defines::CT_SAVED_PHARM_LIST:
			{
				GblFolders::SavedList_var saved_list = GblFolders::SavedList::_narrow (m_content);
				GTree::Tree_var tree_list;
				try {
					tree_list = saved_list->get ();
				} catch (...) {
					throw CanNotFindData ();
				}
				GblDocList::DocListTree_var doc_list_tree = 
						GblDocList::DocListTree::_narrow (tree_list.in ());
				
				DynList_var dyn_list = DynListFactory::make (doc_list_tree.in ());
				dyn_list->set_list_storage (saved_list.in ());
				return dyn_list._retn ();
			}

		case Defines::CT_SAVED_QUERY:
			{
				//
				// Если в папках уже удалили этот элемент
				//  то получаем его из кэша
				if (!CORBA::is_nil (m_content)) {
					GblFolders::SavedQuery_var saved_query = GblFolders::SavedQuery::_narrow (m_content);
					QueryCreator_var creator (QueryCreatorFactory::make ());
					Query_var query (creator->make_query (saved_query, false, folders_node));
					m_iquery = query;
				}
				return m_iquery._sretn ();
			}
		case Defines::CT_CONSULTATION: 
			{
				// Консультация
				GblFolders::SavedConsultation_var saved_consultation = 
					GblFolders::SavedConsultation::_narrow (m_content);
				GblConsultingClient::Consultation_var server_consultation;
				try {
					server_consultation = saved_consultation->get_consultation ();
				} catch (CORBA::OBJECT_NOT_EXIST&) {
					throw CanNotFindData ();
				}
				assert (!CORBA::is_nil (server_consultation.in ()));
				Consultation_var consultation (ConsultationFactory::make (server_consultation.in (), folders_node));
				return consultation._retn ();
			}
		default:
			GDS_ASSERT (false);
	} 
	return 0;
	//#UC END# *456FE63B01DB_457050AC03A9*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Node
// можно ли скопировать ноду
bool FoldersNode_i::can_copy () const {
	//#UC START# *456FE63B01E7_457050AC03A9*
	return false;
	//#UC END# *456FE63B01E7_457050AC03A9*
}

// overloaded method from Node
// можно ли вставить ноду
bool FoldersNode_i::can_insert (Node* source) const {
	//#UC START# *456FE63B01E8_457050AC03A9*
	try {
		FoldersNode_i* fn = dynamic_cast<FoldersNode_i*>(source);
		if (!fn) {
			return false;
		}
		if (fn == this) {
			return false;
		}

		long flags = this->get_flags ();
		long fn_flags = fn->get_flags ();

		// Нельзя мувить шареную папку в шареную папку
		if (((flags & NF_SHARED) || (flags & NF_IN_SHARED)) 
			&& ((fn_flags & NF_SHARED) || (fn_flags & NF_HAS_SHARED))) {
			return false;
		}

		if (this->get_object_type () != FIT_FOLDER) { // not a folder
			return false;
		} else {
			if (this->parent_level(fn)) { // recurcive insert
				return false;
			}

			Node_cvar parent_node = source->get_parent ();
			const FoldersNode_i* folders_parent_node = dynamic_cast<const FoldersNode_i*>(parent_node.in ());
			if (!folders_parent_node || (folders_parent_node && this->get_id () == folders_parent_node->get_id ())) {
				return false;
			}


			GCL::StaticNode_var tmp_node = const_cast <FoldersNode_i*> (this)->last_child (); //last_child call _duplicate
			if (fn == tmp_node.ptr ()) { // null insert
				return false;
			}
			return this->can_modify ();
		}	
	} catch (...) {
		return false;
	}
	
	//#UC END# *456FE63B01E8_457050AC03A9*
}

// overloaded method from Node
// можно ли модифицировать ноду
bool FoldersNode_i::can_modify () const {
	//#UC START# *4AA55863036D_457050AC03A9*
	return this->is_my_documents_or_lower ();
	//#UC END# *4AA55863036D_457050AC03A9*
}

// overloaded method from Node
// можно ли переместить ноду
bool FoldersNode_i::can_move () const {
	//#UC START# *456FE63B01E6_457050AC03A9*
	return this->can_modify ();
	//#UC END# *456FE63B01E6_457050AC03A9*
}

// overloaded method from Node
// Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком.
// Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение
// InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение
// CopyDisabled
void FoldersNode_i::copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/ {
	//#UC START# *456FE63B01E4_457050AC03A9*
	// На сервере не поддерживается
	//#UC END# *456FE63B01E4_457050AC03A9*
}

// overloaded method from Node
// Удаляет указанные узел из списка/дерева.
// Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево
// созданно как константное (неизменяемое) то генерится исключение ConstantModify
void FoldersNode_i::delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/ {
	//#UC START# *456FE63B01DD_457050AC03A9*
	Node_cvar parent = this->get_parent ();
	const FoldersNode_i* parent_folder = dynamic_cast <const FoldersNode_i*> (parent.in ());

	if (parent_folder) {
		if (parent_folder->m_content_type == Defines::CT_FOLDER) {
			GblFolders::Folder_var folder;
			Containers::ContainerManager_var container_manager;
			folder = const_cast <FoldersNode_i*> (parent_folder)->get_folder ();

			try {
				folder->remove_content (m_content->id ());
			} catch (GCD::AccessDenied&) {
				throw AccessDenied ();
			} catch (CORBA::OBJECT_NOT_EXIST&) {
				throw EmptyResult ();
			}

			container_manager = folder->manager ();
			container_manager->delete_content (m_content->id ());

			StaticNode_i::delete_node ();

			//
			// Зануляем вручную содержимое
			//
			m_content = 0;
			
			if (m_type == FIT_BOOKMARK || m_type == FIT_PHARM_BOOKMARK || m_type == FIT_FOLDER) {
				ControlManagerFactory::make ().refresh_control_status ();
			}
		}
	}
	m_folders_manager->recalc_shared_flags ();
	m_folders_manager->recalc_node_flags ();
	//#UC END# *456FE63B01DD_457050AC03A9*
}

// overloaded method from Node
// Сравнивает текущий элемент с элементом, поданным в параметре node.
// Возвращает true в случае совпадения.
bool FoldersNode_i::is_same_node (const Node* node) const {
	//#UC START# *456FE63B01D9_457050AC03A9*
	bool retv;
	const FoldersNode_i* folders_node = dynamic_cast <const FoldersNode_i*> (node);
	retv = false;

	if (this == folders_node) {
		retv = true;
	} else {
		if (folders_node) {
			if (this->m_id == folders_node->m_id) {
				retv = true;
			}
		}
	}
	return retv;
	//#UC END# *456FE63B01D9_457050AC03A9*
}

// overloaded method from Node
// Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду
// (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция
// перемещения узлов не доступна, генерируется исключение MoveDisabled
void FoldersNode_i::move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/ {
	//#UC START# *456FE63B01E2_457050AC03A9*
	FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (destination);
	if (folders_node_i != 0) {
		try {
			m_folder_element->move (folders_node_i->get_id ());
		} catch (Containers::DuplicateName&) {
			throw DuplicateNode ();
		}
		StaticNode_i::move_to_location (destination);
		this->recalc_external_flag ();

		m_folders_manager->recalc_shared_flags ();
		m_folders_manager->recalc_node_flags ();
	} else {
		throw InvalidContainer();
	}
	//#UC END# *456FE63B01E2_457050AC03A9*
}

// overloaded method from Node
// тип сущности, представляемой нодой
EntityType FoldersNode_i::get_object_type () const
	/*throw (Unsupported)*/
{
	//#UC START# *457025CB033C_457050AC03A9_GET*
	return m_type;
	//#UC END# *457025CB033C_457050AC03A9_GET*
}

// overloaded method from Node
// перезаписать дочернюю ноду
Node* FoldersNode_i::override_child_node (
	const Core::IObject* entity
) const /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, DuplicateNode
	, InvalidEntityType
)*/ {
	//#UC START# *456FE63B01ED_457050AC03A9*
	Containers::Content_var content;
	GblFolders::Folder_var pilot_folder;
	Containers::Content_var new_content;

	if (m_content_type != Defines::CT_FOLDER ) {
		throw InvalidEntityType ();
	}

	Folder_cvar folder = Core::IObject::_duplicate (dynamic_cast <const Folder*> (entity));
	// Папка
	if (!folder.is_nil ()) {
		const Folder_i* folder_i = dynamic_cast <const Folder_i*> (folder.ptr ());
		folder_i->clear_content_folder ();
		throw DuplicateNode ();
	}
	FoldersNode_var out_node;
	Bookmark_cvar bookmark = Core::IObject::_duplicate (dynamic_cast <const Bookmark*> (entity));
	// Документ
	if (!bookmark.is_nil ()) {
		Bookmark_i* bookmark_i = dynamic_cast <Bookmark_i*> (const_cast <Bookmark*> (bookmark.in ()));
		content = bookmark_i->get_doc_bookmark ();

		// Добавляем на сервере контент
		pilot_folder = GblFolders::Folder::_narrow (m_content);
		try {
			new_content = pilot_folder->add_content_ex (content, Containers::ACM_OVERWRITE);
		} catch (Containers::DuplicateName&) {
			bookmark_i->clear_doc_bookmark ();
			throw DuplicateNode ();
		} catch (GCD::AccessDenied&) {
			bookmark_i->clear_doc_bookmark ();
			throw AccessDenied ();
		} catch (...) {
			bookmark_i->clear_doc_bookmark ();
			throw CanNotFindData ();
		}
		out_node = FoldersNodeFactory::make (new_content.in (), m_folders_manager);
		FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (out_node.in ());

		if (content->_is_equivalent (new_content)) {
			const_cast <FoldersNode_i*> (this)->insert_back_child (folders_node_i);
			FoldersNode::_duplicate (folders_node_i);		//?????
		}
		ControlManagerFactory::make ().refresh_control_status ();
	} 
	FoldersQuery_var query = 
		Core::IObject::_duplicate (
			const_cast<FoldersQuery*> (
				dynamic_cast <const FoldersQuery*> (entity)
			)
		);
	// Запрос
	if (!query.is_nil ()) {
		// Получаем Content запроса
		content = query->get_saved_query ();

		// Добавляем на сервере список
		pilot_folder = GblFolders::Folder::_narrow (m_content);
		try {
			new_content = pilot_folder->add_content_ex (content, Containers::ACM_OVERWRITE);
		} catch (Containers::DuplicateName&) {
			throw DuplicateNode ();
		} catch (GCD::AccessDenied&) {
			throw AccessDenied ();
		} catch (...) {
			throw CanNotFindData ();
		}

		out_node = FoldersNodeFactory::make (new_content.in (), m_folders_manager);
		FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (out_node.in ());
		if (content->_is_equivalent (new_content)) {
			const_cast <FoldersNode_i*> (this)->insert_back_child (folders_node_i);
			FoldersNode::_duplicate (folders_node_i); //????
		}
	}
	if (new_content->_is_equivalent (content)) {
		m_folders_manager->recalc_shared_flags ();
		m_folders_manager->recalc_node_flags ();
	}
	return out_node._retn ();
	//#UC END# *456FE63B01ED_457050AC03A9*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

