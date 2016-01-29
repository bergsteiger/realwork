////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/WildCard_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::WildCard_i
//
// Имплементация IWildCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDCARD_I_H__
#define __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDCARD_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/DB/DBCore/DBCore.h"
#include "shared/Morpho/Def/Def.h"

namespace SearchAdapterLib {
namespace DBComm_i {

// Имплементация IWildCard
class WildCard_i;
typedef Core::Var<WildCard_i> WildCard_i_var;
typedef Core::Var<const WildCard_i> WildCard_i_cvar;

class WildCard_i :
	virtual public ContextSearch::DBComm::IWildCard
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (WildCard_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	WildCard_i (DBCore::IBase* base, const std::string& src, size_t max_size, Morpho::Def::INormalizer* normalizer);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBCore::IBase_var m_base;

	size_t m_max_size;

	Morpho::Def::INormalizer_var m_normalizer;

	std::string m_src;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContextSearch::DBComm::IWildCard
	// получить множество удовлетворяющее шаблону
	GCL::StrSet* get (const std::string& in);
}; // class WildCard_i

} // namespace DBComm_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDCARD_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

