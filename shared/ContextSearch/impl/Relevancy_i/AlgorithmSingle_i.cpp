////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/AlgorithmSingle_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::AlgorithmSingle_i
//
// Реализация агоритма расчета релевантности для запроса состоящего из одного слова
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Relevancy_i/AlgorithmSingle_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyCore.h"

namespace ContextSearch {
namespace Relevancy_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AlgorithmSingle_i::AlgorithmSingle_i (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
)
//#UC START# *451659E800BB_45165C3A01A5_4B3AF8F403A8_BASE_INIT*
//#UC END# *451659E800BB_45165C3A01A5_4B3AF8F403A8_BASE_INIT*
{
	//#UC START# *451659E800BB_45165C3A01A5_4B3AF8F403A8_BODY*
	m_base_rel = (Relevancy::BASE_FACTOR << 2) / 3;
	m_info = properties.info;
	//#UC END# *451659E800BB_45165C3A01A5_4B3AF8F403A8_BODY*
}

AlgorithmSingle_i::~AlgorithmSingle_i () {
	//#UC START# *4B3AF8F403A8_DESTR_BODY*
	//#UC END# *4B3AF8F403A8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Relevancy::IAlgorithm
// сбросить свойство
void AlgorithmSingle_i::clear_property (unsigned long value) {
	//#UC START# *46827622031C_4B3AF8F403A8*
	//#UC END# *46827622031C_4B3AF8F403A8*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов приписанных к блочному невидимому тексту
Relevancy::Fragments* AlgorithmSingle_i::get_block_fragments (
	const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
) {
	//#UC START# *4D7A15810054_4B3AF8F403A8*
	return 0;
	//#UC END# *4D7A15810054_4B3AF8F403A8*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов
Relevancy::Fragments* AlgorithmSingle_i::get_fragments (const Relevancy::DataVector& positions) {
	//#UC START# *4516619C0203_4B3AF8F403A8*
	Core::Aptr <Relevancy::Fragments> ret = new Relevancy::Fragments ();
	ret->reserve (positions [0].size ());

	Defs::Fragment fragment (m_base_rel);
	fragment.data.resize (1);

	Relevancy::Positions::const_iterator it = positions [0].begin (), it_end = positions [0].end ();

	for (; it != it_end; ++it) {
		unsigned long flag = *it & POS_FLAGS;

		if (flag != POS_INVISIBLE && flag != POS_INVISIBLE_BLOCK) {
			fragment.info.position = *it & POS_TEXT;
			fragment.data.at (0) = *it;
			ret->push_back (fragment);
		}
	}

	return ret._retn ();
	//#UC END# *4516619C0203_4B3AF8F403A8*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности для невидимого блочного
void AlgorithmSingle_i::get_inv_block_relevancy (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
) {
	//#UC START# *51FFC0600198_4B3AF8F403A8*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *51FFC0600198_4B3AF8F403A8*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности
void AlgorithmSingle_i::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
	, bool has_block
) {
	//#UC START# *45165A6600FA_4B3AF8F403A8*
	info.relevancy_value = 0;
	info.position = 0;

	Defs::RelevancyType rel;

	Relevancy::Positions::const_iterator it = positions [0].begin (), it_end = positions [0].end ();

	for (; it != it_end; ++it) {
		rel = m_base_rel; 

		if (*it & POS_FLAGS) {
			rel += RelevancyCore::get_inv_factor (*it, inv_data, rel_data);
			rel += Relevancy::Z_FACTOR;
		} 

		if (m_info) {
			Defs::RelevancyParam param;
			param.X = m_base_rel;
			param.Y = 0;

			if (*it & POS_FLAGS) {
				param.Z = Relevancy::Z_FACTOR;
			}

			param.I = rel - param.X - param.Z;

			m_info->add (param, *it);
		}

		if (info.relevancy_value < rel) {
			info.relevancy_value = rel;
			info.position = *it;
		}
	}
	//#UC END# *45165A6600FA_4B3AF8F403A8*
}

// implemented method from Relevancy::IAlgorithm
// установить свойство
void AlgorithmSingle_i::set_property (unsigned long value) {
	//#UC START# *4682736F0119_4B3AF8F403A8*
	//#UC END# *4682736F0119_4B3AF8F403A8*
}
} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

