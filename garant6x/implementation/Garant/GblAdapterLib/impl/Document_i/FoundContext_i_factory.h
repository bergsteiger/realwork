////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::FoundContext_i
// Заголовк реализации фабрик интерфеса FoundContext для серванта FoundContext_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FOUNDCONTEXT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FOUNDCONTEXT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for FoundContext_i
class FoundContext_i_factory: virtual public ::Core::RefCountObjectBase, virtual public FoundContextAbstractFactory {
public:
	FoundContext_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	FoundContext* make (const GblPilot::ContextList& list);

};

typedef ::Core::Var<FoundContext_i_factory> FoundContext_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FOUNDCONTEXT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

