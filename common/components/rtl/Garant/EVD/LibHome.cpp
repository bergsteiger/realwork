////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/rtl/Garant/EVD/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> Shared Delphi::EVD
//
// �������� ������ � ������ ��� ��������� ���������� � ������� EVD.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "common/components/rtl/Garant/EVD/LibHome.h"

namespace EVD {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *467A8734039C_ENVIRONMENTS_CONFIG*
	//#UC END# *467A8734039C_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace EVD

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
