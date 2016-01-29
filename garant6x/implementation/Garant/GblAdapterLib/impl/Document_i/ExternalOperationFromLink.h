////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalOperationFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalOperationFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALOPERATIONFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALOPERATIONFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class ExternalOperationFromLink; // self forward Var
typedef ::Core::Var<ExternalOperationFromLink> ExternalOperationFromLink_var;
typedef ::Core::Var<const ExternalOperationFromLink> ExternalOperationFromLink_cvar;

class ExternalOperationFromLink_factory;

class ExternalOperationFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (ExternalOperationFromLink)
	friend class ExternalOperationFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExternalOperationFromLink (GblPilot::Link* server_link);

	virtual ~ExternalOperationFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class ExternalOperationFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALOPERATIONFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
