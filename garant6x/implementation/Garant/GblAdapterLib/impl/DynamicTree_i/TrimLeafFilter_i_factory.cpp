////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimLeafFilter_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TrimLeafFilter_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimLeafFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimLeafFilter_i.h"

namespace GblAdapterLib {

TrimLeafFilter_i_factory::TrimLeafFilter_i_factory () {
}

void TrimLeafFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TrimLeafFilterFactoryManager::register_factory (this, priority);
}

const char* TrimLeafFilter_i_factory::key () const {
	return "TrimLeafFilter_i";
}

TrimLeafFilter* TrimLeafFilter_i_factory::make () {
	TrimLeafFilter_i_var ret = new TrimLeafFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

