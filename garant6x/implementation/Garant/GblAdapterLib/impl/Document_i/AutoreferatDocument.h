////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::AutoreferatDocument
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"

namespace GblAdapterLib {

class AutoreferatDocument; // self forward Var
typedef ::Core::Var<AutoreferatDocument> AutoreferatDocument_var;
typedef ::Core::Var<const AutoreferatDocument> AutoreferatDocument_cvar;

class AutoreferatDocument_factory;
class AutoreferatDocumentServantFactory;

class AutoreferatDocument:
	virtual public SimpleDocument
{
	SET_OBJECT_COUNTER (AutoreferatDocument)
	friend class AutoreferatDocument_factory; // self factory
	friend class AutoreferatDocumentServantFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit AutoreferatDocument (GblPilot::Document* document);

	virtual ~AutoreferatDocument ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	BookmarkList m_bookmark_list;

	CommentsParaList m_comments_para_list;

	DocumentTextProviderDescriptorList m_desc_list;

	DocumentTextProviderList m_list;

	GCD::PID m_pid;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from DocWithPid
	virtual const GCD::PID& get_document_pid () const;
protected:

	// overloaded method from Document
	virtual const BookmarkList& get_bookmark_list () const;

	// overloaded method from Document
	virtual const CommentsParaList& get_comments_para_list () const;

	// overloaded method from Document
	virtual const NodeBase* get_contents_root () const
		/*throw (CanNotFindData)*/;
	virtual NodeBase* get_contents_root ()
		/*throw (CanNotFindData)*/;

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

	// overloaded method from Document
	virtual GCI::IO::Stream* get_annotation_header_evd (unsigned long handle) const /*throw (Unsupported)*/;

	// overloaded method from Document
	// вернуть число документов для автореферата
	virtual size_t get_auto_referat_doc_count () const /*throw (Unsupported)*/;

	// overloaded method from Document
	virtual GCI::IO::Stream* get_autoreferat_header_evd () const /*throw (Unsupported)*/;

	// overloaded method from Document
	virtual Link* get_link (unsigned long doc_id, const Topic& id, RedactionID rid) const;

	// overloaded method from Document
	virtual LinkInfo* get_link_info (unsigned long doc_id, const Topic& id, RedactionID rid) const;

	// overloaded method from Document
	// Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему
	// идентификатору.
	// Возвращается интерфейс на объект (obj) и тип объекта (obj_type).
	// Дополнительно можно получить интерфейс (missing_info) с информацией, в каких блоках (базах)
	// содержится отсутствующий объект (метод get_missing_info)
	// Будет использоваться для перехода по гипертекстовой ссылке.
	virtual void get_linked_object (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, LinkedObjectType& obj_type
		, Core::IObject*& obj
	) const /*throw (
		InvalidTopicId
		, FolderLinkNotFound
		, NotAllowedInTrialMode
	)*/;

	// overloaded method from Document
	virtual DocumentTextProvider* get_text_provider (bool all_at_once) const /*throw (Unsupported, CanNotFindData)*/;

	// overloaded method from Document
	virtual DocumentTextProvider* get_text_provider_by_desc (unsigned long handle) /*throw (Unsupported)*/;

	// overloaded method from Document
	virtual const DocumentTextProviderDescriptorList& get_text_provider_desc_list () /*throw (Unsupported)*/;

	// overloaded method from Document
	virtual const DocumentTextProviderList& get_text_provider_list (bool all_at_once) /*throw (Unsupported)*/;
private:

	// overloaded method from BaseUpdateChecker_i
	virtual void clear_cache ();

}; // class AutoreferatDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
