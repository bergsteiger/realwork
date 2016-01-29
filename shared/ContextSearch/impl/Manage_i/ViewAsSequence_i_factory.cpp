////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSequence_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSequence_i
//
// ������������� ������� � ���� ������������������ ������������ ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSequence_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSequence_i.h"

namespace ContextSearch {
namespace Manage_i {

ViewAsSequence_i_factory::ViewAsSequence_i_factory () {
}

void ViewAsSequence_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Search::IRequestViewFactoryManager::register_factory (this, priority);
}

const Search::AlgorithmSelector ViewAsSequence_i_factory::key () const {
	return Search::as_Default;
}

Search::IRequestView* ViewAsSequence_i_factory::make (
	DBComm::IDBCommunicator* comm
	, Morpho::Def::INormalizer* normalizer
) {
	ViewAsSequence_i_var ret = new ViewAsSequence_i (comm, normalizer);
	return ret._retn ();
}

} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

