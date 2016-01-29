////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Bookmark_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/FoldersHelper/ContentChecker.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Bookmark_i::Bookmark_i (
	const GblPilotDef::Bookmark& bookmark
	, GblFolders::DocBookmark* doc_bookmark
	, FoldersNode* folders_node
)
//#UC START# *45EEB65202A0_4610F983004B_4610F6320146_BASE_INIT*
	: m_pilot_bookmark (bookmark)
	, m_para_id (bookmark.para)
	, m_doc_bookmark (GblFolders::DocBookmark::_duplicate (doc_bookmark))
	, m_folders_node (FoldersNode::_duplicate (folders_node))
//#UC END# *45EEB65202A0_4610F983004B_4610F6320146_BASE_INIT*
{
	//#UC START# *45EEB65202A0_4610F983004B_4610F6320146_BODY*
	m_pid.class_id = bookmark.id.m_class_id;
	m_pid.object_id = bookmark.id.m_object_id;
	//#UC END# *45EEB65202A0_4610F983004B_4610F6320146_BODY*
}

Bookmark_i::~Bookmark_i () {
	//#UC START# *4610F6320146_DESTR_BODY*
	//#UC END# *4610F6320146_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Bookmark_i::clear_doc_bookmark () {
	//#UC START# *46110AFF02CF*
	m_doc_bookmark = GblFolders::DocBookmark::_nil ();
	//#UC END# *46110AFF02CF*
}

GblFolders::DocBookmark* Bookmark_i::get_doc_bookmark () {
	//#UC START# *46110AC701B6*
	if (CORBA::is_nil (m_doc_bookmark.in ())) {
		GblFolders::Folders* folders (ApplicationHelper::instance ()->get_cached_folders ());
		// Тип закладки определяет почему-то адаптер
		GblPilotDef::DocumentType document_type = 
			ApplicationHelper::instance ()->get_cached_document_type_resolver ()->get_type (m_pilot_bookmark.id);
		Containers::ContentType content_type = 
			(document_type == GblPilotDef::DT_PHARM || document_type == GblPilotDef::DT_PHARM_DICTIONARY) 
			? Defines::CT_PHARM_BOOKMARK : Defines::CT_DOC_BOOKMARK;
		Containers::Content_var content (folders->create_content (content_type));

		m_doc_bookmark = GblFolders::DocBookmark::_narrow (content);
		m_doc_bookmark->set_bookmark (m_pilot_bookmark);

		m_doc_bookmark->set_name (m_name->get_data ());
		m_doc_bookmark->set_comment (m_comment->get_data ());
	}

	return GblFolders::DocBookmark::_duplicate (m_doc_bookmark.in ());
	//#UC END# *46110AC701B6*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Bookmark
// полное имя документа и блока/саба на который указывает закладка. Используется в качестве hint  в
// Папках.
const GCI::IO::String& Bookmark_i::get_comment () const {
	//#UC START# *45EEB65202A3_4610F6320146_GET*
	if (m_comment.is_nil () && !CORBA::is_nil (m_doc_bookmark.in ())) {
		m_comment = GCI::IO::StringFactory::make (CORBA::String_var (m_doc_bookmark->get_comment ()).in ());
	}
	return *m_comment.ptr ();
	//#UC END# *45EEB65202A3_4610F6320146_GET*
}

GCI::IO::String& Bookmark_i::get_comment () {
	return const_cast<GCI::IO::String&>(((const Bookmark_i*)this)->get_comment ());
}

void Bookmark_i::set_comment (GCI::IO::String* comment) {
	//#UC START# *45EEB65202A3_4610F6320146_SET*
	if (!CORBA::is_nil (m_doc_bookmark.in ())) {
		m_doc_bookmark->set_comment (comment->get_data ());
	}
	m_comment = Core::IObject::_duplicate (comment);
	//#UC END# *45EEB65202A3_4610F6320146_SET*
}

// implemented method from Bookmark
const Document* Bookmark_i::get_document () const {
	//#UC START# *460B8EF302A4_4610F6320146_GET*
	try {
		//GblPilot::Document_var pilot_document = GblPilot::Document::_narrow (m_pilot_bookmark.m_persistent.in ());
		GCD::PID pid;
		pid.m_class_id = m_pid.class_id;
		pid.m_object_id = m_pid.object_id;
		return DocumentFactory::make (pid, true /*may be it is redaction*/, 0, DocumentFactoryKeyHelper::PID_to_key (pid));
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *460B8EF302A4_4610F6320146_GET*
}

Document* Bookmark_i::get_document () {
	return const_cast<Document*>(((const Bookmark_i*)this)->get_document ());
}

// implemented method from Bookmark
// Названите закладки. Используется в качестве caption в Папках.
const GCI::IO::String& Bookmark_i::get_name () const {
	//#UC START# *45EEB65202A2_4610F6320146_GET*
	if (this->get_is_saved ()) {
		m_saved_name = GCI::IO::StringFactory::make (CORBA::String_var (m_doc_bookmark->get_name ()).in ());
		return *m_saved_name.ptr ();
	} else {
		return *m_name.ptr ();
	}
	//#UC END# *45EEB65202A2_4610F6320146_GET*
}

GCI::IO::String& Bookmark_i::get_name () {
	return const_cast<GCI::IO::String&>(((const Bookmark_i*)this)->get_name ());
}

void Bookmark_i::set_name (GCI::IO::String* name) {
	//#UC START# *45EEB65202A2_4610F6320146_SET*
	if (this->get_is_saved ()) {
		if (!m_folders_node.is_nil ()) {
			m_folders_node->set_caption (name);
		}
	} else {
		m_name = Core::IObject::_duplicate (name);
	}
	//#UC END# *45EEB65202A2_4610F6320146_SET*
}

// implemented method from Bookmark
ParaId Bookmark_i::get_paragraph () const {
	//#UC START# *460B8DAF01AE_4610F6320146_GET*
	return m_para_id;
	//#UC END# *460B8DAF01AE_4610F6320146_GET*
}

// implemented method from Bookmark
const PId& Bookmark_i::get_pid () const {
	//#UC START# *460B8E3401FB_4610F6320146_GET*
	return m_pid;
	//#UC END# *460B8E3401FB_4610F6320146_GET*
}

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* Bookmark_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_4610F6320146*
	GCD::PID pid;
	pid.m_class_id = m_pid.class_id;
	pid.m_object_id = m_pid.object_id;
	GblPilotDef::DocumentType document_type = 
		ApplicationHelper::instance ()->get_cached_document_type_resolver ()->get_type (m_pilot_bookmark.id);

	// Адаптер знает и умеет все...
	if (document_type == GblPilotDef::DT_PHARM && (storage->get_content_type () != Defines::CT_SAVED_PHARM_LIST)) {
		throw Unsupported ();
	}
	if (storage->get_content_type () != Defines::CT_SAVED_LIST) {
		throw Unsupported ();
	}		
	Containers::Content_ptr content = storage->get_cached_content ();
	GblFolders::SavedList_var saved_list = GblFolders::SavedList::_narrow (content);
	saved_list->add_bookmark (m_pilot_bookmark);
	return 0;
	//#UC END# *456EB3E1017A_4610F6320146*
}

// implemented method from EntityBase
// идентификатор
const unsigned long Bookmark_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_4610F6320146_GET*
	if (!CORBA::is_nil (m_doc_bookmark.in ())) {
		return m_doc_bookmark->id ();
	} else {
		throw NotSaved ();
	}
	//#UC END# *456EE084033C_4610F6320146_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool Bookmark_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_4610F6320146_GET*
	return false;
	//#UC END# *456EB3E1017D_4610F6320146_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool Bookmark_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_4610F6320146_GET*
	return ContentChecker::check_content (m_doc_bookmark.in ());
	//#UC END# *456EB3E1017C_4610F6320146_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* Bookmark_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_4610F6320146*
	if (!storage) {
		if (!ContentChecker::check_server_content (m_doc_bookmark.in ())) {
			throw NotSaved ();
		}
		if (!CORBA::is_nil (m_doc_bookmark.in ())) {
			m_doc_bookmark->set_name (m_name->get_data ());
			m_doc_bookmark->set_comment (m_comment->get_data ());
		} else {
			GDS_ASSERT (false);
		}
	} else if (Defines::CT_FOLDER == storage->get_content_type ()) {
		FoldersNode* fn = dynamic_cast <FoldersNode*> (storage);
		if (!fn) {
			throw CanNotSave ();
		}
		if (this->get_is_saved ()) {
			m_doc_bookmark = 0;
		}
		return fn->add_child_node (this);
	} else if (
		(Defines::CT_DOC_BOOKMARK == storage->get_content_type ())
		|| (Defines::CT_PHARM_BOOKMARK == storage->get_content_type ())
	) {
		FoldersNode* fn = dynamic_cast <FoldersNode*> (storage);
		if (!fn) {
			throw CanNotSave ();
		}
		m_doc_bookmark = GblFolders::DocBookmark::_narrow (storage->get_cached_content ());
		GDS_ASSERT (!CORBA::is_nil (m_doc_bookmark.in ()));
		m_doc_bookmark->set_bookmark (m_pilot_bookmark);
	} else {
		GDS_ASSERT (false);
		throw CanNotSave ();
	}
	return 0;
	//#UC END# *456EB3E10178_4610F6320146*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

