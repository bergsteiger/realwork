////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AdapterFiltersQuery_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AdapterFiltersQuery_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AdapterFiltersQuery_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AdapterFiltersQuery_i.h"

namespace GblAdapterLib {

AdapterFiltersQuery_i_factory::AdapterFiltersQuery_i_factory () {
}

void AdapterFiltersQuery_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	AdapterFiltersQueryFactoryManager::register_factory (this, priority);
}

const char* AdapterFiltersQuery_i_factory::key () const {
	return "AdapterFiltersQuery_i";
}

AdapterFiltersQuery* AdapterFiltersQuery_i_factory::make (QueryType type) {
	AdapterFiltersQuery_i_var ret = new AdapterFiltersQuery_i (type);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

