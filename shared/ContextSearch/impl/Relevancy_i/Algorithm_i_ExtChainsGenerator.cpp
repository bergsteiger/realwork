////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/Algorithm_i_ExtChainsGenerator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Relevancy_i::Algorithm_i::ExtChainsGenerator
//
// Генератор дополнительных цепочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Relevancy_i/Algorithm_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

namespace ContextSearch {
namespace Relevancy_i {
class Algorithm_i;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Algorithm_i::ExtChainsGenerator::ExtChainsGenerator ()
//#UC START# *4A683351015E_BASE_INIT*
//#UC END# *4A683351015E_BASE_INIT*
{
	//#UC START# *4A683351015E_BODY*
	m_ext_chains.reserve (RelevancyCore::RESERVE_SIZE);
	//#UC END# *4A683351015E_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// генерировать новую цепочку
void Algorithm_i::ExtChainsGenerator::generate (
	Defs::Position x_val
	, Defs::Position x_pos
	, Defs::Position y_val
	, Defs::Position y_pos
) {
	//#UC START# *4A683392010A*
	if (m_def_chain.empty ()) {
		return;
	}

	bool is_insert = (m_offset >= m_ext_chains.size ());

	Relevancy::Positions& chain = is_insert? m_def_chain : m_ext_chains [m_offset];

	Relevancy::Positions::iterator it_begin = chain.begin ();

	std::fill (it_begin, chain.end (), 0);

	*(it_begin + x_pos) = x_val;
	*(it_begin + y_pos) = y_val;

	++m_offset;

	if (is_insert) {
		m_ext_chains.push_back (chain);
	}
	//#UC END# *4A683392010A*
}

// генерировать новую цепочку
void Algorithm_i::ExtChainsGenerator::generate (
	const Relevancy::Positions& data
	, Defs::Position val
	, Defs::Position pos
	, bool check_identical
) {
	//#UC START# *4D39884C01BF*
	if (check_identical && std::find (data.begin (), data.end (), val) != data.end ()) {
		return;
	}

	if (m_offset < m_ext_chains.size ()) {
		m_ext_chains [m_offset] = data;
		m_ext_chains [m_offset] [pos] = val;
	} else {
		m_ext_chains.push_back (data);
		m_ext_chains.back () [pos] = val;
	}

	++m_offset;
	//#UC END# *4D39884C01BF*
}

// инициализация
void Algorithm_i::ExtChainsGenerator::init (size_t count) {
	//#UC START# *4A683BE802C2*
	m_offset = 0;

	if (count == 0) {
		m_def_chain.clear ();
	} else if (m_def_chain.size () != count) {
		m_def_chain.resize (count);
	} 
	//#UC END# *4A683BE802C2*
}

// смерджить цепочки
void Algorithm_i::ExtChainsGenerator::merge (RelevancyCore::Chains& out) {
	//#UC START# *4A6834D403C8*
	if (m_offset) {
		out.insert (out.end (), m_ext_chains.begin (), m_ext_chains.begin () + m_offset);

		m_offset = 0;

		if (m_ext_chains.size () > RelevancyCore::MAX_CHAINS_SIZE) {
			Chains cleaner;
			m_ext_chains.swap (cleaner);
			m_ext_chains.reserve (RelevancyCore::RESERVE_SIZE);
		}
	}
	//#UC END# *4A6834D403C8*
}

} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

