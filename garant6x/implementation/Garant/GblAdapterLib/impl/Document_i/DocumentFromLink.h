////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class DocumentFromLink; // self forward Var
typedef ::Core::Var<DocumentFromLink> DocumentFromLink_var;
typedef ::Core::Var<const DocumentFromLink> DocumentFromLink_cvar;

class DocumentFromLink_factory;

class DocumentFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (DocumentFromLink)
	friend class DocumentFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	DocumentFromLink (GblPilot::Link* server_link);

	~DocumentFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	LinkedObjectType get_object_type () const;
}; // class DocumentFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
