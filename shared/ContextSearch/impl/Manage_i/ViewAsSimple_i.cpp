////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSimple_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSimple_i
//
// Простое представление (без синонимов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSimple_i.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "shared/ContextSearch/MorphoBase/RequestBuilder.h"

namespace ContextSearch {
namespace Manage_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ViewAsSimple_i::ViewAsSimple_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer)
//#UC START# *5273986F01D9_52739AA90277_5391DAF7015C_BASE_INIT*
//#UC END# *5273986F01D9_52739AA90277_5391DAF7015C_BASE_INIT*
{
	//#UC START# *5273986F01D9_52739AA90277_5391DAF7015C_BODY*
	m_normalizer = Morpho::Def::INormalizer::_duplicate (normalizer);
	//#UC END# *5273986F01D9_52739AA90277_5391DAF7015C_BODY*
}

ViewAsSimple_i::~ViewAsSimple_i () {
	//#UC START# *5391DAF7015C_DESTR_BODY*
	//#UC END# *5391DAF7015C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить запрос
void ViewAsSimple_i::add_request (const std::string& req) {
	//#UC START# *5391DCED0283*
	Core::Aptr <GCL::StrVector> res = m_normalizer->execute_for_phrase (req);

	for (GCL::StrVector::const_iterator it = res->begin (); it != res->end (); ++it) {
		Search::SplitRequest request;
		RequestBuilder::make (*it, request);

		if (request.context.empty () == false) {
			m_sequence.push_back (request);
		}
	}
	//#UC END# *5391DCED0283*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Search::IRequestView
// создать
bool ViewAsSimple_i::build (const Search::Phrase& in, const std::string& src) {
	//#UC START# *528CD00602B1_5391DAF7015C*
	std::for_each (in.begin (), in.end (), boost::bind (&ViewAsSimple_i::add_request, this, _1));
	return (m_sequence.empty () == false);
	//#UC END# *528CD00602B1_5391DAF7015C*
}

// implemented method from Search::IRequestView
// список синонимичных
const Search::SplitRequests& ViewAsSimple_i::get_sequence () const {
	//#UC START# *5273997201A4_5391DAF7015C*
	return m_sequence;
	//#UC END# *5273997201A4_5391DAF7015C*
}

// implemented method from Search::IRequestView
// спаны
const Search::Phrases& ViewAsSimple_i::get_spans () const {
	//#UC START# *5273994602A8_5391DAF7015C*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *5273994602A8_5391DAF7015C*
}

// implemented method from Search::IRequestView
// тип
Search::AlgorithmSelector ViewAsSimple_i::get_type () const {
	//#UC START# *5280F02702AB_5391DAF7015C*
	return Search::as_Default;
	//#UC END# *5280F02702AB_5391DAF7015C*
}
} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

