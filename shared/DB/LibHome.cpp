////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/DB/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::DB
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/DB/LibHome.h"

namespace DB {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4CA367450108_ENVIRONMENTS_CONFIG*
	//#UC END# *4CA367450108_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace DB

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
