////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ScriptFromLink
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SCRIPTFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SCRIPTFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink.h"

namespace GblAdapterLib {

class ScriptFromLink; // self forward Var
typedef ::Core::Var<ScriptFromLink> ScriptFromLink_var;
typedef ::Core::Var<const ScriptFromLink> ScriptFromLink_cvar;

class ScriptFromLink_factory;

class ScriptFromLink:
	virtual public ExternalLinkFromLink
{
	SET_OBJECT_COUNTER (ScriptFromLink)
	friend class ScriptFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ScriptFromLink (GblPilot::Link* server_link);

	virtual ~ScriptFromLink ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;

}; // class ScriptFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SCRIPTFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
