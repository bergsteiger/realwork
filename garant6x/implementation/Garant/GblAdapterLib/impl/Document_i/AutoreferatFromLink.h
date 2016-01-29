////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::AutoreferatFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class AutoreferatFromLink; // self forward Var
typedef ::Core::Var<AutoreferatFromLink> AutoreferatFromLink_var;
typedef ::Core::Var<const AutoreferatFromLink> AutoreferatFromLink_cvar;

class AutoreferatFromLink_factory;

class AutoreferatFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (AutoreferatFromLink)
	friend class AutoreferatFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AutoreferatFromLink (GblPilot::Link* server_link);

	virtual ~AutoreferatFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class AutoreferatFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
