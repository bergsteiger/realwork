////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/RequestTransformer_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::RequestTransformer_i
// Заголовк реализации фабрик интерфеса IRequestTransformer для серванта RequestTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Manage/ManageFactories.h"

namespace ContextSearch {
namespace Manage_i {

/// Interface-factory implementation for RequestTransformer_i
class RequestTransformer_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Manage::IRequestTransformerAbstractFactory
{
public:
	RequestTransformer_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Manage::IRequestTransformer* make (Morpho::Def::INormalizer* normalizer);

};

typedef ::Core::Var<RequestTransformer_i_factory> RequestTransformer_i_factory_var;

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

