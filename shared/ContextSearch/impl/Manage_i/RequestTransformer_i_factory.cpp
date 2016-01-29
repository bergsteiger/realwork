////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/RequestTransformer_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::RequestTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Manage_i/RequestTransformer_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/RequestTransformer_i.h"

namespace ContextSearch {
namespace Manage_i {

RequestTransformer_i_factory::RequestTransformer_i_factory () {
}

void RequestTransformer_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Manage::IRequestTransformerFactoryManager::register_factory (this, priority);
}

const char* RequestTransformer_i_factory::key () const {
	return "RequestTransformer_i";
}

Manage::IRequestTransformer* RequestTransformer_i_factory::make (Morpho::Def::INormalizer* normalizer) {
	RequestTransformer_i_var ret = new RequestTransformer_i (normalizer);
	return ret._retn ();
}

} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

