////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ListFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ListFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LISTFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LISTFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class ListFromLink; // self forward Var
typedef ::Core::Var<ListFromLink> ListFromLink_var;
typedef ::Core::Var<const ListFromLink> ListFromLink_cvar;

class ListFromLink_factory;

class ListFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (ListFromLink)
	friend class ListFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ListFromLink (GblPilot::Link* server_link);

	virtual ~ListFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class ListFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LISTFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
