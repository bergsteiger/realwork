////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::AutoreferatDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument.h"
// by <<uses>> dependencies
#include "garantServer/src/Global/Defines/DefinesC.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AutoreferatDocument::AutoreferatDocument (GblPilot::Document* document)
//#UC START# *475D60C2036D_BASE_INIT*
	: Document_i(document)
	, DocumentMaster (document)
	, SimpleDocument (document)
//#UC END# *475D60C2036D_BASE_INIT*
{
	//#UC START# *475D60C2036D_BODY*
	m_pid.m_class_id = Defines::CI_TOPIC;
	m_pid.m_object_id = 0;
	//#UC END# *475D60C2036D_BODY*
}

AutoreferatDocument::~AutoreferatDocument () {
	//#UC START# *4610D3060057_DESTR_BODY*
	//#UC END# *4610D3060057_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from BaseUpdateChecker_i
void AutoreferatDocument::clear_cache () {
	//#UC START# *45702DA9037A_4610D3060057*
	DocumentTextProviderList empty_document_text_provider_list;
	std::swap (m_list, empty_document_text_provider_list);
	DocumentTextProviderDescriptorList empty_document_text_provider_descriptor_list;
	std::swap (m_desc_list, empty_document_text_provider_descriptor_list);
	//#UC END# *45702DA9037A_4610D3060057*
}

// overloaded method from DocWithPid
const GCD::PID& AutoreferatDocument::get_document_pid () const {
	//#UC START# *460A63BD025C_4610D3060057*
	return m_pid;
	//#UC END# *460A63BD025C_4610D3060057*
}

// overloaded method from Document
const BookmarkList& AutoreferatDocument::get_bookmark_list () const {
	//#UC START# *4D147C7602A6_4610D3060057_GET*
	return m_bookmark_list; 
	//#UC END# *4D147C7602A6_4610D3060057_GET*
}

// overloaded method from Document
const CommentsParaList& AutoreferatDocument::get_comments_para_list () const {
	//#UC START# *4D147CCA0051_4610D3060057_GET*
	return m_comments_para_list;
	//#UC END# *4D147CCA0051_4610D3060057_GET*
}

// overloaded method from Document
const NodeBase* AutoreferatDocument::get_contents_root () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *4C77A3370186_4610D3060057_GET*
	throw CanNotFindData ();
	//#UC END# *4C77A3370186_4610D3060057_GET*
}

NodeBase* AutoreferatDocument::get_contents_root ()
	/*throw (CanNotFindData)*/
{
	return const_cast<NodeBase*>(((const AutoreferatDocument*)this)->get_contents_root ());
}

// overloaded method from Document
DocumentType AutoreferatDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_4610D3060057_GET*
	return DT_AUTO_REFERAT;
	//#UC END# *460B80CF0201_4610D3060057_GET*
}

// overloaded method from Document
GCI::IO::Stream* AutoreferatDocument::get_annotation_header_evd (unsigned long handle) const /*throw (Unsupported)*/ {
	//#UC START# *4D023D3B02B4_4610D3060057*
	GblPilot::AutoReferatDoc_var server_autoreferat = GblPilot::AutoReferatDoc::_narrow (this->get_server_doc ());
	GDS_ASSERT (!CORBA::is_nil (server_autoreferat));
	try {
		GCD::SeqOctet_var server_evd = server_autoreferat->get_annotation_header_evd (handle);
		return MemoryStreamFactory::make (server_evd, false /*take ownership from proxy*/);
	} catch (GCD::InvalidArgs&) {
		throw Unsupported ();
	}
	//#UC END# *4D023D3B02B4_4610D3060057*
}

// overloaded method from Document
// вернуть число документов для автореферата
size_t AutoreferatDocument::get_auto_referat_doc_count () const /*throw (Unsupported)*/ {
	//#UC START# *4A9F9CF3006A_4610D3060057*
	GblPilot::AutoReferatDoc_var server_autoreferat = GblPilot::AutoReferatDoc::_narrow (this->get_server_doc ());
	GDS_ASSERT (!CORBA::is_nil (server_autoreferat));
	return server_autoreferat->get_documents_count ();
	//#UC END# *4A9F9CF3006A_4610D3060057*
}

// overloaded method from Document
GCI::IO::Stream* AutoreferatDocument::get_autoreferat_header_evd () const /*throw (Unsupported)*/ {
	//#UC START# *4D023C95027A_4610D3060057*
	GblPilot::AutoReferatDoc_var server_autoreferat = GblPilot::AutoReferatDoc::_narrow (this->get_server_doc ());
	GDS_ASSERT (!CORBA::is_nil (server_autoreferat));
	GCD::SeqOctet_var server_evd = server_autoreferat->get_header_evd ();
	return MemoryStreamFactory::make (server_evd, false /*take ownership from proxy*/);
	//#UC END# *4D023C95027A_4610D3060057*
}

// overloaded method from Document
Link* AutoreferatDocument::get_link (unsigned long doc_id, const Topic& id, RedactionID rid) const {
	//#UC START# *53E9F3420066_4610D3060057*
	return LinkFactory::make (this, doc_id, id, rid);
	//#UC END# *53E9F3420066_4610D3060057*
}

// overloaded method from Document
LinkInfo* AutoreferatDocument::get_link_info (unsigned long doc_id, const Topic& id, RedactionID rid) const {
	//#UC START# *47AB2FC90361_4610D3060057*
	Link_var link = LinkFactory::make (this, doc_id, id, rid);
	return link->get_link_info ();
	//#UC END# *47AB2FC90361_4610D3060057*
}

// overloaded method from Document
// Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему
// идентификатору.
// Возвращается интерфейс на объект (obj) и тип объекта (obj_type).
// Дополнительно можно получить интерфейс (missing_info) с информацией, в каких блоках (базах)
// содержится отсутствующий объект (метод get_missing_info)
// Будет использоваться для перехода по гипертекстовой ссылке.
void AutoreferatDocument::get_linked_object (
	unsigned long doc_id
	, const Topic& id
	, RedactionID rid
	, LinkedObjectType& obj_type
	, Core::IObject*& obj
) const /*throw (
	InvalidTopicId
	, FolderLinkNotFound
)*/ {
	//#UC START# *45EEB65201A3_4610D3060057*
	Link_var link = LinkFactory::make (this, doc_id, id, rid);
	obj = link->get_object ();
	obj_type = link->get_object_type ();
	//#UC END# *45EEB65201A3_4610D3060057*
}

// overloaded method from Document
DocumentTextProvider* AutoreferatDocument::get_text_provider (
	bool all_at_once
) const /*throw (
	Unsupported
	, CanNotFindData
)*/ {
	//#UC START# *4CAF1A4B0096_4610D3060057*
	throw Unsupported ();
	//#UC END# *4CAF1A4B0096_4610D3060057*
}

// overloaded method from Document
DocumentTextProvider* AutoreferatDocument::get_text_provider_by_desc (unsigned long handle) /*throw (Unsupported)*/ {
	//#UC START# *4D6291D500E7_4610D3060057*
	GblPilot::CompoundDocument_var doc = GblPilot::CompoundDocument::_narrow (this->get_server_doc ());
	return DocumentTextProviderFactory::make (doc.in (), handle, false /*all_at_once*/);
	//#UC END# *4D6291D500E7_4610D3060057*
}

// overloaded method from Document
const DocumentTextProviderDescriptorList& AutoreferatDocument::get_text_provider_desc_list () /*throw (Unsupported)*/ {
	//#UC START# *4D6289D601A0_4610D3060057*
	this->check_update_and_clear_cache ();
	if (m_desc_list.empty ()) {
		try {
			GblPilot::CompoundDocument_var doc = GblPilot::CompoundDocument::_narrow (this->get_server_doc ());
			GblPilot::HandleList_var list = doc->get_parts ();
			
			for (CORBA::ULong i = 0, length = list->length (); i < length ; ++i) {
				DocumentTextProviderDescriptor desc;
				desc.handle = list [i].handle;
				desc.anno_leaf_count = list [i].leaf_count;
				desc.header_leaf_count = 1;
				m_desc_list.push_back (desc);
			}
		} catch (GCD::CanNotFindData&) {
			throw CanNotFindData ();
		}
	}
	
	GDS_ASSERT (m_desc_list.size ());
	return m_desc_list;

	//#UC END# *4D6289D601A0_4610D3060057*
}

// overloaded method from Document
const DocumentTextProviderList& AutoreferatDocument::get_text_provider_list (
	bool all_at_once
) /*throw (
	Unsupported
)*/ {
	//#UC START# *4CED4A090217_4610D3060057*
	this->check_update_and_clear_cache ();
	if (m_list.empty ()) {
		try {
			GblPilot::CompoundDocument_var doc = GblPilot::CompoundDocument::_narrow (this->get_server_doc ());
			GblPilot::HandleList_var list = doc->get_parts ();
			
			for (CORBA::ULong i = 0, length = list->length (); i < length ; ++i) {
				m_list.push_back (DocumentTextProviderFactory::make (doc.in (), list [i].handle, all_at_once));
			}
		} catch (GCD::CanNotFindData&) {
			throw CanNotFindData ();
		}
	}
	
	GDS_ASSERT (m_list.size ());
	return m_list;
	//#UC END# *4CED4A090217_4610D3060057*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

