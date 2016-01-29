////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MlmaRu_i
// Заголовк реализации фабрик интерфеса MlmaRu для серванта MlmaRu_i
//
// Сервант-обертка для экспорта функций библиотеки mlmaru
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_IMPL_MLMARU_I_FCTR_H__
#define __GARANTCORE_MORPHOADAPTERLIB_IMPL_MLMARU_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/DefFactories.h"

namespace MorphoAdapterLib {
namespace Impl {

/// Interface-factory implementation for MlmaRu_i
class MlmaRu_i_factory: virtual public ::Core::RefCountObjectBase, virtual public MlmaRuAbstractFactory {
public:
	MlmaRu_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MlmaRu* make ();

};

typedef ::Core::Var<MlmaRu_i_factory> MlmaRu_i_factory_var;

} // namespace Impl
} // namespace MorphoAdapterLib


#endif //__GARANTCORE_MORPHOADAPTERLIB_IMPL_MLMARU_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

