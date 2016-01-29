////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocNodeFilter_i
// Заголовк реализации фабрик интерфеса DocNodeFilter для серванта DocNodeFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTreeFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DocNodeFilter_i
class DocNodeFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public DocNodeFilterAbstractFactory {
public:
	DocNodeFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocNodeFilter* make ();

};

typedef ::Core::Var<DocNodeFilter_i_factory> DocNodeFilter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

