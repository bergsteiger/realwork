////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/QueryFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::QueryFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_QUERYFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_QUERYFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class QueryFromLink; // self forward Var
typedef ::Core::Var<QueryFromLink> QueryFromLink_var;
typedef ::Core::Var<const QueryFromLink> QueryFromLink_cvar;

class QueryFromLink_factory;

class QueryFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (QueryFromLink)
	friend class QueryFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryFromLink (GblPilot::Link* server_link);

	virtual ~QueryFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class QueryFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_QUERYFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
