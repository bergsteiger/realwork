////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garantCore::DBExt
//
// ���������� � ����������� ����������������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garantCore/DBExt/LibHome.h"

namespace DBExt {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4EB243C10367_ENVIRONMENTS_CONFIG*
	//#UC END# *4EB243C10367_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
