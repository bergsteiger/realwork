////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Link_i
// Заголовок реализации класса серванта для интерфеса Link
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINK_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINK_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

namespace GblAdapterLib {

class Link_i; // self forward Var
typedef ::Core::Var<Link_i> Link_i_var;
typedef ::Core::Var<const Link_i> Link_i_cvar;

class Link_i_factory;

class Link_i:
	virtual public Link
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Link_i)
	friend class Link_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Link_i (unsigned long doc_id, const Topic& topic, RedactionID redaction_id);

	Link_i (const Document* document, unsigned long doc_id, const Topic& topic, RedactionID redaction_id);

	virtual ~Link_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	GblPilot::Link* get_server_link () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblPilot::Link_var m_server_link;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Link
	virtual LinkKind get_kind () const;

	// implemented method from Link
	virtual LinkInfo* get_link_info () const;

	// implemented method from Link
	virtual GCI::IO::String* get_linked_hint () const;

	// implemented method from Link
	virtual Core::IObject* get_object () const /*throw (InvalidTopicId, FolderLinkNotFound, NotAllowedInTrialMode)*/;

	// implemented method from Link
	virtual LinkedObjectType get_object_type () const;
}; // class Link_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINK_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
