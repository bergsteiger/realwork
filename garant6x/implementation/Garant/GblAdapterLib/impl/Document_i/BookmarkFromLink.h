////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookmarkFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::BookmarkFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARKFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARKFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class BookmarkFromLink; // self forward Var
typedef ::Core::Var<BookmarkFromLink> BookmarkFromLink_var;
typedef ::Core::Var<const BookmarkFromLink> BookmarkFromLink_cvar;

class BookmarkFromLink_factory;

class BookmarkFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (BookmarkFromLink)
	friend class BookmarkFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BookmarkFromLink (GblPilot::Link* server_link);

	virtual ~BookmarkFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class BookmarkFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARKFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
