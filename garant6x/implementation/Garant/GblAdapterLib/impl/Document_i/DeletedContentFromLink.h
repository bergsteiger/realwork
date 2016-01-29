////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DeletedContentFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DELETEDCONTENTFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DELETEDCONTENTFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class DeletedContentFromLink; // self forward Var
typedef ::Core::Var<DeletedContentFromLink> DeletedContentFromLink_var;
typedef ::Core::Var<const DeletedContentFromLink> DeletedContentFromLink_cvar;

class DeletedContentFromLink_factory;

class DeletedContentFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (DeletedContentFromLink)
	friend class DeletedContentFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DeletedContentFromLink (GblPilot::Link* server_link);

	virtual ~DeletedContentFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class DeletedContentFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DELETEDCONTENTFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
