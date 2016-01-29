////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::VariantsForDocFilter_i
// Заголовк реализации фабрик интерфеса VariantsForDocFilter для серванта VariantsForDocFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTSFORDOCFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTSFORDOCFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for VariantsForDocFilter_i
class VariantsForDocFilter_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public VariantsForDocFilterAbstractFactory
{
public:
	VariantsForDocFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	VariantsForDocFilter* make (unsigned long doc_id);

	VariantsForDocFilter* make ();

};

typedef ::Core::Var<VariantsForDocFilter_i_factory> VariantsForDocFilter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTSFORDOCFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

