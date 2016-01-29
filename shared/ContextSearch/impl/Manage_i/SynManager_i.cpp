////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/SynManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::SynManager_i
//
// Реализация интерфейса ISynManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Manage_i/SynManager_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/MorphoBase/Synonymizer.h"

namespace ContextSearch {
namespace Manage_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SynManager_i::SynManager_i (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm)
//#UC START# *4B6062A203A3_4C5AD2E40027_4C3474B40266_BASE_INIT*
	: m_communicator (comm)
//#UC END# *4B6062A203A3_4C5AD2E40027_4C3474B40266_BASE_INIT*
{
	//#UC START# *4B6062A203A3_4C5AD2E40027_4C3474B40266_BODY*
	GDS_ASSERT (comm);
	GDS_ASSERT (normalizer);

	m_normalizer = Morpho::Def::INormalizer::_duplicate (normalizer);
	//#UC END# *4B6062A203A3_4C5AD2E40027_4C3474B40266_BODY*
}

SynManager_i::~SynManager_i () {
	//#UC START# *4C3474B40266_DESTR_BODY*
	//#UC END# *4C3474B40266_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// создать представление запроса
Search::IRequestView* SynManager_i::make_view (Search::AlgorithmSelector selector) {
	//#UC START# *5391AA6A001A*
	return Search::IRequestViewFactory::make (m_communicator, m_normalizer.in (), selector);
	//#UC END# *5391AA6A001A*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Manage::ISynManager
// синонимизация
Search::IRequestView* SynManager_i::execute (const std::string& in, bool is_default) {
	//#UC START# *4B60638F00A6_4C3474B40266*
	Manage::IRequestTransformer_var transformer = Manage::IRequestTransformerFactory::make (m_normalizer.in ());

	std::string fixed;
	transformer->correct (in, fixed); // корректировка исходного контекста

	if (fixed.empty ()) {
		return 0;
	}

	Defs::StrStrMap pseudo;

	Core::Aptr <GCL::StrVector> res = transformer->execute (
		Synonymizer (m_communicator, m_normalizer.in ()).normalize (fixed)
		, m_communicator->get_exclude_data ()
		, m_communicator->get_hard_phrases ()
		, pseudo
	);

	if (is_default == false) {
		Search::IRequestView_var ret = this->make_view (Search::as_Partial);

		if (ret->build (*res, pseudo, fixed)) {
			return ret._retn ();
		}
	}

	Search::IRequestView_var ret = this->make_view (Search::as_Default);

	ret->build (*res, pseudo, fixed);
	return ret._retn ();
	//#UC END# *4B60638F00A6_4C3474B40266*
}
} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

