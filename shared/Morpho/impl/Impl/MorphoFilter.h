////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/MorphoFilter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::MorphoFilter
//
// Фильтр
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_MORPHOFILTER_H__
#define __SHARED_MORPHO_IMPL_MORPHOFILTER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"

namespace Morpho {
namespace Impl {

// Фильтр
class MorphoFilter {
	SET_OBJECT_COUNTER (MorphoFilter)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit MorphoFilter (Def::ICache* cache);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// фильтрация лемм
	void execute (const std::string& word, GCL::StrVector& in);

	// нужна ли нормализация
	bool is_lemmatize (const std::string& word) const;

private:
	// является ли лексема исключением
	bool is_exclude (const std::string& word, const std::string& lexeme) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Def::ICache_var m_cache;
}; // class MorphoFilter

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_MORPHOFILTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

