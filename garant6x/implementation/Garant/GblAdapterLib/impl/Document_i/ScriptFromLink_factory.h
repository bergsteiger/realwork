////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ScriptFromLink
// Заголовк реализации фабрик интерфеса  для серванта ScriptFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SCRIPTFROMLINK_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SCRIPTFROMLINK_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ScriptFromLink
class ScriptFromLink_factory: virtual public ::Core::RefCountObjectBase, virtual public ObjectFromLinkAbstractFactory {
public:
	ScriptFromLink_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const LinkedObjectType key () const;

	ObjectFromLink* make (GblPilot::Link* server_link);

};

typedef ::Core::Var<ScriptFromLink_factory> ScriptFromLink_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SCRIPTFROMLINK_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

