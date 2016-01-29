////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::AlgorithmIdentical_i
//
// Реализация агоритма расчета релевантности для запроса состоящего из одинаковых слов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

namespace ContextSearch {
namespace Relevancy_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AlgorithmIdentical_i::AlgorithmIdentical_i (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
)
//#UC START# *451659E800BB_45165C3A01A5_4B34C01C0335_BASE_INIT*
	: RelevancyCore (req_data, properties)
//#UC END# *451659E800BB_45165C3A01A5_4B34C01C0335_BASE_INIT*
{
	//#UC START# *451659E800BB_45165C3A01A5_4B34C01C0335_BODY*
	//#UC END# *451659E800BB_45165C3A01A5_4B34C01C0335_BODY*
}

AlgorithmIdentical_i::~AlgorithmIdentical_i () {
	//#UC START# *4B34C01C0335_DESTR_BODY*
	//#UC END# *4B34C01C0335_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// генерация контейнера цепочек
void AlgorithmIdentical_i::get (
	Defs::RelevancyInfo& out
	, const Relevancy::Positions& data
	, const Defs::InvisibleData& inv
	, const Defs::PositionsRel& rel
) {
	//#UC START# *4B34C5E60246*
	size_t count = RelevancyCore::properties ().count;

	if (data.size () < count) {
		return;
	}

	Defs::RelevancyInfo cur;

	Relevancy::Positions chain;
	Relevancy::Positions::const_iterator it = data.begin (), it_end = data.end ();

	for (; it != it_end; ++it) {
		chain.assign (it, it + count);

		RelevancyCore::get_relevancy_info (cur, chain, inv, rel);

		if (out.relevancy_value < cur.relevancy_value) {
			out.relevancy_value = cur.relevancy_value;
			out.position = chain [0];
		} 

		if (it + count == it_end) {
			break;
		}
	}
	//#UC END# *4B34C5E60246*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Relevancy::IAlgorithm
// сбросить свойство
void AlgorithmIdentical_i::clear_property (unsigned long value) {
	//#UC START# *46827622031C_4B34C01C0335*
	RelevancyCore::set_flags (RelevancyCore::get_flags () & ~value);
	//#UC END# *46827622031C_4B34C01C0335*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов приписанных к блочному невидимому тексту
Relevancy::Fragments* AlgorithmIdentical_i::get_block_fragments (
	const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
) {
	//#UC START# *4D7A15810054_4B34C01C0335*
	return 0;
	//#UC END# *4D7A15810054_4B34C01C0335*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов
Relevancy::Fragments* AlgorithmIdentical_i::get_fragments (const Relevancy::DataVector& positions) {
	//#UC START# *4516619C0203_4B34C01C0335*
	size_t data_size = positions [0].size ();
	size_t count = RelevancyCore::properties ().count;

	if (data_size < count) {
		return 0;
	}

	RelevancyCore::Chains& chains = RelevancyCore::chains ();
	chains.resize (data_size - count + 1);

	RelevancyCore::Chains::iterator chain_it = chains.begin ();

	Relevancy::Positions::const_iterator it = positions [0].begin (), it_end = positions [0].end ();

	for (; it != it_end; ++it, ++chain_it) {
		chain_it->assign (it, it + count);
		if (it + count == it_end) {
			break;
		}
	}

	return RelevancyCore::get_fragments (positions [0], 0);
	//#UC END# *4516619C0203_4B34C01C0335*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности для невидимого блочного
void AlgorithmIdentical_i::get_inv_block_relevancy (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
) {
	//#UC START# *51FFC0600198_4B34C01C0335*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *51FFC0600198_4B34C01C0335*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности
void AlgorithmIdentical_i::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
	, bool has_block
) {
	//#UC START# *45165A6600FA_4B34C01C0335*
	info.relevancy_value = 0;
	info.position = 0;

	size_t data_size = positions [0].size ();

	if (data_size < RelevancyCore::properties ().count) {
		return;
	}

	Relevancy::Positions headers;
	headers.reserve (data_size);

	Relevancy::Positions::const_iterator it = positions [0].begin (), it_end = positions [0].end ();

	for (; it != it_end; ++it) {
		if ((*it & POS_FLAGS) == POS_HEADER) {
			headers.push_back (*it);
		}
	}

	AlgorithmIdentical_i::get (info, headers, inv_data, rel_data);
	AlgorithmIdentical_i::get (info, positions [0], inv_data, rel_data);
	//#UC END# *45165A6600FA_4B34C01C0335*
}

// implemented method from Relevancy::IAlgorithm
// установить свойство
void AlgorithmIdentical_i::set_property (unsigned long value) {
	//#UC START# *4682736F0119_4B34C01C0335*
	RelevancyCore::set_flags (RelevancyCore::get_flags () | value);
	//#UC END# *4682736F0119_4B34C01C0335*
}
} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

