////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Collector_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::Collector_i
//
// Коллектор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/Collector_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Collector_i::Collector_i ()
//#UC START# *53860C0202C5_BASE_INIT*
	: m_mid (0)
	, m_last (0)
//#UC END# *53860C0202C5_BASE_INIT*
{
	//#UC START# *53860C0202C5_BODY*
	m_data = new Search::RelevancyDocuments ();
	//#UC END# *53860C0202C5_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// _retn
Search::RelevancyDocuments* Collector_i::_retn () {
	//#UC START# *53860C120075*
	return (m_data->empty ())? 0 : m_data.forget ();
	//#UC END# *53860C120075*
}

// merge
void Collector_i::merge () {
	//#UC START# *538721820171*
	if (m_mid && m_mid < m_data->size ()) {
		std::inplace_merge (m_data->begin (), m_data->begin () + m_mid, m_data->end ());
	}
	m_mid = m_data->size ();
	//#UC END# *538721820171*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Defs::IResCollector
// add
void Collector_i::add (Defs::DocId id, const Defs::RelevancyInfo& info) {
	//#UC START# *532294C70019_53860BB5034E*
	Defs::RelevancyDocInfo at;
	at.doc_id = id;
	at.info.position = info.position;
	at.info.relevancy_value = info.relevancy_value;

	if (m_last >= at.doc_id) {
		this->merge ();
	}

	if (m_mid) {
		Search::RelevancyDocuments::iterator end = m_data->begin ();
		std::advance (end, m_mid);

		Search::RelevancyDocuments::iterator it = std::lower_bound (m_data->begin (), end, at);

		if (it != end && it->doc_id == at.doc_id) {
			if (it->info.relevancy_value < at.info.relevancy_value) {
				it->info.relevancy_value = at.info.relevancy_value;
				it->info.position = at.info.position;
			} else if (it->info.relevancy_value == at.info.relevancy_value 
				&& (it->info.position & POS_TEXT) > (at.info.position & POS_TEXT)
			) {
				it->info.relevancy_value = at.info.relevancy_value;
				it->info.position = at.info.position;
			}
			return;
		}
	}

	m_last = at.doc_id;
	m_data->push_back (at);
	//#UC END# *532294C70019_53860BB5034E*
}

// implemented method from Defs::IResCollector
// empty
bool Collector_i::empty () const {
	//#UC START# *552FE9010247_53860BB5034E*
	return (m_data.is_nil () || m_data->empty ());
	//#UC END# *552FE9010247_53860BB5034E*
}

// implemented method from Defs::IResCollector
// finish
void Collector_i::finish (const std::string& req) {
	//#UC START# *5551DFC3011D_53860BB5034E*
	this->merge ();
	m_last = 0;
	//#UC END# *5551DFC3011D_53860BB5034E*
}

// implemented method from Defs::IResCollector
// filter
Defs::IFilter* Collector_i::get_filter (char op) {
	//#UC START# *552FE8D503DF_53860BB5034E*
	return 0;
	//#UC END# *552FE8D503DF_53860BB5034E*
}

// implemented method from Defs::IResCollector
// start
void Collector_i::start (const std::string& req) {
	//#UC START# *5551DFA100F7_53860BB5034E*
	//#UC END# *5551DFA100F7_53860BB5034E*
}
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

