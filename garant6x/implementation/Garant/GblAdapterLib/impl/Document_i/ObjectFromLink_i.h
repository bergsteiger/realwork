////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ObjectFromLink_i
// Заголовок реализации класса серванта для интерфеса ObjectFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_OBJECTFROMLINK_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_OBJECTFROMLINK_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

namespace GblAdapterLib {

class ObjectFromLink_i; // self forward Var
typedef ::Core::Var<ObjectFromLink_i> ObjectFromLink_i_var;
typedef ::Core::Var<const ObjectFromLink_i> ObjectFromLink_i_cvar;

class ObjectFromLink_i:
	virtual public ObjectFromLink
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ObjectFromLink_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ObjectFromLink_i (GblPilot::Link* server_link);

	virtual ~ObjectFromLink_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	virtual GblPilot::Link* get_server_link () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblPilot::Link_var m_server_link;
}; // class ObjectFromLink_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_OBJECTFROMLINK_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
