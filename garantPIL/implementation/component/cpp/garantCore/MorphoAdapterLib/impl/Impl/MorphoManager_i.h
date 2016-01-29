////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MorphoManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MorphoManager_i
// Заголовок реализации класса серванта для интерфеса MorphoManager
//
// Реализация интерфейса MorphoManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOMANAGER_I_H__
#define __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOMANAGER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/Def.h"

//#UC START# *4EA41FC20359_CUSTOM_INCLUDES*
//#UC END# *4EA41FC20359_CUSTOM_INCLUDES*

namespace MorphoAdapterLib {
namespace Impl {

class MorphoManager_i; // self forward Var
typedef ::Core::Var<MorphoManager_i> MorphoManager_i_var;
typedef ::Core::Var<const MorphoManager_i> MorphoManager_i_cvar;

class MorphoManager_i_factory;

// Реализация интерфейса MorphoManager
class MorphoManager_i:
	virtual public MorphoManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MorphoManager_i)
	friend class MorphoManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	MorphoManager_i ();

	~MorphoManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MorphoManager
	// деинициализация
	void done ();

	// implemented method from MorphoManager
	// инициализация
	void init (const char* base_path);

//#UC START# *4EA41FC20359*
//#UC END# *4EA41FC20359*
}; // class MorphoManager_i

} // namespace Impl
} // namespace MorphoAdapterLib


#endif //__GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
