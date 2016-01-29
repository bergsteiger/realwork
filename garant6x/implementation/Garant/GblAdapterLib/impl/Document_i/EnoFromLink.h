////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/EnoFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::EnoFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ENOFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ENOFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink.h"

namespace GblAdapterLib {

class EnoFromLink; // self forward Var
typedef ::Core::Var<EnoFromLink> EnoFromLink_var;
typedef ::Core::Var<const EnoFromLink> EnoFromLink_cvar;

class EnoFromLink_factory;

class EnoFromLink:
	virtual public ExternalLinkFromLink
{
	SET_OBJECT_COUNTER (EnoFromLink)
	friend class EnoFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	EnoFromLink (GblPilot::Link* server_link);

	virtual ~EnoFromLink ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;

}; // class EnoFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ENOFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
