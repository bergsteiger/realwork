////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/MorphoFilter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::MorphoFilter
//
// Фильтр
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/impl/Impl/MorphoFilter.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"

namespace Morpho {
namespace Impl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MorphoFilter::MorphoFilter (Def::ICache* cache)
//#UC START# *4E00CA180245_BASE_INIT*
//#UC END# *4E00CA180245_BASE_INIT*
{
	//#UC START# *4E00CA180245_BODY*
	m_cache = Def::ICache::_duplicate (cache);
	//#UC END# *4E00CA180245_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// фильтрация лемм
void MorphoFilter::execute (const std::string& word, GCL::StrVector& in) {
	//#UC START# *4E00CAD20070*
	if (in.size () > 1 && m_cache.is_nil () == false) {
		GCL::StrVector::iterator it = in.begin ();

		for (; it != in.end (); ++it) {
			if (this->is_exclude (word, *it)) {
				it->clear ();
			}
		}

		it = std::remove_if (in.begin (), in.end (), boost::bind (&std::string::empty, _1));
		in.erase (it, in.end ());

		GDS_ASSERT (in.empty () == false);
	}
	//#UC END# *4E00CAD20070*
}

// является ли лексема исключением
bool MorphoFilter::is_exclude (const std::string& word, const std::string& lexeme) const {
	//#UC START# *4E00CA9402A8*
	const Def::Exclude& data = m_cache->get_exclude ();

	Def::Exclude::const_iterator it = data.find (word);

	if (it != data.end ()) {
		return (std::find (it->second.begin (), it->second.end (), lexeme) != it->second.end ());
	}

	return false;
	//#UC END# *4E00CA9402A8*
}

// нужна ли нормализация
bool MorphoFilter::is_lemmatize (const std::string& word) const {
	//#UC START# *4E00CA380361*
	if (m_cache.is_nil () == false) {
		const GCL::StrVector& data = m_cache->get_not_normalized ();
		return (std::binary_search (data.begin (), data.end (), word) == false);
	}

	return true;
	//#UC END# *4E00CA380361*
}

} // namespace Impl
} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

