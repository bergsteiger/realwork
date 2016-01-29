////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::DecisionsArchiveSupport_i
//
// ��������� ������� � ������� �������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i.h"

namespace GblAdapterLib {

DecisionsArchiveSupport_i_factory::DecisionsArchiveSupport_i_factory () {
}

void DecisionsArchiveSupport_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DecisionsArchiveSupportFactoryManager::register_factory (this, priority);
}

const char* DecisionsArchiveSupport_i_factory::key () const {
	return "DecisionsArchiveSupport_i";
}

DecisionsArchiveSupport* DecisionsArchiveSupport_i_factory::make () {
	return Core::IObject::_duplicate (DecisionsArchiveSupport_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

