////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MorphoManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MorphoManager_i
// Заголовк реализации фабрик интерфеса MorphoManager для серванта MorphoManager_i
//
// Реализация интерфейса MorphoManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOMANAGER_I_FCTR_H__
#define __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOMANAGER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/DefFactories.h"

namespace MorphoAdapterLib {
namespace Impl {

/// Interface-factory implementation for MorphoManager_i
class MorphoManager_i_factory: virtual public ::Core::RefCountObjectBase, virtual public MorphoManagerAbstractFactory {
public:
	MorphoManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MorphoManager* make ();

};

typedef ::Core::Var<MorphoManager_i_factory> MorphoManager_i_factory_var;

} // namespace Impl
} // namespace MorphoAdapterLib


#endif //__GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

