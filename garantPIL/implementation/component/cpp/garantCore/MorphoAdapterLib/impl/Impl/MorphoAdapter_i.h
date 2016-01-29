////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MorphoAdapter_i
// Заголовок реализации класса серванта для интерфеса MorphoAdapter
//
// Реализация интерфейса MorphoAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOADAPTER_I_H__
#define __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOADAPTER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/Def.h"

namespace MorphoAdapterLib {
namespace Impl {

class MorphoAdapter_i; // self forward Var
typedef ::Core::Var<MorphoAdapter_i> MorphoAdapter_i_var;
typedef ::Core::Var<const MorphoAdapter_i> MorphoAdapter_i_cvar;

class MorphoAdapter_i_factory;

// Реализация интерфейса MorphoAdapter
class MorphoAdapter_i:
	virtual public MorphoAdapter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MorphoAdapter_i)
	friend class MorphoAdapter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	MorphoAdapter_i ();

	~MorphoAdapter_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MorphoAdapter
	// нормализация
	size_t normalize (const char* word, char* out);
}; // class MorphoAdapter_i

} // namespace Impl
} // namespace MorphoAdapterLib


#endif //__GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOADAPTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
