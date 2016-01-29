////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalLinkFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALLINKFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALLINKFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class ExternalLinkFromLink; // self forward Var
typedef ::Core::Var<ExternalLinkFromLink> ExternalLinkFromLink_var;
typedef ::Core::Var<const ExternalLinkFromLink> ExternalLinkFromLink_cvar;

class ExternalLinkFromLink_factory;

class ExternalLinkFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (ExternalLinkFromLink)
	friend class ExternalLinkFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExternalLinkFromLink (GblPilot::Link* server_link);

	virtual ~ExternalLinkFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class ExternalLinkFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALLINKFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
