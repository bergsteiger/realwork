////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Helper_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Helper_i
// Заголовок реализации класса серванта для интерфеса IHelper
//
// Реализация интерфейса IHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_HELPER_I_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_HELPER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/Def/Def.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"

//#UC START# *4ED500FA02BB_CUSTOM_INCLUDES*
//#UC END# *4ED500FA02BB_CUSTOM_INCLUDES*

namespace SearchAdapterLib {
namespace Adapter_i {

class Helper_i; // self forward Var
typedef ::Core::Var<Helper_i> Helper_i_var;
typedef ::Core::Var<const Helper_i> Helper_i_cvar;

class Helper_i_factory;

// Реализация интерфейса IHelper
class Helper_i:
	virtual public Adapter::IHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Helper_i)
	friend class Helper_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Helper_i (Morpho::Def::ICache* cache);

	virtual ~Helper_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Morpho::Def::INormalizer_var m_normalizer;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Adapter::IHelper
	// синонимия
	virtual Adapter::ISynRequest* synonymy (const char* req);

	// implemented method from Adapter::IHelper
	// трансформация строки запроса
	virtual Adapter::IStrings* transform (const std::string& str);

//#UC START# *4ED500FA02BB*
//#UC END# *4ED500FA02BB*
}; // class Helper_i

} // namespace Adapter_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_HELPER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
