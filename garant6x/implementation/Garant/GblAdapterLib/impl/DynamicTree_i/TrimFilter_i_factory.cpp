////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimFilter_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TrimFilter_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimFilter_i.h"

namespace GblAdapterLib {

TrimFilter_i_factory::TrimFilter_i_factory () {
}

void TrimFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TrimFilterFactoryManager::register_factory (this, priority);
}

const char* TrimFilter_i_factory::key () const {
	return "TrimFilter_i";
}

TrimFilter* TrimFilter_i_factory::make () {
	TrimFilter_i_var ret = new TrimFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

